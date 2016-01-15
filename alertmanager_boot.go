package main

import (
	"fmt"
	"log"
	"os"
	"syscall"
	"text/template"

	"github.com/Masterminds/sprig"
	cfg "github.com/jimlawless/cfg"
)

var version = "DEV"

var alertAnnotations = make(map[string]string)

type AlertConfig struct {
	SlackWebhookURL string
	SlackRoom       string
}

var filePath = "/etc/alertmanager/alertmanager.yml"

var config_tmpl = template.Must(template.New("alertmanager").Funcs(sprig.TxtFuncMap()).Parse(alertTemplate))

const (
	alertTemplate = `{{ $alertAnnotations := . }}notification_config {
  name: "alertmanager_deis"
{{ if $alertAnnotations.SlackWebhookURL }}
  slack_config {
    webhook_url: {{ $alertAnnotations.SlackWebhookURL }}
    channel: {{ $alertAnnotations.SlackRoom }}
    send_resolved: true
  }
{{ end }}
}
aggregation_rule {
  repeat_rate_seconds: 3600
  notification_config_name: "alertmanager_deis"
}`
)

func main() {
	log.Printf("Starting alertmanager version %s", version)

	// Note: One could manually create and mount the file for use on non-k8s platforms
	if _, err := os.Stat("/mnt/annotations"); os.IsNotExist(err) {
		log.Fatal("Annotations file not mounted")
	}

	err := cfg.Load("/mnt/annotations", alertAnnotations)
	if err != nil {
		log.Fatalf("Error processing annotations file %s\n", err)
	}

	fmt.Println("Building the alert config")
	alertConfig := buildAlertConfig(alertAnnotations)

	fmt.Println("Writing the alert config")
	if err = writeConfig(alertConfig); err != nil {
		log.Fatalf("Failed to write alert configuration %s\n", err)
	}

	args := []string{"alertmanager", "-config.file=/etc/alertmanager/alertmanager.yml"}
	env := os.Environ()
	execErr := syscall.Exec("/bin/alertmanager", args, env)
	if execErr != nil {
		log.Fatalf("Alertmanager quit unexpectedly: %s\n", execErr)
	}
}

func buildAlertConfig(alertAnnotations map[string]string) *AlertConfig {
	a := new(AlertConfig)
	if alertAnnotations["deis.io/slackwebhookurl"] != "" && alertAnnotations["deis.io/slackroom"] != "" {
		a.SlackWebhookURL = alertAnnotations["deis.io/slackwebhookurl"]
		a.SlackRoom = alertAnnotations["deis.io/slackroom"]
	}
	return a
}

func writeConfig(alertConfig *AlertConfig) error {
	file, err := os.Create(filePath)
	if err != nil {
		return err
	}
	err = config_tmpl.Execute(file, alertConfig)
	if err != nil {
		return err
	}
	return nil
}

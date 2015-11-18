package main

import (
	"errors"
	"log"
	"os"
	"strconv"
	"time"

	"golang.org/x/net/context"

	"github.com/coreos/etcd/client"
)

func main() {
	var etcdTTL int
	var etcdPort string

	if os.Getenv("ETCD_PORT") == "" {
		etcdPort = "4001"
	} else {
		etcdPort = os.Getenv("ETCD_PORT")
	}

	if os.Getenv("ETCD_TTL") == "" {
		etcdTTL = 20
	} else {
		etcdTTL, _ = strconv.Atoi(os.Getenv("ETCD_TTL"))
	}

	cfg := client.Config{
		Endpoints: []string{"http://" + os.Getenv("HOST") + ":" + etcdPort},
		Transport: client.DefaultTransport,
		// set timeout per request to fail fast when the target endpoint is unavailable
		HeaderTimeoutPerRequest: time.Duration(time.Second),
	}

	c, err := client.New(cfg)
	if err != nil {
		log.Fatal(err)
	}

	kapi := client.NewKeysAPI(c)

	ctx, _ := context.WithTimeout(context.TODO(), 100*time.Millisecond)

	etcdErr := errors.New("waiting for etcd")

	for etcdErr != nil {
		log.Print(etcdErr.Error())
		_, etcdErr = kapi.Get(ctx, "/", &client.GetOptions{Recursive: false, Sort: false, Quorum: true})
		time.Sleep(time.Duration(etcdTTL) * time.Second)
	}
}

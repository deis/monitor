package main

import (
	"log"
	"os"
	"strconv"
	"time"

	"golang.org/x/net/context"

	"github.com/coreos/etcd/client"
)

func main() {
	var etcd_ttl int
	var etcd_port string

	if os.Getenv("ETCD_PORT") == "" {
		etcd_port = "4001"
	} else {
		etcd_port = os.Getenv("ETCD_PORT")
	}

	if os.Getenv("ETCD_TTL") == "" {
		etcd_ttl = 20
	} else {
		etcd_ttl, _ = strconv.Atoi(os.Getenv("ETCD_TTL"))
	}
	// export ETCD_PORT="${ETCD_PORT:-4001}"
	// export ETCD="$HOST:$ETCD_PORT"
	// export ETCD_PATH="${ETCD_PATH:-/deis/monitor}"
	// export ETCD_TTL="${ETCD_TTL:-20}"

	cfg := client.Config{
		Endpoints: []string{"http://" + os.Getenv("HOST") + ":" + etcd_port},
		Transport: client.DefaultTransport,
		// set timeout per request to fail fast when the target endpoint is unavailable
		HeaderTimeoutPerRequest: time.Duration(etcd_ttl),
	}
	c, err := client.New(cfg)
	if err != nil {
		log.Fatal(err)
	}

	kapi := client.NewKeysAPI(c)
	// set "/foo" key with "bar" value
	log.Print("Setting '/foo' key with 'bar' value")

	ctx, _ := context.WithTimeout(context.TODO(), 100*time.Millisecond)

	resp, err := kapi.Get(ctx, "/", &client.GetOptions{Recursive: false, Sort: false, Quorum: true})
}

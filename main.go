package main

import (
	"os"

	"github.com/blokje5/chaos-experiments/cmd"
)

func main() {
	if err := cmd.NewRootCommand().Execute(); err != nil {
		os.Exit(1)
	}
}

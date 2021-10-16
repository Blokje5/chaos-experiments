package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"github.com/blokje5/chaos-experiments/sample-applications/basic"
)

func NewStartCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "start",
		Short: "start the sample application",
		Run: func(cmd *cobra.Command, args []string) {
			start()
		},
	}

	return cmd
}

func start() {
	if err := basic.Start(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

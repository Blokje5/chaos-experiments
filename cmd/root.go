package cmd

import (
	"github.com/spf13/cobra"
)

func NewRootCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:          "sample-app <subcommand>",
		SilenceUsage: true,
	}

	cmd.AddCommand(NewStartCommand())

	return cmd
}
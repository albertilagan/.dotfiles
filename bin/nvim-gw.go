package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func IssueCommand(command string, args []string) ([]string, error) {
	cmd := exec.Command("bash", "-c", command)

	if len(args) > 0 {
		cmd.Args = append(cmd.Args, args...)
	}

	out, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	lines := strings.Split(strings.TrimSpace(string(out)), "\n")
	return lines, nil
}

func isGitInitialized() bool {
	command := "git worktree list"
	args := []string{}
	output, err := IssueCommand(command, args)
	if err != nil {
		return false
	}
	for _, line := range output {
		if strings.Contains(line, "fatal") {
			return false
		}
	}
	return true
}

func getWorktreeList() ([]map[string]string, error) {
	command := "git worktree list"
	args := []string{}

	output, err := IssueCommand(command, args)
	if err != nil {
		return nil, err
	}

	worktrees := make([]map[string]string, 0)

	for _, line := range output {
		if line != "" {
			parts := strings.Fields(line)
			path := parts[0]
			commit := parts[1]
			if parts[1] != "(bare)" {
				branch := strings.Trim(parts[2], "[]")
				worktree := map[string]string{
					"path":   path,
					"commit": commit,
					"branch": branch,
				}
				worktrees = append(worktrees, worktree)
			}
		}
	}

	return worktrees, nil
}

func selectPath(worktrees []map[string]string) (string, error) {
	var paths []string
	for _, wt := range worktrees {
		paths = append(paths, wt["branch"])
	}

	joined := strings.Join(paths, "\n")
	command := "fzf --print0 --exit-0 --height 20"
	cmd := exec.Command("bash", "-c", command)
	cmd.Stdin = strings.NewReader(joined)
	cmd.Stderr = os.Stderr

	out, err := cmd.Output()
	if err != nil {
		return "", err
	}

	selectedPath := strings.TrimSpace(string(out))
	if selectedPath == "" {
		return "", fmt.Errorf("No path selected")
	}

	return selectedPath, nil
}

func main() {
	if !isGitInitialized() {
		return
	}
	worktrees, err := getWorktreeList()
	if err != nil {
		return
	}

	// if (len(worktrees)) == 1 {
	// 	fmt.Printf("%s\n", worktrees[0]["path"])
	// 	return
	// }

	selectedBranch, err := selectPath(worktrees)
	if err != nil {
		return
	}

	selectedBranch = strings.TrimRight(selectedBranch, "\x00") // Trim null character

	var selectedPath string
	for _, wt := range worktrees {
		if wtBranch := strings.TrimSpace(wt["branch"]); wtBranch == selectedBranch {
			selectedPath = wt["path"]
			break
		}
	}

	if selectedPath == "" {
		return
	}

	fmt.Println(selectedPath)
}

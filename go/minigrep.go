/*
* Minigrep in Go
 */

package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	// Get args
	args := os.Args[1:]
	if len(args) < 2 {
		fmt.Println("Usage: minigrep <query> <filename>")
		os.Exit(1)
	}
	query := args[0]
	filename := args[1]

	// Get file	contents
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer file.Close()

	i, found := 0, 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.Contains(line, query) {
			fmt.Printf("%d: %s\n", i, line)
			found++
		}
		i++
	}

	if found == 0 {
		fmt.Println("No match found")
	}
}

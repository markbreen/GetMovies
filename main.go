package main

import (
	"bufio"
	"fmt"
	"log"
	"math/rand"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"github.com/fatih/color"
)

func main() {
	// Initialize random seed
	rand.Seed(time.Now().UnixNano())

	// Set up logging
	log.SetPrefix("[GetMovies] ")
	log.SetFlags(log.Ltime)

	// Get config and history file paths
	configDir := getConfigDir()
	configFile := filepath.Join(configDir, "getmovies_config.txt")
	recentFile := filepath.Join(configDir, "recent_searches.txt")

	// Create config directory if it doesn't exist
	os.MkdirAll(configDir, 0755)

	// Initialize app state
	state := &AppState{
		ConfigFile: configFile,
		RecentFile: recentFile,
		Version:    "3.0",
	}

	// Load configuration
	config, err := LoadConfig(configFile)
	if err != nil {
		log.Printf("Error loading config: %v", err)
	}
	state.Config = config

	// Check if we should use quick mode
	state.UseQuickMode = CheckQuickMode(recentFile)

	// Show splash screen
	ShowSplash(state.UseQuickMode)

	// Main menu loop
	reader := bufio.NewReader(os.Stdin)
	for {
		ShowMenu(state)

		cyan := color.New(color.FgCyan).SprintFunc()
		fmt.Printf("    %s ", cyan("ENTER COMMAND >>>"))

		choice, _ := reader.ReadString('\n')
		choice = strings.TrimSpace(choice)

		switch choice {
		case "1":
			handleSearch(state, reader)
		case "2":
			handleRecentSearches(state, reader)
		case "5":
			handleChangeUsername(state, reader)
		case "X", "x":
			handleExit(state)
			return
		default:
			ShowError("COMMAND NOT RECOGNIZED - TRY AGAIN")
			time.Sleep(1 * time.Second)
		}
	}
}

// handleSearch performs a new search
func handleSearch(state *AppState, reader *bufio.Reader) {
	ClearScreen()

	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()

	fmt.Println()
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println(yellow("    |                    MOVIE SEARCH DATABASE Version 3.0                        |"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()
	fmt.Printf("    %s ", green("ENTER MOVIE/TV SHOW NAME:"))

	searchTerm, _ := reader.ReadString('\n')
	searchTerm = strings.TrimSpace(searchTerm)

	if searchTerm == "" {
		ShowError("SEARCH TERM CANNOT BE EMPTY!")
		fmt.Println("    Press ENTER to continue...")
		reader.ReadString('\n')
		return
	}

	// Save to history
	err := SaveRecentSearch(state.RecentFile, searchTerm)
	if err != nil {
		log.Printf("Error saving search: %v", err)
	}

	// Update quick mode check
	state.UseQuickMode = CheckQuickMode(state.RecentFile)

	// Perform search
	ClearScreen()
	torrents, err := SearchTorrents(searchTerm, 10, false, state.UseQuickMode)
	if err != nil {
		ShowError(err.Error())
		fmt.Println("    Press ENTER to continue...")
		reader.ReadString('\n')
		return
	}

	// Display results
	ShowResults(torrents, searchTerm)

	// Result options
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Printf(color.WhiteString("    | [20] SHOW 20 | [30] SHOW 30 | [B] BACK TO MENU   |\n"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()
	fmt.Printf("    %s ", yellow("SELECT OPTION >>>"))

	selection, _ := reader.ReadString('\n')
	selection = strings.TrimSpace(selection)

	switch selection {
	case "20":
		ClearScreen()
		torrents, err := SearchTorrents(searchTerm, 20, true, state.UseQuickMode)
		if err != nil {
			ShowError(err.Error())
		} else {
			ShowResults(torrents, searchTerm)
		}
		fmt.Println("    Press ENTER to continue...")
		reader.ReadString('\n')
	case "30":
		ClearScreen()
		torrents, err := SearchTorrents(searchTerm, 30, true, state.UseQuickMode)
		if err != nil {
			ShowError(err.Error())
		} else {
			ShowResults(torrents, searchTerm)
		}
		fmt.Println("    Press ENTER to continue...")
		reader.ReadString('\n')
	case "B", "b", "":
		return
	}
}

// handleRecentSearches shows and allows re-searching from history
func handleRecentSearches(state *AppState, reader *bufio.Reader) {
	ClearScreen()

	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()
	gray := color.New(color.FgHiBlack).SprintFunc()
	white := color.New(color.FgWhite).SprintFunc()
	red := color.New(color.FgRed).SprintFunc()

	fmt.Println()
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println(yellow("    |                    RECENT SEARCH HISTORY Version 3.0                        |"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()

	searches, err := LoadRecentSearches(state.RecentFile)
	if err != nil || len(searches) == 0 {
		fmt.Println(red("    MEMORY BANK EMPTY - NO SEARCH HISTORY"))
		fmt.Println(yellow("    TIP: SEARCH FOR MOVIES TO BUILD HISTORY"))
		fmt.Println()
		fmt.Println("    Press ENTER to continue...")
		reader.ReadString('\n')
		return
	}

	fmt.Println(green("    LOADING SEARCH CACHE..."))
	fmt.Println(green("    MEMORY BANK: ACCESSED"))
	fmt.Println()

	for i, search := range searches {
		fmt.Printf(yellow("    [%d] %s\n"), i+1, search)
		fmt.Printf(gray("        TIMESTAMP: %s\n"), time.Now().Format("01/02 15:04"))
	}

	fmt.Println()
	fmt.Println(cyan("    +----------------------------------------------------------------------+"))
	fmt.Printf(white("    | [1-%d] RE-SEARCH | [C] CLEAR HISTORY | [B] BACK TO MENU         |\n"), len(searches))
	fmt.Println(cyan("    +----------------------------------------------------------------------+"))
	fmt.Println()
	fmt.Printf("    %s ", yellow("SELECT OPTION >>>"))

	choice, _ := reader.ReadString('\n')
	choice = strings.TrimSpace(choice)

	if choice == "C" || choice == "c" {
		err := ClearHistory(state.RecentFile)
		if err != nil {
			ShowError("Failed to clear history")
		} else {
			fmt.Println(red("    SEARCH HISTORY CLEARED!"))
			fmt.Println(red("    MEMORY BANK: WIPED"))
		}
		time.Sleep(2 * time.Second)
		return
	}

	if choice == "B" || choice == "b" || choice == "" {
		return
	}

	// Try to parse as number
	idx, err := strconv.Atoi(choice)
	if err == nil && idx >= 1 && idx <= len(searches) {
		searchTerm := searches[idx-1]
		fmt.Printf(green("    RE-SEARCHING FOR: %s\n"), searchTerm)
		time.Sleep(1 * time.Second)

		// Update history (move to top)
		SaveRecentSearch(state.RecentFile, searchTerm)
		state.UseQuickMode = CheckQuickMode(state.RecentFile)

		// Perform search
		ClearScreen()
		torrents, err := SearchTorrents(searchTerm, 10, false, state.UseQuickMode)
		if err != nil {
			ShowError(err.Error())
			fmt.Println("    Press ENTER to continue...")
			reader.ReadString('\n')
			return
		}

		ShowResults(torrents, searchTerm)
		fmt.Println("    Press ENTER to continue...")
		reader.ReadString('\n')
	} else {
		ShowError("INVALID SELECTION")
		time.Sleep(1 * time.Second)
	}
}

// handleChangeUsername allows changing the username
func handleChangeUsername(state *AppState, reader *bufio.Reader) {
	ClearScreen()

	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()

	fmt.Println()
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println(yellow("    |                    CHANGE USERNAME                                   |"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()
	fmt.Printf(green("    CURRENT USERNAME: %s\n"), state.Config.Username)
	fmt.Println()
	fmt.Printf("    %s ", cyan("ENTER NEW USERNAME:"))

	newName, _ := reader.ReadString('\n')
	newName = strings.TrimSpace(newName)

	if newName == "" {
		ShowWarning("Username cannot be empty")
		time.Sleep(2 * time.Second)
		return
	}

	state.Config.Username = newName
	err := SaveConfig(state.ConfigFile, state.Config)
	if err != nil {
		ShowError("Failed to save configuration")
		log.Printf("Error saving config: %v", err)
	} else {
		fmt.Println()
		fmt.Printf(green("    USERNAME UPDATED TO: %s\n"), strings.ToUpper(newName))
		fmt.Println(yellow("    IDENTITY RECONFIGURED!"))
	}
	time.Sleep(2 * time.Second)
}

// handleExit shows exit message and quits
func handleExit(state *AppState) {
	ClearScreen()

	red := color.New(color.FgRed).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	cyan := color.New(color.FgCyan).SprintFunc()
	white := color.New(color.FgWhite).SprintFunc()

	username := state.Config.Username
	if username == "" {
		username = "User"
	}

	fmt.Println()
	fmt.Println(red("    +======================================================================+"))
	fmt.Println(red("    |                                                                      |"))
	fmt.Printf(yellow("    |             THANK YOU FOR USING Get Movies %-4s                       |\n"), state.Version)
	fmt.Println(red("    |                                                                      |"))
	fmt.Printf(cyan("    |                   HAPPY WATCHING, %s!%-13s|\n"), strings.ToUpper(username), "")
	fmt.Println(red("    |                                                                      |"))
	fmt.Println(white("    |                     [SYSTEM SHUTDOWN]                                |"))
	fmt.Println(red("    |                                                                      |"))
	fmt.Println(red("    +======================================================================+"))
	fmt.Println()
}

// getConfigDir returns the appropriate config directory for the OS
func getConfigDir() string {
	// Use current directory for simplicity (matches PowerShell version)
	return "."
}

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
		case "3":
			handleChangeUsername(state, reader)
		case "4":
			handleHelp(reader)
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
	fmt.Printf(color.WhiteString("    | [1-%d] VIEW MAGNET | [20] SHOW 20 | [30] SHOW 30 | [B] BACK     |\n"), len(torrents))
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
	default:
		// Try to parse as number for magnet link
		idx, err := strconv.Atoi(selection)
		if err == nil && idx >= 1 && idx <= len(torrents) {
			selectedTorrent := torrents[idx-1]
			if selectedTorrent.MagnetLink != "" {
				ClearScreen()
				ShowMagnetLink(selectedTorrent)
				fmt.Println("    Press ENTER to continue...")
				reader.ReadString('\n')
			} else {
				ShowError("No magnet link available for this torrent")
				time.Sleep(2 * time.Second)
			}
		}
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
		fmt.Printf(yellow("    [%d] %s\n"), i+1, search.Query)

		// Format timestamp nicely
		elapsed := time.Since(search.Timestamp)
		var timeStr string
		if elapsed.Minutes() < 60 {
			timeStr = fmt.Sprintf("%.0f minutes ago", elapsed.Minutes())
		} else if elapsed.Hours() < 24 {
			timeStr = fmt.Sprintf("%.0f hours ago", elapsed.Hours())
		} else if elapsed.Hours() < 48 {
			timeStr = "yesterday"
		} else {
			timeStr = search.Timestamp.Format("01/02 15:04")
		}
		fmt.Printf(gray("        TIMESTAMP: %s\n"), timeStr)
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
		// Add confirmation
		fmt.Println()
		fmt.Printf("    %s ", red("CLEAR ALL SEARCH HISTORY? (Y/N) >>>"))
		confirm, _ := reader.ReadString('\n')
		confirm = strings.TrimSpace(strings.ToUpper(confirm))

		if confirm == "Y" || confirm == "YES" {
			err := ClearHistory(state.RecentFile)
			if err != nil {
				ShowError("Failed to clear history")
			} else {
				fmt.Println()
				fmt.Println(red("    SEARCH HISTORY CLEARED!"))
				fmt.Println(red("    MEMORY BANK: WIPED"))
			}
			time.Sleep(2 * time.Second)
		} else {
			fmt.Println()
			fmt.Println(green("    OPERATION CANCELLED"))
			time.Sleep(1 * time.Second)
		}
		return
	}

	if choice == "B" || choice == "b" || choice == "" {
		return
	}

	// Try to parse as number
	idx, err := strconv.Atoi(choice)
	if err == nil && idx >= 1 && idx <= len(searches) {
		searchTerm := searches[idx-1].Query
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

// handleHelp shows help and keyboard shortcuts
func handleHelp(reader *bufio.Reader) {
	ClearScreen()

	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()
	white := color.New(color.FgWhite).SprintFunc()

	fmt.Println()
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println(yellow("    |                    HELP & KEYBOARD SHORTCUTS                         |"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()

	fmt.Println(white("    NAVIGATION:"))
	fmt.Println(green("      • B or b          - Go back to previous menu"))
	fmt.Println(green("      • X or x          - Exit application"))
	fmt.Println(green("      • ENTER (empty)   - Usually goes back/continues"))
	fmt.Println()

	fmt.Println(white("    SEARCH OPTIONS:"))
	fmt.Println(green("      • Type movie name - Search for torrents"))
	fmt.Println(green("      • [20]            - Show 20 results"))
	fmt.Println(green("      • [30]            - Show 30 results"))
	fmt.Println()

	fmt.Println(white("    HISTORY:"))
	fmt.Println(green("      • [1-10]          - Re-run a recent search"))
	fmt.Println(green("      • C or c          - Clear all search history"))
	fmt.Println()

	fmt.Println(white("    FEATURES:"))
	fmt.Println(green("      • Quick Mode      - Faster animations if you've searched recently"))
	fmt.Println(green("      • Smart History   - Last 10 searches saved automatically"))
	fmt.Println(green("      • Cross-Platform  - Works on Windows, macOS, and Linux"))
	fmt.Println()

	fmt.Println(white("    TIPS:"))
	fmt.Println(yellow("      • Be specific with search terms for better results"))
	fmt.Println(yellow("      • Check seeder count - higher is better"))
	fmt.Println(yellow("      • Use recent searches for quick re-runs"))
	fmt.Println()

	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()
	fmt.Println(white("    Press ENTER to return to menu..."))
	reader.ReadString('\n')
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

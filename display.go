package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"time"

	"github.com/fatih/color"
)

// ClearScreen clears the terminal
func ClearScreen() {
	fmt.Print("\033[H\033[2J")
}

// ShowSplash displays the BBS-style splash screen
func ShowSplash(useQuickMode bool) {
	ClearScreen()

	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()
	magenta := color.New(color.FgMagenta).SprintFunc()
	gray := color.New(color.FgHiBlack).SprintFunc()

	fmt.Println()
	fmt.Println(cyan("    ============================================================================"))
	fmt.Println(cyan("    ||                                                                        ||"))
	fmt.Println(cyan("    ||  ") + yellow("######  ###### ###### ##   ##  #####  ##  ## ## ###### ###### ######") + cyan(" ||"))
	fmt.Println(cyan("    ||  ") + yellow("##      ##       ##   ### ### ##   ## ##  ## ## ##     ##     ##    ") + cyan(" ||"))
	fmt.Println(cyan("    ||  ") + yellow("## ###  ####     ##   ## # ## ##   ## ##  ## ## ####   ###### ######") + cyan(" ||"))
	fmt.Println(cyan("    ||  ") + yellow("##  ##  ##       ##   ##   ## ##   ##  ####  ## ##         ##     ##") + cyan(" ||"))
	fmt.Println(cyan("    ||  ") + green("######  ######   ##   ##   ##  #####    ##   ## ###### ###### ######") + cyan(" ||"))
	fmt.Println(cyan("    ||                                                                        ||"))
	fmt.Println(cyan("    ============================================================================"))
	fmt.Println()
	fmt.Println(magenta("                        >>>===[ GO EDITION - VERSION 3.0 ]===<<<"))
	fmt.Println()
	fmt.Println(gray("    +------------------------------------------------------------------------+"))
	fmt.Println(gray("    |                                                                        |"))
	fmt.Println("    |                        " + yellow("SYSTEM INITIALIZATION") + "                           |")
	fmt.Println(gray("    |                                                                        |"))

	// Loading animation
	steps := []string{
		"Loading TORRENT.SYS.................... [OK]",
		"Initializing P2P Protocol.............. [OK]",
		"Connecting to Underground Network...... [OK]",
		"Establishing Secure Tunnel............. [OK]",
	}

	delay := 200 * time.Millisecond
	if useQuickMode {
		delay = 20 * time.Millisecond
	}

	for _, step := range steps {
		fmt.Println("    | " + green(step) + "                       |")
		time.Sleep(delay)
	}

	fmt.Println(gray("    |                                                                        |"))
	fmt.Println("    |      " + yellow("ALL SYSTEMS OPERATIONAL - WELCOME TO THE REVOLUTION") + "               |")
	fmt.Println(gray("    |                                                                        |"))
	fmt.Println(gray("    +------------------------------------------------------------------------+"))
	fmt.Println()
	fmt.Println(gray("           COPYRIGHT (C) 2026 PIRATE LIBERATION FRONT - NO RIGHTS RESERVED"))
	fmt.Println()
	fmt.Println(gray("    Press ENTER to continue..."))

	bufio.NewReader(os.Stdin).ReadBytes('\n')
}

// ShowMenu displays the main menu
func ShowMenu(state *AppState) {
	ClearScreen()

	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()
	magenta := color.New(color.FgMagenta).SprintFunc()
	gray := color.New(color.FgHiBlack).SprintFunc()
	white := color.New(color.FgWhite).SprintFunc()

	fmt.Println()
	fmt.Println(magenta("    +======================================================================+"))
	fmt.Println(magenta("    |                                                                      |"))
	fmt.Println(cyan("    |   GGGGG  EEEEE TTTTT   M   M  OOO  V   V III EEEEE  SSSS             |"))
	fmt.Println(cyan("    |  G      E       T     MM MM O   O V   V  I  E     S                  |"))
	fmt.Println(yellow("    |  G  GG  EEEE    T     M M M O   O V   V  I  EEEE   SSS               |"))
	fmt.Println(yellow("    |  G   G  E       T     M   M O   O  V V   I  E         S              |"))
	fmt.Println(green("    |   GGGG  EEEEE   T     M   M  OOO    V   III EEEEE SSSS               |"))
	fmt.Println(magenta("    |                                                                      |"))
	fmt.Println(magenta("    |                    ###############################                   |"))
	fmt.Println(white("    |                    #  RADICAL TORRENT FINDER    #                    |"))
	fmt.Printf(white("    |                    #      Version %-4s          #                    |\n"), state.Version)
	fmt.Println(magenta("    |                    ###############################                   |"))
	fmt.Println(magenta("    |                                                                      |"))
	fmt.Println(magenta("    +======================================================================+"))
	fmt.Println()

	username := state.Config.Username
	if username == "" {
		username = "User"
	}
	welcomeMsg := fmt.Sprintf("WELCOME BACK, %s! READY TO RIP?", username)
	fmt.Println(cyan("    +-") + cyan(welcomeMsg) + cyan("-+"))
	fmt.Println(yellow("    | ") + yellow(welcomeMsg) + yellow(" |"))
	fmt.Println(cyan("    +-") + cyan(welcomeMsg) + cyan("-+"))
	fmt.Println()

	fmt.Println(magenta("    ********************************************************************"))
	fmt.Println(magenta("    *                                                                  *"))
	fmt.Println(white("    *  [1] SEARCH MOVIES & TV SHOWS      [3] CHANGE USER NAME            *"))
	fmt.Println(white("    *  [2] RECENT SEARCHES               [4] HELP & SHORTCUTS          *"))
	fmt.Println(white("    *                                   [X] EXIT TO DOS               *"))
	fmt.Println(magenta("    *                                                                  *"))
	fmt.Println(magenta("    ********************************************************************"))
	fmt.Println()

	// System stats
	cpuTemp := rand.Intn(20) + 45
	ramUsed := rand.Intn(256) + 256
	diskSpeed := rand.Intn(40) + 80
	cpuLoad := rand.Intn(30) + 15
	ping := rand.Intn(130) + 120
	uptimeH := rand.Intn(99) + 1
	uptimeM := rand.Intn(60)

	fmt.Println(gray("    +----------------------------------------------------------------------+"))
	fmt.Println(gray("    | SYSTEM STATUS MONITOR v1.3                                           |"))
	fmt.Println(gray("    +----------------------------------------------------------------------+"))
	fmt.Printf(green("    | CPU: Intel 80486 DX2 66MHz | TEMP: %d°C | LOAD: %d%%                    |\n"), cpuTemp, cpuLoad)
	fmt.Printf(green("    | RAM: %d/640KB | SWAP: ACTIVE | CACHE: OPTIMAL                       |\n"), ramUsed)
	fmt.Printf(green("    | HDD: 420MB FREE | SPEED: %d KB/s | DEFRAG: 3 DAYS AGO               |\n"), diskSpeed)
	fmt.Printf(green("    | MODEM: 56K CONNECTED | PING: %d ms | PACKET LOSS: 0%%                |\n"), ping)
	fmt.Printf(green("    | UPTIME: %d H %d M                                                    |\n"), uptimeH, uptimeM)
	fmt.Println(gray("    +----------------------------------------------------------------------+"))
	fmt.Println()
}

// ShowResults displays search results
func ShowResults(torrents []Torrent, searchTerm string) {
	ClearScreen()

	green := color.New(color.FgGreen).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()

	fmt.Println()
	fmt.Println(green("    +======================================================================+"))
	fmt.Println(green("    |                      SEARCH RESULTS FOUND!                           |"))
	fmt.Println(green("    +======================================================================+"))
	fmt.Printf(yellow("    | SEARCH QUERY: %s\n"), searchTerm)
	fmt.Println(green("    +======================================================================+"))
	fmt.Println()

	for i, t := range torrents {
		name := t.Name
		if len(name) > 60 {
			name = name[:57] + "..."
		}
		fmt.Printf(yellow("    [%d] %s\n"), i+1, name)
		magnetStatus := "AVAILABLE"
		if t.MagnetLink == "" {
			magnetStatus = "N/A"
		}
		fmt.Printf(green("        SIZE: %s | SEEDS: %s | MAGNET: %s\n"), t.Size, t.Seeders, magnetStatus)
		fmt.Println()
	}
}

// ShowMagnetLink displays a magnet link
func ShowMagnetLink(torrent Torrent) {
	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()

	fmt.Println()
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println(yellow("    |                         MAGNET LINK                                  |"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()
	fmt.Printf(yellow("    TORRENT: %s\n"), torrent.Name)
	fmt.Println()
	fmt.Println(green("    MAGNET LINK:"))
	fmt.Printf(green("    %s\n"), torrent.MagnetLink)
	fmt.Println()
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println(yellow("    Copy the link above and paste it into your torrent client"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()
}

// ShowError displays an error message
func ShowError(message string) {
	red := color.New(color.FgRed).SprintFunc()
	fmt.Printf("\n    %s\n\n", red("ERROR: "+message))
}

// ShowSuccess displays a success message
func ShowSuccess(message string) {
	green := color.New(color.FgGreen).SprintFunc()
	fmt.Printf("\n    %s\n\n", green(message))
}

// ShowWarning displays a warning message
func ShowWarning(message string) {
	yellow := color.New(color.FgYellow).SprintFunc()
	fmt.Printf("\n    %s\n\n", yellow("WARNING: "+message))
}

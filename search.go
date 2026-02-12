package main

import (
	"fmt"
	"log"
	"net/http"
	"net/url"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/fatih/color"
)

// SearchTorrents searches for torrents and returns results
func SearchTorrents(searchTerm string, resultCount int, skipAnimation bool, useQuickMode bool) ([]Torrent, error) {
	// Show search header
	cyan := color.New(color.FgCyan).SprintFunc()
	yellow := color.New(color.FgYellow).SprintFunc()
	green := color.New(color.FgGreen).SprintFunc()

	fmt.Println()
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println(yellow("    |                    MOVIE SEARCH DATABASE Version 3.0                        |"))
	fmt.Println(cyan("    +======================================================================+"))
	fmt.Println()
	fmt.Printf(green("    SEARCHING FOR: %s\n"), strings.ToUpper(searchTerm))
	fmt.Println()
	fmt.Printf(cyan("    RESULTS TO DISPLAY: %d\n"), resultCount)
	fmt.Println()

	// Encode search term
	encodedSearch := url.QueryEscape(searchTerm)
	searchURL := fmt.Sprintf("https://thepiratebay10.info/search/%s/1/99/200", encodedSearch)

	if !skipAnimation {
		// Loading animation
		var stepDelay time.Duration
		var loadingSteps []string

		if useQuickMode {
			// Quick mode: minimal animation
			stepDelay = 10 * time.Millisecond
			fmt.Println(green("    INITIALIZING SEARCH MATRIX [QUICK MODE]..."))
			loadingSteps = []string{
				"CONNECTING TO PIRATE DATABASE...",
				"SCANNING FOR SEEDERS...",
				"OPTIMIZING DOWNLOAD QUEUE...",
			}
		} else {
			// Normal mode: full animation
			stepDelay = 500 * time.Millisecond
			fmt.Println(yellow("    INITIALIZING SEARCH MATRIX..."))
			loadingSteps = []string{
				"CONNECTING TO PIRATE DATABASE...",
				"BYPASSING SECURITY PROTOCOLS...",
				"ACCESSING TORRENT MAINFRAME...",
				"DECRYPTING MAGNET LINKS...",
				"SCANNING FOR SEEDERS...",
				"INITIALIZING P2P CONNECTIONS...",
				"VERIFYING TRACKER RESPONSES...",
				"ALLOCATING BANDWIDTH RESOURCES...",
				"ESTABLISHING PEER HANDSHAKES...",
				"DOWNLOADING TORRENT METADATA...",
				"CHECKING FILE INTEGRITY...",
				"OPTIMIZING DOWNLOAD QUEUE...",
			}
		}

		totalSteps := len(loadingSteps)
		for i, step := range loadingSteps {
			percentComplete := int(float64(i+1) / float64(totalSteps) * 100)
			fmt.Printf("\r%s\n", green(step))
			fmt.Print("[")
			barLength := percentComplete / 5
			for j := 0; j < barLength; j++ {
				fmt.Print(yellow("#"))
			}
			for j := barLength; j < 20; j++ {
				fmt.Print("-")
			}
			fmt.Printf("] %d%%\n", percentComplete)
			time.Sleep(stepDelay)
		}

		fmt.Println()
		if useQuickMode {
			// Quick mode: instant completion
			fmt.Println(green("[Yea-Buffering====================================] 100% COMPLETE"))
		} else {
			// Normal mode: animated buffer
			fmt.Print(green("[Yea-Buffering"))
			for i := 0; i < 36; i++ {
				fmt.Print(green("="))
				time.Sleep(50 * time.Millisecond)
			}
			fmt.Println(green("] 100% COMPLETE"))
		}
	} else {
		fmt.Println(yellow("    REFRESHING RESULTS..."))
		time.Sleep(500 * time.Millisecond)
	}

	// Create HTTP client with timeout
	client := &http.Client{
		Timeout: 30 * time.Minute,
	}

	// Make request
	resp, err := client.Get(searchURL)
	if err != nil {
		log.Printf("Error fetching URL: %v", err)
		return nil, fmt.Errorf("connection failed: check your internet connection")
	}
	defer resp.Body.Close()

	// Parse HTML
	doc, err := goquery.NewDocumentFromReader(resp.Body)
	if err != nil {
		log.Printf("Error parsing HTML: %v", err)
		return nil, fmt.Errorf("failed to parse results")
	}

	// Extract torrents
	var torrents []Torrent
	doc.Find("table tr").Each(func(i int, s *goquery.Selection) {
		if i == 0 {
			return // Skip header row
		}
		if i > resultCount {
			return // Limit results
		}

		cells := s.Find("td")
		if cells.Length() >= 6 {
			name := strings.TrimSpace(cells.Eq(1).Text())
			size := strings.TrimSpace(cells.Eq(4).Text())
			seeders := strings.TrimSpace(cells.Eq(5).Text())

			// Extract magnet link
			magnetLink := ""
			cells.Eq(1).Find("a[href^='magnet:']").Each(func(_ int, link *goquery.Selection) {
				if href, exists := link.Attr("href"); exists {
					magnetLink = href
				}
			})

			if name != "" {
				torrents = append(torrents, Torrent{
					Name:       name,
					Size:       size,
					Seeders:    seeders,
					MagnetLink: magnetLink,
				})
			}
		}
	})

	if len(torrents) == 0 {
		return nil, fmt.Errorf("no results found")
	}

	return torrents, nil
}

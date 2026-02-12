package main

import (
	"bufio"
	"os"
	"strings"
	"time"
)

// LoadRecentSearches loads search history from text file
func LoadRecentSearches(recentFile string) ([]string, error) {
	file, err := os.Open(recentFile)
	if err != nil {
		// File doesn't exist yet
		return []string{}, nil
	}
	defer file.Close()

	var searches []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line != "" {
			searches = append(searches, line)
		}
	}

	return searches, scanner.Err()
}

// SaveRecentSearch adds a search to history (keeps last 10)
func SaveRecentSearch(recentFile string, searchTerm string) error {
	// Load existing searches
	searches, err := LoadRecentSearches(recentFile)
	if err != nil {
		searches = []string{}
	}

	// Remove duplicates of this search
	var filtered []string
	for _, s := range searches {
		if s != searchTerm {
			filtered = append(filtered, s)
		}
	}

	// Add new search at the beginning
	newSearches := append([]string{searchTerm}, filtered...)

	// Keep only last 10
	if len(newSearches) > 10 {
		newSearches = newSearches[:10]
	}

	// Write to file
	file, err := os.Create(recentFile)
	if err != nil {
		return err
	}
	defer file.Close()

	for _, s := range newSearches {
		file.WriteString(s + "\n")
	}

	return nil
}

// CheckQuickMode checks if we should use quick mode (searched within last 60 minutes)
func CheckQuickMode(recentFile string) bool {
	info, err := os.Stat(recentFile)
	if err != nil {
		return false
	}

	timeDiff := time.Since(info.ModTime())
	return timeDiff.Minutes() <= 60
}

// ClearHistory deletes the search history file
func ClearHistory(recentFile string) error {
	return os.Remove(recentFile)
}

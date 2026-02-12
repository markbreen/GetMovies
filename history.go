package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"time"
)

// LoadRecentSearches loads search history from text file
func LoadRecentSearches(recentFile string) ([]SearchHistoryEntry, error) {
	file, err := os.Open(recentFile)
	if err != nil {
		// File doesn't exist yet
		return []SearchHistoryEntry{}, nil
	}
	defer file.Close()

	var searches []SearchHistoryEntry
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line == "" {
			continue
		}

		// Parse format: timestamp|query
		parts := strings.SplitN(line, "|", 2)
		if len(parts) == 2 {
			timestamp, err := time.Parse(time.RFC3339, parts[0])
			if err != nil {
				// Old format without timestamp, use current time
				searches = append(searches, SearchHistoryEntry{
					Timestamp: time.Now(),
					Query:     line,
				})
			} else {
				searches = append(searches, SearchHistoryEntry{
					Timestamp: timestamp,
					Query:     parts[1],
				})
			}
		} else {
			// Old format without timestamp
			searches = append(searches, SearchHistoryEntry{
				Timestamp: time.Now(),
				Query:     line,
			})
		}
	}

	return searches, scanner.Err()
}

// SaveRecentSearch adds a search to history (keeps last 10)
func SaveRecentSearch(recentFile string, searchTerm string) error {
	// Load existing searches
	searches, err := LoadRecentSearches(recentFile)
	if err != nil {
		searches = []SearchHistoryEntry{}
	}

	// Remove duplicates of this search
	var filtered []SearchHistoryEntry
	for _, s := range searches {
		if s.Query != searchTerm {
			filtered = append(filtered, s)
		}
	}

	// Add new search at the beginning with current timestamp
	newEntry := SearchHistoryEntry{
		Timestamp: time.Now(),
		Query:     searchTerm,
	}
	newSearches := append([]SearchHistoryEntry{newEntry}, filtered...)

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
		file.WriteString(fmt.Sprintf("%s|%s\n", s.Timestamp.Format(time.RFC3339), s.Query))
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

package main

import "time"

// Torrent represents a torrent search result
type Torrent struct {
	Name    string
	Size    string
	Seeders string
}

// Config holds user configuration
type Config struct {
	Username     string
	SplashScreen string
}

// AppState holds application state
type AppState struct {
	Config        Config
	RecentFile    string
	ConfigFile    string
	LastSearched  time.Time
	UseQuickMode  bool
	Version       string
}

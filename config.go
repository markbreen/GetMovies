package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// LoadConfig loads user configuration from text file
func LoadConfig(configFile string) (Config, error) {
	config := Config{
		Username:     "User",
		SplashScreen: "1",
	}

	file, err := os.Open(configFile)
	if err != nil {
		// File doesn't exist, do first-time setup
		return firstTimeSetup(configFile)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "username:") {
			config.Username = strings.TrimSpace(strings.TrimPrefix(line, "username:"))
		} else if strings.HasPrefix(line, "splashscreen:") {
			config.SplashScreen = strings.TrimSpace(strings.TrimPrefix(line, "splashscreen:"))
		}
	}

	return config, scanner.Err()
}

// SaveConfig saves user configuration to text file
func SaveConfig(configFile string, config Config) error {
	file, err := os.Create(configFile)
	if err != nil {
		return err
	}
	defer file.Close()

	_, err = fmt.Fprintf(file, "username:%s\nsplashscreen:%s\n", config.Username, config.SplashScreen)
	return err
}

// firstTimeSetup performs initial configuration
func firstTimeSetup(configFile string) (Config, error) {
	ClearScreen()

	magenta := "\033[35m"
	yellow := "\033[33m"
	green := "\033[32m"
	cyan := "\033[36m"
	reset := "\033[0m"

	fmt.Println()
	fmt.Printf("    %s+======================================================================+%s\n", magenta, reset)
	fmt.Printf("    %s|                    FIRST TIME SETUP DETECTED                         |%s\n", yellow, reset)
	fmt.Printf("    %s+======================================================================+%s\n", magenta, reset)
	fmt.Println()
	fmt.Printf("    %sINITIALIZING USER PROFILE...%s\n", green, reset)
	fmt.Printf("    %sCREATING PERSONAL CONFIGURATION...%s\n", green, reset)
	fmt.Println()
	fmt.Printf("    %sENTER YOUR NAME FOR PERSONALIZATION: %s", cyan, reset)

	reader := bufio.NewReader(os.Stdin)
	name, _ := reader.ReadString('\n')
	name = strings.TrimSpace(name)

	if name == "" {
		name = "User"
	}

	config := Config{
		Username:     name,
		SplashScreen: "1",
	}

	err := SaveConfig(configFile, config)
	if err != nil {
		return config, err
	}

	fmt.Println()
	fmt.Printf("    %sPROFILE CREATED FOR: %s%s\n", green, strings.ToUpper(name), reset)
	fmt.Printf("    %sWELCOME TO THE UNDERGROUND!%s\n", yellow, reset)
	fmt.Println()

	return config, nil
}

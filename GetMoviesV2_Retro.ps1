# GetMovies V2.1 - 1980s Retro Style

# Global configuration
$Script:ApplicationVersion = "2.1"
$Script:ConfigFile = "$PSScriptRoot\getmovies_config.txt"
$Script:UserName = "User"
$Script:SplashScreen = "1"  # Default splash screen


# Load user configuration
function Load-UserConfig {
    if (Test-Path $Script:ConfigFile) {
        $configLines = Get-Content $Script:ConfigFile
        foreach ($line in $configLines) {
            if ($line -match "^username:(.+)$") {
                $Script:UserName = $matches[1].Trim()
            }
            elseif ($line -match "^splashscreen:(.+)$") {
                $Script:SplashScreen = $matches[1].Trim()
            }
        }
    } else {
        # First time setup
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Magenta
        Write-Host "    |                    FIRST TIME SETUP DETECTED                         |" -ForegroundColor Yellow
        Write-Host "    +======================================================================+" -ForegroundColor Magenta
        Write-Host ""
        Write-Host "    INITIALIZING USER PROFILE..." -ForegroundColor Green
        Start-Sleep -Milliseconds 500
        Write-Host "    CREATING PERSONAL CONFIGURATION..." -ForegroundColor Green
        Start-Sleep -Milliseconds 500
        Write-Host ""
        Write-Host "    ENTER YOUR NAME FOR PERSONALIZATION: " -NoNewline -ForegroundColor Cyan
        $newName = Read-Host

        if ([string]::IsNullOrWhiteSpace($newName)) {
            $newName = "User"
        }

        $Script:UserName = $newName
        @("username:$newName", "splashscreen:$($Script:SplashScreen)") | Set-Content $Script:ConfigFile

        Write-Host ""
        Write-Host "    PROFILE CREATED FOR: $(([string]$Script:UserName).ToUpper())" -ForegroundColor Green
        Write-Host "    WELCOME TO THE UNDERGROUND!" -ForegroundColor Yellow
        Start-Sleep -Seconds 2
    }
}

# Splash screen definitions
$Script:SplashScreens = @{
    "1" = @{Name = "BBS Terminal"; File = "mock1.ps1"}
    "2" = @{Name = "BBC Micro"; File = "mock2.ps1"}
    "3" = @{Name = "C64 BASIC"; File = "mock3.ps1"}
    "4" = @{Name = "War Games"; File = "mock4.ps1"}
    "5" = @{Name = "Amiga Workbench"; File = "mock5.ps1"}
    "6" = @{Name = "Norton Commander"; File = "mock6.ps1"}
    "7" = @{Name = "Arcade Cabinet"; File = "mock7.ps1"}
    "8" = @{Name = "Apple II"; File = "mock8.ps1"}
    "9" = @{Name = "ZX Spectrum"; File = "mock9.ps1"}
    "10" = @{Name = "Atari 800"; File = "mock10.ps1"}
    "11" = @{Name = "TRS-80"; File = "mock11.ps1"}
    "12" = @{Name = "MSX Computer"; File = "mock12.ps1"}
    "13" = @{Name = "VIC-20"; File = "mock13.ps1"}
    "14" = @{Name = "Tandy CoCo"; File = "mock14.ps1"}
    "15" = @{Name = "SEGA Genesis"; File = "mock15.ps1"}
    "16" = @{Name = "Matrix Rain"; File = "mock16.ps1"}
    "17" = @{Name = "OS/2 Warp"; File = "mock17.ps1"}
    "18" = @{Name = "BeOS"; File = "mock18.ps1"}
    "19" = @{Name = "NeXTSTEP"; File = "mock19.ps1"}
    "20" = @{Name = "Sun Solaris"; File = "mock20.ps1"}
}

# Show splash screen function
function Show-SplashScreen {
    if ($Script:SplashScreen -eq "0") {
        return # No splash screen
    }
    
    if ($Script:SplashScreens.ContainsKey($Script:SplashScreen)) {
        # Call the appropriate splash function based on the splash screen number
        switch ([int]$Script:SplashScreen) {
            1 { Show-Splash1 }
            2 { Show-Splash2 }
            3 { Show-Splash3 }
            4 { Show-Splash4 }
            5 { Show-Splash5 }
            6 { Show-Splash6 }
            7 { Show-Splash7 }
            8 { Show-Splash8 }
            9 { Show-Splash9 }
            10 { Show-Splash10 }
            11 { Show-Splash11 }
            12 { Show-Splash12 }
            13 { Show-Splash13 }
            14 { Show-Splash14 }
            15 { Show-Splash15 }
            16 { Show-Splash16 }
            17 { Show-Splash17 }
            18 { Show-Splash18 }
            19 { Show-Splash19 }
            20 { Show-Splash20 }
            default { Show-Splash1 }
        }
    } else {
        # Default to first splash screen
        Show-Splash1
    }
}

# Splash Screen Functions
function Show-Splash1 {
    # Mock 1 - Classic BBS Style Splash Screen
    
    Clear-Host
    Write-Host ""
    Write-Host "    ============================================================================" -ForegroundColor DarkCyan
    Write-Host "    ||                                                                        ||" -ForegroundColor DarkCyan
    Write-Host "    ||  ######  ###### ###### ##   ##  #####  ##  ## ## ###### ###### ###### ||" -ForegroundColor Cyan
    Write-Host "    ||  ##      ##       ##   ### ### ##   ## ##  ## ## ##     ##     ##     ||" -ForegroundColor Cyan
    Write-Host "    ||  ## ###  ####     ##   ## # ## ##   ## ##  ## ## ####   ###### ###### ||" -ForegroundColor Yellow
    Write-Host "    ||  ##  ##  ##       ##   ##   ## ##   ##  ####  ## ##         ##     ## ||" -ForegroundColor Yellow
    Write-Host "    ||  ######  ######   ##   ##   ##  #####    ##   ## ###### ###### ###### ||" -ForegroundColor Green
    Write-Host "    ||                                                                        ||" -ForegroundColor DarkCyan
    Write-Host "    ============================================================================" -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host "                        >>>===[ UNDERGROUND EDITION ]===<<<" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "    +------------------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host "    |                                                                        |" -ForegroundColor DarkGray
    Write-Host "    |                        SYSTEM INITIALIZATION                           |" -ForegroundColor White
    Write-Host "    |                                                                        |" -ForegroundColor DarkGray
    Write-Host "    | [*] Loading TORRENT.SYS.................... [OK]                       |" -ForegroundColor Green
    Write-Host "    | [*] Initializing P2P Protocol.............. [OK]                       |" -ForegroundColor Green
    Write-Host "    | [*] Connecting to Underground Network...... [OK]                       |" -ForegroundColor Green
    Write-Host "    | [*] Bypassing ISP Restrictions............. [OK]                       |" -ForegroundColor Green
    Write-Host "    | [*] Establishing Secure Tunnel............. [OK]                       |" -ForegroundColor Green
    Write-Host "    |                                                                        |" -ForegroundColor DarkGray
    Write-Host "    |      ALL SYSTEMS OPERATIONAL - WELCOME TO THE REVOLUTION               |" -ForegroundColor Yellow
    Write-Host "    |                                                                        |" -ForegroundColor DarkGray
    Write-Host "    +------------------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "           COPYRIGHT (C) 1985 PIRATE LIBERATION FRONT - NO RIGHTS RESERVED" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    Press ENTER to continue..." -ForegroundColor Gray
    Read-Host
}

function Show-Splash2 {
    # Mock 2 - BBC Micro Style Splash Screen
    
    Clear-Host
    Write-Host ""
    Write-Host "    BBC Microcomputer System" -ForegroundColor Yellow
    Write-Host "    ========================" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    Acorn DFS" -ForegroundColor White
    Write-Host ""
    Write-Host "    BASIC" -ForegroundColor Green
    Write-Host ""
    Write-Host ""
    Write-Host "      +================================+" -ForegroundColor Yellow
    Write-Host "      |                                |" -ForegroundColor Yellow
    Write-Host "      |        Get Movies $Script:ApplicationVersion          |" -ForegroundColor Red
    Write-Host "      |     BBC MICRO EDITION          |" -ForegroundColor Red
    Write-Host "      |                                |" -ForegroundColor Yellow
    Write-Host "      |   TELETEXT TORRENT TERMINAL    |" -ForegroundColor Cyan
    Write-Host "      |                                |" -ForegroundColor Yellow
    Write-Host "      +================================+" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    BBC MICRO MODEL B - 32K RAM" -ForegroundColor White
    Write-Host "    6502 PROCESSOR AT 2MHZ" -ForegroundColor White
    Write-Host "    ACORN DFS - DUAL FLOPPY SYSTEM" -ForegroundColor White
    Write-Host ""
    Write-Host "    *EXEC DOWNLOAD FILMS MODE 7" -ForegroundColor Green
    Write-Host "    READY" -ForegroundColor Green
    Write-Host ""
    Write-Host "    Press ENTER to continue..." -ForegroundColor Gray
    Read-Host
}

function Show-Splash3 {
    # Mock 3 - Retro Computer Terminal Style
    
    Clear-Host
    Write-Host ""
    Write-Host "    ***************************************************************************" -ForegroundColor Magenta
    Write-Host "    *                                                                         *" -ForegroundColor Magenta
    Write-Host "    *                        COMMODORE 64 BASIC V2                           *" -ForegroundColor Cyan
    Write-Host "    *                                                                         *" -ForegroundColor Magenta
    Write-Host "    *                    64K RAM SYSTEM  38911 BYTES FREE                    *" -ForegroundColor Green
    Write-Host "    *                                                                         *" -ForegroundColor Magenta
    Write-Host "    ***************************************************************************" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "    READY." -ForegroundColor Green
    Write-Host "    LOAD " -NoNewline -ForegroundColor Green
    Write-Host '"GETMOVIES"' -NoNewline -ForegroundColor White
    Write-Host ",8,1" -ForegroundColor Green
    Write-Host ""
    Write-Host "    SEARCHING FOR GETMOVIES" -ForegroundColor Cyan
    Write-Host "    LOADING" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    +-----------------------------------------------------------------------+" -ForegroundColor Blue
    Write-Host "    |                                                                       |" -ForegroundColor Blue
    Write-Host "    |   GGGGGG  EEEEEEE TTTTTTT MM    MM  OOOOO  VV    VV IIIII EEEEEEE   |" -ForegroundColor Yellow
    Write-Host "    |  GG       EE        TTT   MMM  MMM OO   OO VV    VV  III  EE        |" -ForegroundColor Yellow
    Write-Host "    |  GG  GGG  EEEEE     TTT   MM MM MM OO   OO VV    VV  III  EEEEE     |" -ForegroundColor Green
    Write-Host "    |  GG   GG  EE        TTT   MM    MM OO   OO  VV  VV   III  EE        |" -ForegroundColor Green
    Write-Host "    |   GGGGGG  EEEEEEE   TTT   MM    MM  OOOOO    VVVV   IIIII EEEEEEE   |" -ForegroundColor Cyan
    Write-Host "    |                                                                       |" -ForegroundColor Blue
    Write-Host "    +-----------------------------------------------------------------------+" -ForegroundColor Blue
    Write-Host ""
    Write-Host "    RUN" -ForegroundColor Green
    Write-Host ""
    Write-Host "    INITIALIZING PIRATE BAY INTERFACE..." -ForegroundColor Yellow
    Write-Host "    POKE 53280,0 : POKE 53281,0" -ForegroundColor DarkGray
    Write-Host "    SYS 64738" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    *** PRESS PLAY ON TAPE ***" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host ""
    Write-Host "    READY FOR DOWNLOADS. TYPE 'LIST' TO BEGIN." -ForegroundColor Green
    Write-Host "    _" -NoNewline -ForegroundColor Green
    Write-Host ""
    Write-Host ""
    Write-Host "    Press ENTER to continue..." -ForegroundColor Gray
    Read-Host
}

function Show-Splash4 {
    # Mock 4 - War Games / Military Terminal Style
    
    Clear-Host
    Write-Host ""
    Write-Host "    ===========================================================================
" -ForegroundColor DarkRed
    Write-Host "                         UNITED STATES DEPARTMENT OF DEFENSE" -ForegroundColor Red
    Write-Host "                              STRATEGIC COMMAND SYSTEM" -ForegroundColor Red
    Write-Host "                                 [ CLASSIFIED ]" -ForegroundColor Yellow
    Write-Host "    ===========================================================================
" -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "    AUTHENTICATION REQUIRED..." -ForegroundColor Green
    Write-Host ""
    Write-Host "    USERNAME: " -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "JOSHUA" -ForegroundColor White
    Write-Host "    PASSWORD: " -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "**********" -ForegroundColor White
    Write-Host ""
    Write-Host "    ACCESS GRANTED - WELCOME PROFESSOR FALKEN" -ForegroundColor Green
    Write-Host ""
    Write-Host "    LOADING OPERATION: Get Movies $Script:ApplicationVersion" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    +-------------------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host "    | TACTICAL OPERATIONS READOUT REGARDING ENEMY TRANSMISSIONS               |" -ForegroundColor Green
    Write-Host "    +-------------------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host "    |                                                                         |" -ForegroundColor Green
    Write-Host "    |  OPERATION CODENAME: GETMOVIES                                         |" -ForegroundColor White
    Write-Host "    |  MISSION TYPE: COVERT DATA ACQUISITION                                 |" -ForegroundColor White
    Write-Host "    |  TARGET: ENEMY ENTERTAINMENT RESOURCES                                 |" -ForegroundColor White
    Write-Host "    |  METHOD: PEER-TO-PEER INFILTRATION                                     |" -ForegroundColor White
    Write-Host "    |                                                                         |" -ForegroundColor Green
    Write-Host "    |  STATUS: [#########################################] 100% OPERATIONAL   |" -ForegroundColor Yellow
    Write-Host "    |                                                                         |" -ForegroundColor Green
    Write-Host "    |  DEFCON STATUS: 5 (PEACEFUL)                                           |" -ForegroundColor Green
    Write-Host "    |  THREAT LEVEL: MINIMAL                                                 |" -ForegroundColor Green
    Write-Host "    |  ENCRYPTION: MILITARY GRADE                                            |" -ForegroundColor Green
    Write-Host "    |                                                                         |" -ForegroundColor Green
    Write-Host "    +-------------------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host ""
    Write-Host "    SHALL WE PLAY A GAME?" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    HOW ABOUT A NICE GAME OF... DOWNLOADING MOVIES?" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    > INITIATING PROTOCOL..." -ForegroundColor Green -BackgroundColor Black
    Write-Host ""
    Write-Host "    Press ENTER to continue..." -ForegroundColor Gray
    Read-Host
}

function Show-Splash5 {
    # Mock 5 - Amiga Workbench Style
    Clear-Host
    Write-Host ""
    Write-Host "                    Amiga Workbench 1.3 - Kickstart 34.5" -ForegroundColor White -BackgroundColor Blue
    Write-Host "=================================================================================" -ForegroundColor Blue
    Write-Host ""
    Write-Host "     +-----------+  +-----------+  +-----------+  +-----------+" -ForegroundColor Cyan
    Write-Host "     |    RAM    |  |   DISK    |  |  MOVIES   |  |  SYSTEM   |" -ForegroundColor White
    Write-Host "     |    [#]    |  |    [o]    |  |    [@]    |  |    [!]    |" -ForegroundColor White
    Write-Host "     +-----------+  +-----------+  +-----------+  +-----------+" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "                        >>> Get Movies $Script:ApplicationVersion <<<" -ForegroundColor Yellow
    Write-Host "                    The Ultimate Torrent Finder" -ForegroundColor White
    Write-Host ""
    Write-Host "    +---------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host "    |  Guru Meditation: #00000003.48454C50                          |" -ForegroundColor Red
    Write-Host "    |  Just kidding! Everything is working perfectly!               |" -ForegroundColor Green
    Write-Host "    +---------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "         Hold Right Mouse Button for Menu" -ForegroundColor Cyan
    Write-Host "         Insert Disk 2 to Continue..." -ForegroundColor Yellow -NoNewline
    Write-Host " (Press ENTER)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    Chip RAM: 512K    Fast RAM: 0K    Torrents: UNLIMITED" -ForegroundColor Blue
    Write-Host ""
    Read-Host
}

function Show-Splash6 {
    # Mock 6 - DOS Norton Commander Style
    Clear-Host
    Write-Host "+-[C:\GETMOVIES]-----------------------------------------------[F1 Help]-------+" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "| Name             | Size    | Date     | Time  || Name             | Size    |" -ForegroundColor Yellow -BackgroundColor DarkBlue
    Write-Host "|------------------|---------|----------|-------||------------------|---------|" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "| ..               | <DIR>   | 01-01-90 | 00:00 || MOVIES.DB        | 1337 KB |" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host "| TORRENTS         | <DIR>   | 06-06-25 | 12:00 || MAGNETS.DAT      | 420 KB  |" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host "| DOWNLOADS        | <DIR>   | 06-06-25 | 13:37 || PIRATE.EXE       | 666 KB  |" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host "| GETMOVIES.EXE    | 128 KB  | 06-06-25 | 14:00 || README.TXT       | 2 KB    |" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host "|                  |         |          |       ||                  |         |" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host "+----------------------------------+--+----------------------------------+--+" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host ""
    Write-Host "                         Get Movies $Script:ApplicationVersion COMMANDER" -ForegroundColor Yellow
    Write-Host "                    Your File Manager for Movie Torrents" -ForegroundColor Green
    Write-Host ""
    Write-Host "    +================================================================+" -ForegroundColor DarkGray
    Write-Host "    | F1-Help  F2-Menu  F3-View  F4-Edit  F5-Copy  F6-Move  F7-MkDir |" -ForegroundColor White
    Write-Host "    | F8-Delete  F9-PullDn  F10-Quit  Alt-F1-Left  Alt-F2-Right     |" -ForegroundColor White
    Write-Host "    +================================================================+" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "C:\> GETMOVIES.EXE /TURBO /ELITE /HACK" -ForegroundColor Green
    Write-Host "Loading torrent database... Done!" -ForegroundColor Yellow
    Write-Host "Ready to search the seven seas!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Press ENTER to start Norton GetMovies Commander..." -ForegroundColor White
    Read-Host
}

function Show-Splash7 {
    # Mock 7 - Arcade Game Style
    Clear-Host
    Write-Host ""
    Write-Host "    +-----------------------------------------------------------------+" -ForegroundColor Magenta
    Write-Host "    |                                                                 |" -ForegroundColor Magenta
    Write-Host "    |     ####  ####  #####    #   #  ###  #   # # ####  ####        |" -ForegroundColor Yellow
    Write-Host "    |    #     #        #      ## ## #   # #   # # #    #            |" -ForegroundColor Yellow
    Write-Host "    |    # ### ####     #      # # # #   # #   # # #### ####         |" -ForegroundColor Red
    Write-Host "    |    #   # #        #      #   # #   #  # #  # #        #        |" -ForegroundColor Red
    Write-Host "    |     ###  ####     #      #   #  ###    #   # #### ####         |" -ForegroundColor Magenta
    Write-Host "    |                                                                 |" -ForegroundColor Magenta
    Write-Host "    +-----------------------------------------------------------------+" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "                        === HIGH SCORES ===" -ForegroundColor Cyan
    Write-Host "                    1ST  PIRATE_KING   999999" -ForegroundColor Yellow
    Write-Host "                    2ND  TORRENT_MSTR  888888" -ForegroundColor White
    Write-Host "                    3RD  MOVIE_BUFF    777777" -ForegroundColor DarkYellow
    Write-Host ""
    Write-Host "                    INSERT COIN TO CONTINUE" -ForegroundColor Red -NoNewline
    for ($i = 0; $i -lt 3; $i++) {
        Start-Sleep -Milliseconds 500
        Write-Host "." -NoNewline -ForegroundColor Red
    }
    Write-Host ""
    Write-Host ""
    Write-Host "              CREDITS: 00   PLAYERS: 1   LEVEL: 01" -ForegroundColor Green
    Write-Host ""
    Write-Host "    [SPACE] 1 PLAYER START    [ENTER] 2 PLAYERS START" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "         (C) 1989 RADICAL TORRENT INDUSTRIES LTD." -ForegroundColor DarkGray
    Write-Host ""
    Read-Host
}

function Show-Splash8 {
    # Mock 8 - Apple II Style
    Clear-Host
    Write-Host "]" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "CATALOG" -ForegroundColor Green
    Write-Host ""
    Write-Host "DISK VOLUME 254" -ForegroundColor Green
    Write-Host ""
    Write-Host " A 002 HELLO" -ForegroundColor Green
    Write-Host "*B 034 GETMOVIES.SYSTEM" -ForegroundColor Green
    Write-Host " B 128 TORRENT.FINDER" -ForegroundColor Green
    Write-Host " T 003 README" -ForegroundColor Green
    Write-Host " B 064 PIRATE.BAY" -ForegroundColor Green
    Write-Host " I 020 SPLASH.SCREEN" -ForegroundColor Green
    Write-Host ""
    Write-Host "]" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "RUN GETMOVIES.SYSTEM" -ForegroundColor Green
    Write-Host ""
    Start-Sleep -Milliseconds 800
    Write-Host "********************************" -ForegroundColor Green
    Write-Host "*                              *" -ForegroundColor Green
    Write-Host "*     Get Movies $Script:ApplicationVersion           *" -ForegroundColor Green
    Write-Host "*                              *" -ForegroundColor Green
    Write-Host "*  THE APPLE ][ TORRENT FINDER *" -ForegroundColor Green
    Write-Host "*                              *" -ForegroundColor Green
    Write-Host "*   (C) 1982 STEVE WOZNIAK     *" -ForegroundColor Green
    Write-Host "*      JUST KIDDING :)         *" -ForegroundColor Green
    Write-Host "*                              *" -ForegroundColor Green
    Write-Host "********************************" -ForegroundColor Green
    Write-Host ""
    Write-Host "PRESS ENTER TO BOOT INTO PRODOS" -ForegroundColor Green
    Write-Host ""
    Write-Host "]_" -NoNewline -ForegroundColor Green
    Read-Host
}

function Show-Splash9 {
    # Mock 9 - ZX Spectrum Style
    Clear-Host
    $rainbow = @("Red", "Yellow", "Green", "Cyan", "Blue", "Magenta")
    Write-Host ""
    # Rainbow border effect
    for ($i = 0; $i -lt 3; $i++) {
        $color = $rainbow[$i % 6]
        Write-Host ("=" * 80) -ForegroundColor $color
    }
    Write-Host ""
    Write-Host "                    (C) 1982 Sinclair Research Ltd" -ForegroundColor White
    Write-Host ""
    Write-Host "    10 PRINT " -NoNewline -ForegroundColor Yellow
    Write-Host "Get Movies $Script:ApplicationVersion ZX SPECTRUM 48K" -NoNewline -ForegroundColor Cyan
    Write-Host '"' -ForegroundColor Yellow
    Write-Host "    20 PRINT " -NoNewline -ForegroundColor Yellow
    Write-Host "================================" -NoNewline -ForegroundColor Magenta
    Write-Host '"' -ForegroundColor Yellow
    Write-Host "    30 LET pirates=1337" -ForegroundColor Yellow
    Write-Host "    40 LET movies$=" -NoNewline -ForegroundColor Yellow
    Write-Host '"UNLIMITED"' -ForegroundColor Green
    Write-Host "    50 PRINT " -NoNewline -ForegroundColor Yellow
    Write-Host '"Loading torrent engine..."' -ForegroundColor White
    Write-Host "    60 FOR n=1 TO 10" -ForegroundColor Yellow
    Write-Host "    70 PRINT " -NoNewline -ForegroundColor Yellow
    Write-Host '"."' -NoNewline -ForegroundColor Red
    Write-Host ";" -NoNewline -ForegroundColor Yellow
    Write-Host ": NEXT n" -ForegroundColor Yellow
    Write-Host "    80 PRINT " -NoNewline -ForegroundColor Yellow
    Write-Host '"Ready!"' -ForegroundColor Green
    Write-Host "    90 GO TO 1337" -ForegroundColor Yellow
    Write-Host "    RUN" -ForegroundColor White
    Write-Host ""
    Write-Host "    Program: GETMOVIES     Bytes: 48127" -ForegroundColor Cyan
    Write-Host ""
    # Rainbow border effect
    for ($i = 3; $i -lt 6; $i++) {
        $color = $rainbow[$i % 6]
        Write-Host ("=" * 80) -ForegroundColor $color
    }
    Write-Host ""
    Write-Host "    R Tape loading error, 0:1" -ForegroundColor Red -BackgroundColor Yellow
    Write-Host ""
    Write-Host "    PRESS PLAY ON TAPE... I mean ENTER" -ForegroundColor White
    Read-Host
}

function Show-Splash10 {
    # Mock 10 - Atari 800 Style
    Clear-Host
    Write-Host ""
    Write-Host "    ATARI 800 COMPUTER - 48K RAM SYSTEM" -ForegroundColor Blue -BackgroundColor White
    Write-Host ""
    Write-Host "    READY" -ForegroundColor Blue
    Write-Host ""
    Write-Host "    LOAD " -NoNewline -ForegroundColor Blue
    Write-Host '"D:GETMOVIE.BAS"' -ForegroundColor Cyan
    Write-Host ""
    Start-Sleep -Milliseconds 1000
    Write-Host "    BOOT ERROR - RETRY? Y" -ForegroundColor Red
    Write-Host ""
    Start-Sleep -Milliseconds 500
    Write-Host "    LOADING..." -ForegroundColor Blue
    Write-Host ""
    Write-Host "    +------------------------------------------+" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "        A T A R I   P O W E R   U P         " -NoNewline -ForegroundColor Yellow
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "                                            " -NoNewline
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "           Get Movies $Script:ApplicationVersion                   " -NoNewline -ForegroundColor Cyan
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "        THE 8-BIT TORRENT HERO              " -NoNewline -ForegroundColor White
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "                                            " -NoNewline
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "     [SELECT] START  [OPTION] SETTINGS      " -NoNewline -ForegroundColor Green
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "     [START] BEGIN TORRENT SEARCH           " -NoNewline -ForegroundColor Green
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    |" -NoNewline -ForegroundColor DarkBlue
    Write-Host "                                            " -NoNewline
    Write-Host "|" -ForegroundColor DarkBlue
    Write-Host "    +------------------------------------------+" -ForegroundColor DarkBlue
    Write-Host ""
    Write-Host "    MEMO PAD: Movies found = Happiness gained" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    PRESS RETURN TO CONTINUE" -ForegroundColor Blue
    Read-Host
}

function Show-Splash11 {
    # Mock 11 - TRS-80 Style
    Clear-Host
    Write-Host ""
    Write-Host "################################################################################" -ForegroundColor Green -BackgroundColor Black
    Write-Host "#                                                                              #" -ForegroundColor Green -BackgroundColor Black
    Write-Host "#                         TRS-80 MODEL III - 48K                               #" -ForegroundColor Green -BackgroundColor Black
    Write-Host "#                                                                              #" -ForegroundColor Green -BackgroundColor Black
    Write-Host "################################################################################" -ForegroundColor Green -BackgroundColor Black
    Write-Host ""
    Write-Host "CASS?" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host " SYSTEM" -ForegroundColor Green
    Write-Host "*? " -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "GETMOVIES/CMD" -ForegroundColor Green
    Write-Host ""
    Write-Host "Get Movies $Script:ApplicationVersion - LEVEL II BASIC" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "    ###  ### ###   ##   ###  ###" -ForegroundColor Green
    Write-Host "     #   #   # #  #  #  # #  # #" -ForegroundColor Green
    Write-Host "     #   ##  ###  ####  # #  # #" -ForegroundColor Green
    Write-Host "     #   # # # #  #  #  # #  # #" -ForegroundColor Green
    Write-Host "     #   # # # #  #  #  ###  ###" -ForegroundColor Green
    Write-Host ""
    Write-Host "    TORRENT DOWNLOADER FOR" -ForegroundColor Green
    Write-Host "    THE RADIO SHACK FAMILY" -ForegroundColor Green
    Write-Host ""
    Write-Host "MEMORY SIZE? 48382" -ForegroundColor Green
    Write-Host "RADIO SHACK LEVEL II BASIC" -ForegroundColor Green
    Write-Host "READY" -ForegroundColor Green
    Write-Host ">" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 800
    Write-Host "RUN" -ForegroundColor Green
    Write-Host ""
    Write-Host "PRESS <ENTER> TO START DOWNLOAD ENGINE" -ForegroundColor Green
    Read-Host
}

function Show-Splash12 {
    # Mock 12 - MSX Computer Style
    Clear-Host
    Write-Host ""
    Write-Host "MSX BASIC version 2.0" -ForegroundColor White
    Write-Host "Copyright 1985 by Microsoft" -ForegroundColor White
    Write-Host "28815 Bytes free" -ForegroundColor White
    Write-Host "Ok" -ForegroundColor White
    Write-Host ""
    Write-Host 'load"cas:",r' -ForegroundColor Cyan
    Write-Host "Found: GETMOVIES" -ForegroundColor White
    Write-Host ""
    Start-Sleep -Milliseconds 1000
    Write-Host "Loading" -NoNewline -ForegroundColor White
    for ($i = 0; $i -lt 5; $i++) {
        Start-Sleep -Milliseconds 300
        Write-Host "." -NoNewline -ForegroundColor White
    }
    Write-Host ""
    Write-Host ""
    Write-Host "         /-----------------------\" -ForegroundColor Red
    Write-Host "         |  " -NoNewline -ForegroundColor Red
    Write-Host "MSX Get Movies $Script:ApplicationVersion" -NoNewline -ForegroundColor Yellow
    Write-Host "  |" -ForegroundColor Red
    Write-Host "         |-----------------------|" -ForegroundColor Red
    Write-Host "         |  " -NoNewline -ForegroundColor Red
    Write-Host "KONAMI CODE ENABLED" -NoNewline -ForegroundColor Cyan
    Write-Host " |" -ForegroundColor Red
    Write-Host "         |  " -NoNewline -ForegroundColor Red
    Write-Host "UP UP DN DN LT RT LT RT B A START" -NoNewline -ForegroundColor White
    Write-Host " |" -ForegroundColor Red
    Write-Host "         \-----------------------/" -ForegroundColor Red
    Write-Host ""
    Write-Host "    ##################################" -ForegroundColor Blue
    Write-Host "    # METAL GEAR OF TORRENTS         #" -ForegroundColor Blue
    Write-Host "    # SOLID DOWNLOADS GUARANTEED     #" -ForegroundColor Blue
    Write-Host "    ##################################" -ForegroundColor Blue
    Write-Host ""
    Write-Host "Press SPACE BAR to start" -ForegroundColor Green
    Write-Host "Press GRAPH+STOP to quit" -ForegroundColor Red
    Write-Host ""
    Read-Host
}

function Show-Splash13 {
    # Mock 13 - VIC-20 Style
    Clear-Host
    # VIC-20 has 22 columns x 23 rows display
    Write-Host ""
    Write-Host "    ****" -NoNewline -ForegroundColor Cyan
    Write-Host " CBM BASIC V2 " -NoNewline -ForegroundColor White
    Write-Host "****" -ForegroundColor Cyan
    Write-Host "    " -NoNewline
    Write-Host " 3583 BYTES FREE" -ForegroundColor White
    Write-Host ""
    Write-Host "    READY." -ForegroundColor White
    Write-Host "    LOAD" -NoNewline -ForegroundColor White
    Write-Host '"GETMOVIES"' -NoNewline -ForegroundColor Cyan
    Write-Host ",8" -ForegroundColor White
    Write-Host ""
    Write-Host "    SEARCHING FOR GETMOVIES" -ForegroundColor White
    Write-Host "    LOADING" -ForegroundColor White
    Write-Host "    READY." -ForegroundColor White
    Write-Host "    RUN" -ForegroundColor White
    Write-Host ""
    Write-Host "    +------------------+" -ForegroundColor Yellow
    Write-Host "    |" -NoNewline -ForegroundColor Yellow
    Write-Host "VIC-20 GETMOVIES" -NoNewline -ForegroundColor Red
    Write-Host "  |" -ForegroundColor Yellow
    Write-Host "    |" -NoNewline -ForegroundColor Yellow
    Write-Host "  TORRENT POWER" -NoNewline -ForegroundColor Cyan
    Write-Host "   |" -ForegroundColor Yellow
    Write-Host "    |" -NoNewline -ForegroundColor Yellow
    Write-Host "   ON 5KB RAM!" -NoNewline -ForegroundColor Green
    Write-Host "    |" -ForegroundColor Yellow
    Write-Host "    +------------------+" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    THE FRIENDLY COMPUTER" -ForegroundColor Magenta
    Write-Host "    WANTS TO FIND MOVIES" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "    ?OUT OF MEMORY ERROR" -ForegroundColor Red
    Write-Host "    JUST KIDDING :)" -ForegroundColor Green
    Write-Host ""
    Write-Host "    PRESS RETURN" -ForegroundColor White
    Read-Host
}

function Show-Splash14 {
    # Mock 14 - Tandy CoCo Style
    Clear-Host
    Write-Host ""
    Write-Host "                        " -NoNewline -BackgroundColor Green
    Write-Host "EXTENDED COLOR BASIC 1.1" -ForegroundColor Black -BackgroundColor Green
    Write-Host "                        " -NoNewline -BackgroundColor Green
    Write-Host "(C) 1982 TANDY" -ForegroundColor Black -BackgroundColor Green
    Write-Host ""
    Write-Host "OK" -ForegroundColor Green
    Write-Host ""
    Write-Host 'LOADM"GETMOVIE"' -ForegroundColor Cyan
    Write-Host ""
    Write-Host "         " -NoNewline
    Write-Host "################################" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "#                              #" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "#  " -NoNewline -ForegroundColor Green
    Write-Host "TRS-80 COLOR COMPUTER" -NoNewline -ForegroundColor Yellow
    Write-Host "     #" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "#  " -NoNewline -ForegroundColor Green
    Write-Host "    Get Movies $Script:ApplicationVersion" -NoNewline -ForegroundColor White
    Write-Host "        #" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "#                              #" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "#  " -NoNewline -ForegroundColor Green
    Write-Host "NOW WITH 64K OF POWER!" -NoNewline -ForegroundColor Cyan
    Write-Host "    #" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "#  " -NoNewline -ForegroundColor Green
    Write-Host "AND JOYSTICK SUPPORT!" -NoNewline -ForegroundColor Magenta
    Write-Host "     #" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "#                              #" -ForegroundColor Green
    Write-Host "         " -NoNewline
    Write-Host "################################" -ForegroundColor Green
    Write-Host ""
    Write-Host "    PMODE 4: GRAPHICS MODE READY" -ForegroundColor Yellow
    Write-Host "    TORRENTS: MAXIMUM RESOLUTION" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    PRESS BREAK TO STOP" -ForegroundColor Red
    Write-Host "    PRESS ENTER TO START" -ForegroundColor Green
    Write-Host ""
    Write-Host "OK" -ForegroundColor Green
    Read-Host
}

function Show-Splash15 {
    # Mock 15 - SEGA Genesis/Mega Drive Style
    Clear-Host
    Write-Host ""
    Write-Host "    ################################################################" -ForegroundColor DarkBlue
    Write-Host "    ##                                                        ##" -ForegroundColor DarkBlue
    Write-Host "    ##  " -NoNewline -ForegroundColor DarkBlue
    Write-Host "####### ######  ######   ######" -NoNewline -ForegroundColor White
    Write-Host "                     ##" -ForegroundColor DarkBlue
    Write-Host "    ##  " -NoNewline -ForegroundColor DarkBlue
    Write-Host "##      ##      ##       ##  ##" -NoNewline -ForegroundColor White
    Write-Host "                     ##" -ForegroundColor DarkBlue
    Write-Host "    ##  " -NoNewline -ForegroundColor DarkBlue
    Write-Host "####### ######  ##  ###  ######" -NoNewline -ForegroundColor Red
    Write-Host "                     ##" -ForegroundColor DarkBlue
    Write-Host "    ##  " -NoNewline -ForegroundColor DarkBlue
    Write-Host "     ## ##      ##   ##  ##  ##" -NoNewline -ForegroundColor Red
    Write-Host "                     ##" -ForegroundColor DarkBlue
    Write-Host "    ##  " -NoNewline -ForegroundColor DarkBlue
    Write-Host "####### ######  ######   ##  ##" -NoNewline -ForegroundColor White
    Write-Host "                     ##" -ForegroundColor DarkBlue
    Write-Host "    ##                                                        ##" -ForegroundColor DarkBlue
    Write-Host "    ################################################################" -ForegroundColor DarkBlue
    Write-Host ""
    Write-Host "              GENESIS DOES WHAT NINTENDON'T!" -ForegroundColor Yellow
    Write-Host "                  DOWNLOAD MOVIES FASTER!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    +=======================================================+" -ForegroundColor Blue
    Write-Host "    |        " -NoNewline -ForegroundColor Blue
    Write-Host "Get Movies $Script:ApplicationVersion - 16-BIT BLAST PROCESSING" -NoNewline -ForegroundColor Yellow
    Write-Host "       |" -ForegroundColor Blue
    Write-Host "    +=======================================================+" -ForegroundColor Blue
    Write-Host ""
    Write-Host "         A = SEARCH    B = TOP MOVIES    C = SETTINGS" -ForegroundColor Green
    Write-Host "                    START = BEGIN GAME" -ForegroundColor Red
    Write-Host ""
    Write-Host "    TM AND (C) 1991 SEGA. LICENSED BY SONY FOR TORRENTS" -ForegroundColor DarkGray
    Write-Host ""
    Read-Host
}

function Show-Splash16 {
    # Mock 16 - Matrix/Hacker Style Splash Screen
    
    Clear-Host
    Write-Host ""
    Write-Host "                    ACCESS GRANTED - ENTERING THE MATRIX" -ForegroundColor Green
    Write-Host ""
    Write-Host "    01000111 01000101 01010100 01001101 01001111 01010110 01001001 01000101 01010011" -ForegroundColor DarkGreen
    Write-Host ""
    Write-Host "    /---------------------------------------------------------------------------\" -ForegroundColor Green
    Write-Host "    |                                                                           |" -ForegroundColor Green
    Write-Host "    |    _____ _____ _____    _____ _____ _____ _____ _____ _____             |" -ForegroundColor Cyan
    Write-Host "    |   |   __|   __|_   _|  |     |     |  |  |     |   __|   __|            |" -ForegroundColor Cyan
    Write-Host "    |   |  |  |   __| | |    | | | |  |  |  |  |-   -|   __|__   |            |" -ForegroundColor Yellow
    Write-Host "    |   |_____|_____| |_|    |_|_|_|_____|\\___/|_____|_____|_____|            |" -ForegroundColor Yellow
    Write-Host "    |                                                                           |" -ForegroundColor Green
    Write-Host "    |                    [ TORRENT ACQUISITION SYSTEM Version $Script:ApplicationVersion ]                    |" -ForegroundColor White
    Write-Host "    |                                                                           |" -ForegroundColor Green
    Write-Host "    \---------------------------------------------------------------------------/" -ForegroundColor Green
    Write-Host ""
    Write-Host "    SYSTEM STATUS:" -ForegroundColor Cyan
    Write-Host "    +============================================================================+" -ForegroundColor DarkGreen
    Write-Host "    | > Firewall Status......... [BYPASSED]   | > VPN Status........... [ACTIVE] |" -ForegroundColor Green
    Write-Host "    | > Encryption Level........ [256-BIT]    | > Trackers Connected... [42]     |" -ForegroundColor Green
    Write-Host "    | > Download Threads........ [UNLIMITED]  | > Upload Ratio......... [3.14]   |" -ForegroundColor Green
    Write-Host "    | > ISP Detection........... [CLOAKED]    | > Seed Protection...... [ON]     |" -ForegroundColor Green
    Write-Host "    +============================================================================+" -ForegroundColor DarkGreen
    Write-Host ""
    Write-Host "                    >>> HACK THE PLANET - FREE THE MOVIES <<<" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    root@underground:~# ./getmovies --stealth-mode --max-speed" -ForegroundColor Green
    Write-Host "    [####################################] 100% - READY TO RIP!" -ForegroundColor Green
    Write-Host ""
    Write-Host "    Press ENTER to continue..." -ForegroundColor Gray
    Read-Host
}

function Show-Splash17 {
    # Mock 17 - OS/2 Warp Style
    Clear-Host
    Write-Host ""
    Write-Host "    +===========================================================+" -ForegroundColor Blue
    Write-Host "    |              " -NoNewline -ForegroundColor Blue
    Write-Host "OS/2 Warp Version 4" -NoNewline -ForegroundColor Yellow -BackgroundColor Blue
    Write-Host "                     |" -ForegroundColor Blue
    Write-Host "    |         " -NoNewline -ForegroundColor Blue
    Write-Host "The Operating System of the Future" -NoNewline -ForegroundColor White -BackgroundColor Blue
    Write-Host "             |" -ForegroundColor Blue
    Write-Host "    +===========================================================+" -ForegroundColor Blue
    Write-Host ""
    Write-Host "    Loading Workplace Shell..." -ForegroundColor Cyan
    Write-Host "    [SYS0001] System files loaded successfully." -ForegroundColor Green
    Write-Host "    [SYS0002] HPFS File System mounted." -ForegroundColor Green
    Write-Host "    [NET0001] IBM TCP/IP Version 4.3 loaded." -ForegroundColor Green
    Write-Host ""
    Write-Host "         +-----------------------------------------+" -ForegroundColor DarkGray
    Write-Host "         |  =  " -NoNewline -ForegroundColor DarkGray
    Write-Host "GETMOVIES/2 - Torrent Manager" -NoNewline -ForegroundColor White
    Write-Host "     |" -ForegroundColor DarkGray
    Write-Host "         +-----------------------------------------+" -ForegroundColor DarkGray
    Write-Host "         |                                         |" -ForegroundColor DarkGray
    Write-Host "         |     " -NoNewline -ForegroundColor DarkGray
    Write-Host "#### #### ##### # # ####" -NoNewline -ForegroundColor Cyan
    Write-Host "             |" -ForegroundColor DarkGray
    Write-Host "         |     " -NoNewline -ForegroundColor DarkGray
    Write-Host "#  # #      #   ### #  #" -NoNewline -ForegroundColor Cyan
    Write-Host "             |" -ForegroundColor DarkGray
    Write-Host "         |     " -NoNewline -ForegroundColor DarkGray
    Write-Host "#### ####   #   # #  ## " -NoNewline -ForegroundColor Cyan
    Write-Host "             |" -ForegroundColor DarkGray
    Write-Host "         |                                         |" -ForegroundColor DarkGray
    Write-Host "         |   " -NoNewline -ForegroundColor DarkGray
    Write-Host "A true 32-bit torrent experience!" -NoNewline -ForegroundColor Yellow
    Write-Host "    |" -ForegroundColor DarkGray
    Write-Host "         |   " -NoNewline -ForegroundColor DarkGray
    Write-Host "Better than Windows 95 could be!" -NoNewline -ForegroundColor Green
    Write-Host "    |" -ForegroundColor DarkGray
    Write-Host "         |                                         |" -ForegroundColor DarkGray
    Write-Host "         +-----------------------------------------+" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    [C:\] getmovie2.exe /TURBO /WARP" -ForegroundColor Green
    Write-Host ""
    Write-Host "    Press Enter to warp into torrent space..." -ForegroundColor White
    Read-Host
}

function Show-Splash18 {
    # Mock 18 - BeOS Style
    Clear-Host
    Write-Host ""
    Write-Host "                         " -NoNewline -BackgroundColor Yellow
    Write-Host "Be" -ForegroundColor Black -BackgroundColor Yellow -NoNewline
    Write-Host "OS" -ForegroundColor White -BackgroundColor Blue
    Write-Host ""
    Write-Host "              The Media OS - Release 5.0.3" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    +------------------------------------------------+" -ForegroundColor Yellow
    Write-Host "    | o o o  " -NoNewline -ForegroundColor Yellow
    Write-Host "Tracker - GetMovies Application" -NoNewline -ForegroundColor White
    Write-Host "      |" -ForegroundColor Yellow
    Write-Host "    +------------------------------------------------+" -ForegroundColor Yellow
    Write-Host "    |                                                |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "######  ######  ######  ######" -NoNewline -ForegroundColor Blue
    Write-Host "            |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "##   ## ##      ##   ## ##    " -NoNewline -ForegroundColor Blue
    Write-Host "            |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "######  ######  ##   ## ######" -NoNewline -ForegroundColor Cyan
    Write-Host "            |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "##   ## ##      ##   ##      ##" -NoNewline -ForegroundColor Cyan
    Write-Host "           |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "######  ######  ######  ######" -NoNewline -ForegroundColor Blue
    Write-Host "            |" -ForegroundColor Yellow
    Write-Host "    |                                                |" -ForegroundColor Yellow
    Write-Host "    |         " -NoNewline -ForegroundColor Yellow
    Write-Host "Get Movies $Script:ApplicationVersion for BeOS" -NoNewline -ForegroundColor Green
    Write-Host "              |" -ForegroundColor Yellow
    Write-Host "    |      " -NoNewline -ForegroundColor Yellow
    Write-Host "The multimedia torrent finder" -NoNewline -ForegroundColor White
    Write-Host "           |" -ForegroundColor Yellow
    Write-Host "    |                                                |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "* Pervasive multithreading" -NoNewline -ForegroundColor DarkGray
    Write-Host "                |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "* 64-bit journaling file system" -NoNewline -ForegroundColor DarkGray
    Write-Host "           |" -ForegroundColor Yellow
    Write-Host "    |    " -NoNewline -ForegroundColor Yellow
    Write-Host "* Database-like torrent storage" -NoNewline -ForegroundColor DarkGray
    Write-Host "           |" -ForegroundColor Yellow
    Write-Host "    |                                                |" -ForegroundColor Yellow
    Write-Host "    +------------------------------------------------+" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    /boot/home/Desktop> getmovies --launch" -ForegroundColor Green
    Write-Host ""
    Write-Host "    Press Enter to experience the future..." -ForegroundColor Cyan
    Read-Host
}

function Show-Splash19 {
    # Mock 19 - NeXTSTEP Style
    Clear-Host
    Write-Host ""
    Write-Host "    ####    ##  ########  ##    ##  ########" -ForegroundColor DarkGray
    Write-Host "    ##  ##  ##  ##         ##  ##      ##   " -ForegroundColor DarkGray
    Write-Host "    ##   ## ##  ######      ####       ##   " -ForegroundColor DarkGray
    Write-Host "    ##    ####  ##         ##  ##      ##   " -ForegroundColor DarkGray
    Write-Host "    ##     ###  ########  ##    ##     ##   " -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "                    NeXTSTEP Release 3.3" -ForegroundColor White
    Write-Host ""
    Write-Host "    +--------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host "    | # " -NoNewline -ForegroundColor DarkGray
    Write-Host "GetMovies.app" -NoNewline -ForegroundColor White
    Write-Host "                                 |" -ForegroundColor DarkGray
    Write-Host "    +--------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host "    |                                                  |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |         " -NoNewline -ForegroundColor Black -BackgroundColor Gray
    Write-Host "Welcome to Get Movies $Script:ApplicationVersion" -NoNewline -ForegroundColor Black -BackgroundColor White
    Write-Host "               |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |                                                  |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |    " -NoNewline -ForegroundColor Black -BackgroundColor Gray
    Write-Host "The Object-Oriented Torrent Solution" -NoNewline -ForegroundColor Black -BackgroundColor White
    Write-Host "         |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |                                                  |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |    Features:                                     |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |    * Display PostScript(TM) torrents             |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |    * Objective-C powered searches                |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |    * Mach kernel performance                     |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |    * Interface Builder designed UI               |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    |                                                  |" -ForegroundColor Black -BackgroundColor Gray
    Write-Host "    +--------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "    Terminal> /Apps/GetMovies.app/GetMovies -NSHost localhost" -ForegroundColor Green
    Write-Host ""
    Write-Host "    Press Enter to think different about torrents..." -ForegroundColor DarkGray
    Read-Host
}

function Show-Splash20 {
    # Mock 20 - Sun Solaris/SunOS Style
    Clear-Host
    Write-Host ""
    Write-Host "SunOS Release 5.10 Version Generic_147147-26 64-bit" -ForegroundColor Yellow
    Write-Host "Copyright (c) 1983, 2010, Oracle and/or its affiliates." -ForegroundColor Yellow
    Write-Host "All rights reserved." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Hostname: sunblade2500" -ForegroundColor White
    Write-Host ""
    Write-Host "            ___   ____   _   _" -ForegroundColor DarkYellow
    Write-Host "           / __| | __ | | \ | |" -ForegroundColor DarkYellow
    Write-Host "           \__ \ | || | |  \| |" -ForegroundColor Yellow
    Write-Host "           |___/ |____| |_|\_|" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    +=================================================+" -ForegroundColor Magenta
    Write-Host "    |         " -NoNewline -ForegroundColor Magenta
    Write-Host "SPARC Powered Get Movies $Script:ApplicationVersion" -NoNewline -ForegroundColor Cyan
    Write-Host "          |" -ForegroundColor Magenta
    Write-Host "    |      " -NoNewline -ForegroundColor Magenta
    Write-Host "Running on UltraSPARC-IIIi @ 1.6GHz" -NoNewline -ForegroundColor White
    Write-Host "     |" -ForegroundColor Magenta
    Write-Host "    +=================================================+" -ForegroundColor Magenta
    Write-Host "    |                                                 |" -ForegroundColor Magenta
    Write-Host "    |  " -NoNewline -ForegroundColor Magenta
    Write-Host "The Network Is The Computer(TM) - Now With Torrents!" -NoNewline -ForegroundColor Yellow
    Write-Host " |" -ForegroundColor Magenta
    Write-Host "    |                                                 |" -ForegroundColor Magenta
    Write-Host "    |      CDE Desktop Environment: Not Required      |" -ForegroundColor Magenta
    Write-Host "    |      Java(TM) Technology: Definitely Included   |" -ForegroundColor Magenta
    Write-Host "    |      ZFS Snapshots: For Your Downloads          |" -ForegroundColor Magenta
    Write-Host "    |                                                 |" -ForegroundColor Magenta
    Write-Host "    +=================================================+" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "sunblade2500 console login: root" -ForegroundColor Green
    Write-Host "Password:" -ForegroundColor Green
    Write-Host "Last login: Thu Jun 6 13:37:00 on console" -ForegroundColor White
    Write-Host "Sun Microsystems Inc.   SunOS 5.10      Generic January 2005" -ForegroundColor White
    Write-Host "# /opt/getmovies/bin/getmovies --duke-nukem-mode" -ForegroundColor Green
    Write-Host ""
    Write-Host "Press Enter to download at the speed of light..." -ForegroundColor Yellow
    Read-Host
}

# History Functions for Computer Systems
function Show-History1 {
    # BBS Terminal History
    Write-Host "    BBS (Bulletin Board System) terminals were the beating heart of early"
    Write-Host "    online communities in the 1980s and 1990s. These text-based systems,"
    Write-Host "    accessed via dial-up modems, created the first virtual neighborhoods"
    Write-Host "    where young computer enthusiasts could share software, exchange messages,"
    Write-Host "    and collaborate on projects. Small businesses discovered they could reach"
    Write-Host "    customers directly through BBS advertising and file sharing,"
    Write-Host "    revolutionizing how commerce operated in the digital age. For countless"
    Write-Host "    teenagers with modems, BBSes were their first taste of the"
    Write-Host "    interconnected world, teaching them about networking, system"
    Write-Host "    administration, and digital citizenship. The BBS era spawned a"
    Write-Host "    generation of entrepreneurs who learned that a single computer and"
    Write-Host "    phone line could connect them to the world. Many of today's internet"
    Write-Host "    pioneers credit their first BBS experiences as the spark that ignited"
    Write-Host "    their passion for technology and community building."
}

function Show-History2 {
    # BBC Micro History  
    Write-Host "    The BBC Micro, launched in 1981, transformed how an entire generation"
    Write-Host "    of British children first encountered computing. Born from a partnership"
    Write-Host "    between the BBC and Acorn Computers, this remarkable machine brought"
    Write-Host "    programming into living rooms across the UK, teaching millions their"
    Write-Host "    first lines of BASIC code. The BBC's Computer Literacy Project ensured"
    Write-Host "    that schools nationwide had access to these machines, democratizing"
    Write-Host "    computer education in an unprecedented way. Small businesses embraced"
    Write-Host "    the BBC Micro for everything from accounting to inventory management,"
    Write-Host "    discovering that powerful computing didn't require massive corporate"
    Write-Host "    budgets. The machine's built-in programming languages and excellent"
    Write-Host "    documentation turned curious children into confident programmers, many"
    Write-Host "    of whom would go on to shape the video game and software industries."
    Write-Host "    The BBC Micro proved that when governments, educators, and technologists"
    Write-Host "    collaborate with vision, they can change the trajectory of an entire"
    Write-Host "    nation's relationship with technology."
}

function Show-History3 {
    # C64 BASIC History
    Write-Host "    The Commodore 64's BASIC programming environment became the gateway"
    Write-Host "    drug for an entire generation's addiction to computing. Released in"
    Write-Host "    1982, the C64 made programming accessible to millions of families who"
    Write-Host "    could finally afford a 'real' computer, transforming kitchen tables"
    Write-Host "    into command centers of digital creativity. Young programmers learned"
    Write-Host "    that with just a few lines of BASIC code, they could create games,"
    Write-Host "    music, and art, discovering that they weren't just consumers of"
    Write-Host "    technology but its creators. Small businesses found the C64's"
    Write-Host "    affordability revolutionary, enabling mom-and-pop shops to computerize"
    Write-Host "    their operations for the first time in history. The machine's ubiquity"
    Write-Host "    meant that programming knowledge spread like wildfire through"
    Write-Host "    neighborhoods, schools, and youth groups, creating informal networks of"
    Write-Host "    coding mentorship. The C64's BASIC interpreter didn't just teach"
    Write-Host "    syntax; it taught an entire generation that computers were tools of"
    Write-Host "    empowerment, creativity, and limitless possibility."
}

function Show-History4 {
    # War Games History
    Write-Host "    The 1983 film 'WarGames' didn't just entertain audiences; it"
    Write-Host "    fundamentally changed how society viewed computers and their potential"
    Write-Host "    impact on our world. The movie introduced mainstream culture to"
    Write-Host "    concepts like hacking, artificial intelligence, and computer security,"
    Write-Host "    inspiring countless young viewers to explore computing as both hobby"
    Write-Host "    and career path. David Lightman's character showed teenagers that"
    Write-Host "    computers weren't just tools for big corporations, but gateways to"
    Write-Host "    adventure, knowledge, and even global importance. The film's portrayal"
    Write-Host "    of amateur computer enthusiasts affecting real-world systems sparked"
    Write-Host "    important conversations about cybersecurity and digital responsibility."
    Write-Host "    Small computer stores reported surges in sales of modems and"
    Write-Host "    programming books following the movie's release, as aspiring hackers"
    Write-Host "    sought to recreate the digital magic they'd witnessed on screen."
    Write-Host "    WarGames proved that popular culture could be a powerful catalyst for"
    Write-Host "    technological adoption, turning what might have remained a niche hobby"
    Write-Host "    into a generational movement toward digital literacy."
}

function Show-History5 {
    # Amiga Workbench History
    Write-Host "    The Amiga Workbench revolutionized personal computing by proving that"
    Write-Host "    powerful multimedia capabilities didn't require corporate budgets or"
    Write-Host "    mainframe systems. Launched in 1985, the Amiga's intuitive graphical"
    Write-Host "    interface and unprecedented audio-visual capabilities turned bedroom"
    Write-Host "    programmers into digital artists, musicians, and filmmakers. Young"
    Write-Host "    creators discovered they could produce television-quality animations"
    Write-Host "    and CD-quality music from their bedrooms, democratizing media"
    Write-Host "    production in ways previously unimaginable. Small video production"
    Write-Host "    companies and graphic design firms found the Amiga offered professional"
    Write-Host "    capabilities at consumer prices, enabling them to compete with larger"
    Write-Host "    studios for the first time. The machine's multitasking operating"
    Write-Host "    system taught users to think differently about computing, showing them"
    Write-Host "    that computers could be creative partners rather than mere calculation"
    Write-Host "    tools. The Amiga community fostered a culture of sharing and"
    Write-Host "    innovation that influenced modern open-source movements, proving that"
    Write-Host "    passionate users could push technology far beyond its creators'"
    Write-Host "    original vision."
}

function Show-History6 {
    # Norton Commander History
    Write-Host "    Norton Commander transformed file management from a mysterious technical"
    Write-Host "    skill into an intuitive, visual experience that empowered users to"
    Write-Host "    take control of their digital lives. Released in 1986, this dual-pane"
    Write-Host "    file manager showed users that they didn't need to memorize cryptic"
    Write-Host "    DOS commands to organize their computers effectively. Small businesses"
    Write-Host "    discovered that Norton Commander made training new employees on"
    Write-Host "    computer systems dramatically easier, reducing the barrier to office"
    Write-Host "    computerization. The program's popularity spawned an entire genre of"
    Write-Host "    file management tools, proving that sometimes the most revolutionary"
    Write-Host "    software solves the most basic human needs. Young computer users found"
    Write-Host "    that Norton Commander made them feel like digital explorers,"
    Write-Host "    navigating through directory structures with confidence and purpose."
    Write-Host "    The software's success demonstrated that user interface design could"
    Write-Host "    be the difference between technology remaining in expert hands or"
    Write-Host "    becoming truly democratized for everyone."
}

function Show-History7 {
    # Arcade Cabinet History
    Write-Host "    Arcade cabinets were the cathedrals of early gaming culture, creating"
    Write-Host "    shared spaces where young people gathered to test their skills, forge"
    Write-Host "    friendships, and witness the birth of interactive entertainment. These"
    Write-Host "    towering monuments to digital artistry transformed corner stores, pizza"
    Write-Host "    parlors, and dedicated arcades into community centers where quarters"
    Write-Host "    were currency and high scores were social status. For many small"
    Write-Host "    business owners, arcade cabinets provided a new revenue stream that"
    Write-Host "    could transform a struggling location into a neighborhood destination."
    Write-Host "    Young players learned lessons in perseverance, hand-eye coordination,"
    Write-Host "    and strategic thinking while quarters clinked into machines that would"
    Write-Host "    shape the future of entertainment. The arcade scene fostered a culture"
    Write-Host "    of mentorship where experienced players guided newcomers, creating"
    Write-Host "    informal apprenticeships in gaming excellence. Arcade cabinets proved"
    Write-Host "    that technology could bring people together physically even as it"
    Write-Host "    transported them to digital worlds, establishing gaming as a"
    Write-Host "    fundamentally social experience that would influence entertainment"
    Write-Host "    design for decades to come."
}

function Show-History8 {
    # Apple II History
    Write-Host "    The Apple II, launched in 1977, transformed personal computing from a"
    Write-Host "    hobbyist curiosity into a mainstream revolution that would reshape"
    Write-Host "    education, business, and home life forever. Steve Wozniak's elegant"
    Write-Host "    design made computers accessible to non-technical users for the first"
    Write-Host "    time, proving that technology could be both powerful and approachable."
    Write-Host "    Schools across America embraced the Apple II as their gateway to"
    Write-Host "    computer literacy, teaching millions of students that technology was a"
    Write-Host "    tool for learning, creativity, and problem-solving. Small businesses"
    Write-Host "    discovered they could automate bookkeeping, inventory, and customer"
    Write-Host "    management with software that didn't require computer science degrees"
    Write-Host "    to operate. The Apple II's success spawned an entire ecosystem of"
    Write-Host "    software developers, peripheral manufacturers, and support services,"
    Write-Host "    creating countless entrepreneurial opportunities. Young programmers"
    Write-Host "    found that the Apple II's open architecture and excellent"
    Write-Host "    documentation made it the perfect platform for learning, launching"
    Write-Host "    careers that would define the technology industry for generations."
}

function Show-History9 {
    # ZX Spectrum History
    Write-Host "    The ZX Spectrum brought computing to the masses in 1982 Britain,"
    Write-Host "    proving that revolutionary technology didn't require revolutionary"
    Write-Host "    budgets. Sir Clive Sinclair's affordable marvel turned thousands of"
    Write-Host "    teenagers into programmers overnight, as its £125 price tag made"
    Write-Host "    computer ownership possible for working-class families for the first"
    Write-Host "    time. The Spectrum's unique keyboard and colorful graphics"
    Write-Host "    capabilities inspired a generation of young developers to create"
    Write-Host "    games, utilities, and artwork that rivaled professional productions."
    Write-Host "    Small software companies discovered they could develop and distribute"
    Write-Host "    programs using nothing more than cassette tapes, creating a cottage"
    Write-Host "    industry of bedroom coders who would shape the British gaming"
    Write-Host "    industry. The machine's limitations became features as young"
    Write-Host "    programmers learned to achieve remarkable results within tight"
    Write-Host "    constraints, developing optimization skills that would serve them"
    Write-Host "    throughout their careers. The ZX Spectrum proved that with creativity"
    Write-Host "    and determination, even the most modest hardware could unlock infinite"
    Write-Host "    possibilities for those brave enough to explore them."
}

function Show-History10 {
    # Atari 800 History
    Write-Host "    The Atari 800 represented the perfect fusion of serious computing"
    Write-Host "    power and playful creativity, showing families that computers could be"
    Write-Host "    both educational tools and entertainment centers. Released in 1979,"
    Write-Host "    the 800's sophisticated graphics and sound capabilities made it a"
    Write-Host "    favorite among young programmers who discovered they could create"
    Write-Host "    arcade-quality games from their bedrooms. Educational software for the"
    Write-Host "    Atari 800 transformed how children learned mathematics, reading, and"
    Write-Host "    problem-solving, proving that interactive learning could be more"
    Write-Host "    effective than traditional methods. Small businesses found the Atari"
    Write-Host "    800's word processing and database capabilities remarkably powerful"
    Write-Host "    for its price point, enabling them to professionalize their"
    Write-Host "    operations without breaking budgets. The machine's modular design and"
    Write-Host "    expandability taught users that computers were evolving systems that"
    Write-Host "    could grow with their needs and ambitions. Young Atari 800 owners"
    Write-Host "    learned that computing was about exploration and experimentation,"
    Write-Host "    developing curiosity and technical confidence that would serve them"
    Write-Host "    throughout the emerging digital age."
}

function Show-History11 {
    # TRS-80 History
    Write-Host "    The TRS-80, affectionately known as the 'Trash-80,' democratized"
    Write-Host "    computing by making it available at neighborhood Radio Shack stores"
    Write-Host "    across America starting in 1977. This humble machine proved that"
    Write-Host "    computers didn't need to be intimidating or expensive to change"
    Write-Host "    lives, as thousands of curious customers discovered the joy of"
    Write-Host "    programming right on store floors. Small business owners found the"
    Write-Host "    TRS-80's business software surprisingly capable, enabling them to"
    Write-Host "    computerize operations that had been manual for generations. Young"
    Write-Host "    programmers learned that the machine's limitations were actually"
    Write-Host "    lessons in efficiency and creativity, as working within constraints"
    Write-Host "    often produced more elegant solutions. The TRS-80's ubiquity in retail"
    Write-Host "    locations meant that computing knowledge spread geographically in ways"
    Write-Host "    that might never have happened through specialized computer stores"
    Write-Host "    alone. Radio Shack's support network created a nationwide community"
    Write-Host "    of TRS-80 users who shared programs, tips, and enthusiasm through"
    Write-Host "    newsletters and user groups, proving that technology adoption thrives"
    Write-Host "    when supported by human connection."
}

function Show-History12 {
    # MSX Computer History
    Write-Host "    The MSX standard, launched in 1983, represented an ambitious vision of"
    Write-Host "    computing unity that would influence how young people around the world"
    Write-Host "    first encountered programming and digital creativity. This Japanese-led"
    Write-Host "    initiative created a common platform that allowed software to run"
    Write-Host "    across dozens of different manufacturers' machines, teaching users"
    Write-Host "    that collaboration could be more powerful than competition. Young MSX"
    Write-Host "    users in countries from Japan to Brazil discovered they could share"
    Write-Host "    programs and ideas across vast distances, creating one of the first"
    Write-Host "    truly international computing communities. Small software developers"
    Write-Host "    found that the MSX standard gave them access to global markets without"
    Write-Host "    the complexity of supporting dozens of incompatible systems. The MSX's"
    Write-Host "    emphasis on home and educational use meant that families worldwide"
    Write-Host "    could afford to bring computing into their daily lives, democratizing"
    Write-Host "    access to digital literacy. The MSX movement proved that when industry"
    Write-Host "    leaders prioritize compatibility and accessibility over proprietary"
    Write-Host "    advantage, the entire computing ecosystem benefits from increased"
    Write-Host "    innovation and adoption."
}

function Show-History13 {
    # VIC-20 History
    Write-Host "    The VIC-20, Commodore's 'friendly computer,' opened the door to"
    Write-Host "    computing for millions of families who had been intimidated by the"
    Write-Host "    complexity and cost of early personal computers. Released in 1980,"
    Write-Host "    this colorful machine proved that computers could be approachable and"
    Write-Host "    fun, not just serious business tools reserved for experts and"
    Write-Host "    corporations. Young VIC-20 owners discovered that programming didn't"
    Write-Host "    require advanced mathematics or computer science training, as the"
    Write-Host "    machine's simple BASIC interpreter made coding feel like a game rather"
    Write-Host "    than work. Small businesses found the VIC-20's word processing and"
    Write-Host "    simple database capabilities perfect for modernizing operations"
    Write-Host "    without overwhelming non-technical employees. The machine's"
    Write-Host "    affordability meant that computing knowledge spread through communities"
    Write-Host "    organically, as friends and neighbors shared discoveries and learned"
    Write-Host "    together. The VIC-20's success demonstrated that the key to technology"
    Write-Host "    adoption wasn't just powerful features, but making those features"
    Write-Host "    accessible and non-intimidating to everyday people who simply wanted"
    Write-Host "    to explore digital possibilities."
}

function Show-History14 {
    # Tandy CoCo History
    Write-Host "    The Tandy Color Computer, affectionately known as the CoCo, brought"
    Write-Host "    vibrant computing experiences to families across America through Radio"
    Write-Host "    Shack's extensive retail network. Launched in 1980, the CoCo's"
    Write-Host "    colorful graphics and accessible programming environment turned"
    Write-Host "    thousands of young users into digital artists and game developers."
    Write-Host "    The machine's unique OS-9 operating system introduced many users to"
    Write-Host "    multitasking concepts years before they became mainstream, preparing"
    Write-Host "    them for the future of computing. Small businesses discovered that the"
    Write-Host "    CoCo's affordable price point and powerful capabilities made it perfect"
    Write-Host "    for tasks ranging from inventory management to simple accounting. The"
    Write-Host "    CoCo community developed a passionate following of users who shared"
    Write-Host "    programs through newsletters and bulletin boards, creating networks of"
    Write-Host "    mutual support and learning. Young CoCo programmers learned that"
    Write-Host "    creativity mattered more than expensive hardware, as the machine's"
    Write-Host "    limitations inspired ingenious solutions that would influence their"
    Write-Host "    problem-solving approaches throughout their careers."
}

function Show-History15 {
    # SEGA Genesis History
    Write-Host "    The SEGA Genesis revolutionized home gaming by proving that cutting-edge"
    Write-Host "    arcade experiences could thrive in living rooms, inspiring a generation"
    Write-Host "    of young players to dream of careers in game development. Released in"
    Write-Host "    1988, the Genesis brought 16-bit graphics and CD-quality sound to"
    Write-Host "    homes, showing families that video games were evolving into"
    Write-Host "    sophisticated entertainment media. Young Genesis owners discovered that"
    Write-Host "    games could tell complex stories, feature memorable characters, and"
    Write-Host "    create emotional experiences that rivaled movies and books. Small video"
    Write-Host "    game stores found the Genesis created new business opportunities, as"
    Write-Host "    the demand for games, accessories, and magazines created thriving local"
    Write-Host "    gaming ecosystems. The Genesis's success challenged Nintendo's"
    Write-Host "    dominance and proved that competition drives innovation, teaching young"
    Write-Host "    consumers that they had choices and power in the marketplace. The"
    Write-Host "    console's influence extended beyond gaming, as its marketing campaigns"
    Write-Host "    and cultural impact showed young people that technology companies could"
    Write-Host "    be cool, rebellious, and aligned with youth culture rather than just"
    Write-Host "    corporate interests."
}

function Show-History16 {
    # Matrix Rain History (moved from position 2)
    Write-Host "    The Matrix's digital rain effect became one of cinema's most iconic"
    Write-Host "    visual metaphors for the intersection of technology and reality,"
    Write-Host "    inspiring countless young viewers to pursue careers in programming and"
    Write-Host "    cybersecurity. The 1999 film's portrayal of code as a living, flowing"
    Write-Host "    entity transformed how people visualized the relationship between"
    Write-Host "    humans and digital systems. Young programmers found themselves"
    Write-Host "    captivated by the idea that understanding code could unlock hidden"
    Write-Host "    realities and provide power to change the world. Small tech companies"
    Write-Host "    adopted Matrix-inspired aesthetics in their products and marketing,"
    Write-Host "    recognizing that the film had made cyberpunk culture mainstream and"
    Write-Host "    commercially viable. The movie's emphasis on choosing between"
    Write-Host "    comfortable illusion and difficult truth resonated with a generation"
    Write-Host "    coming of age during the internet revolution. The Matrix proved that"
    Write-Host "    science fiction could be a powerful recruiting tool for the technology"
    Write-Host "    industry, making programming seem like the ultimate form of rebellion"
    Write-Host "    and enlightenment rather than just a career choice."
}

function Show-History17 {
    # OS/2 Warp History
    Write-Host "    OS/2 Warp represented IBM's bold vision of multitasking computing for"
    Write-Host "    everyone, showing small businesses and power users that they didn't"
    Write-Host "    need to choose between stability and innovation. Released in 1994,"
    Write-Host "    Warp's preemptive multitasking and robust architecture demonstrated"
    Write-Host "    that desktop computers could handle enterprise-level workloads without"
    Write-Host "    crashing or slowing down. Small businesses discovered that OS/2's"
    Write-Host "    reliability and security features made it perfect for mission-critical"
    Write-Host "    applications where downtime meant lost revenue. Young computer"
    Write-Host "    enthusiasts found that OS/2's advanced features and professional tools"
    Write-Host "    gave them capabilities usually reserved for expensive workstations and"
    Write-Host "    servers. The operating system's emphasis on object-oriented design"
    Write-Host "    and workplace efficiency influenced how users thought about organizing"
    Write-Host "    their digital lives and workflows. OS/2 Warp proved that even"
    Write-Host "    unsuccessful products could advance the entire industry by introducing"
    Write-Host "    concepts and capabilities that would eventually become standard in all"
    Write-Host "    operating systems."
}

function Show-History18 {
    # BeOS History
    Write-Host "    BeOS represented a radical reimagining of what personal computers"
    Write-Host "    could become, inspiring young developers and multimedia creators to"
    Write-Host "    dream of more responsive, elegant computing experiences. Launched in"
    Write-Host "    1995, BeOS's pervasive multithreading and real-time performance"
    Write-Host "    capabilities showed that operating systems could be designed for"
    Write-Host "    creativity rather than just productivity. Young musicians and video"
    Write-Host "    editors discovered that BeOS could handle multiple audio and video"
    Write-Host "    streams simultaneously without dropouts, enabling bedroom producers to"
    Write-Host "    create professional-quality content. Small multimedia companies found"
    Write-Host "    that BeOS workstations could compete with expensive specialized"
    Write-Host "    hardware for a fraction of the cost, democratizing high-end content"
    Write-Host "    creation. The BeOS community developed a passionate following of"
    Write-Host "    developers who appreciated the system's clean architecture and"
    Write-Host "    developer-friendly design philosophy. BeOS proved that innovation in"
    Write-Host "    computing could come from anywhere, not just established tech giants,"
    Write-Host "    inspiring a generation of entrepreneurs to believe that small teams"
    Write-Host "    with big visions could still change the world."
}

function Show-History19 {
    # NeXTSTEP History
    Write-Host "    NeXTSTEP revolutionized software development by proving that object-"
    Write-Host "    oriented programming and advanced development tools could make creating"
    Write-Host "    complex applications as intuitive as arranging building blocks. Steve"
    Write-Host "    Jobs's post-Apple venture created a platform that influenced virtually"
    Write-Host "    every modern operating system, from macOS to Windows to Linux. Young"
    Write-Host "    developers discovered that NeXTSTEP's Interface Builder and development"
    Write-Host "    frameworks made them incredibly productive, enabling small teams to"
    Write-Host "    create sophisticated applications that previously required large"
    Write-Host "    development staffs. Universities and research institutions found"
    Write-Host "    NeXTSTEP perfect for academic computing, as its Unix foundation and"
    Write-Host "    advanced graphics capabilities supported both serious computation and"
    Write-Host "    innovative user interface research. The platform's emphasis on elegant"
    Write-Host "    design and powerful abstractions taught a generation of programmers"
    Write-Host "    that code could be both functional and beautiful. NeXTSTEP proved that"
    Write-Host "    sometimes the most important technology isn't the most popular, as its"
    Write-Host "    influence can be measured not in sales figures but in how it shapes"
    Write-Host "    the thinking of those who create the future."
}

function Show-History20 {
    # Sun Solaris History
    Write-Host "    Sun Solaris transformed enterprise computing by proving that Unix"
    Write-Host "    systems could be both powerful and approachable, enabling small"
    Write-Host "    businesses to access capabilities previously reserved for large"
    Write-Host "    corporations and research institutions. Released in 1992, Solaris's"
    Write-Host "    scalability and reliability made it the backbone of the early"
    Write-Host "    internet, supporting everything from web servers to financial trading"
    Write-Host "    systems. Young system administrators discovered that Solaris taught"
    Write-Host "    them to think about computing in terms of networks and distributed"
    Write-Host "    systems rather than isolated desktop machines. Small internet service"
    Write-Host "    providers and web hosting companies found Solaris the perfect platform"
    Write-Host "    for building the infrastructure that would support the dot-com boom"
    Write-Host "    and beyond. The operating system's emphasis on standards and"
    Write-Host "    interoperability helped establish the principles that would guide"
    Write-Host "    enterprise computing for decades. Solaris proved that 'The Network Is"
    Write-Host "    The Computer' wasn't just a marketing slogan but a fundamental truth"
    Write-Host "    about how computing was evolving, preparing users for a world where"
    Write-Host "    connectivity and collaboration would matter more than individual"
    Write-Host "    processing power."
}

# History Display Functions
function Show-History {
    do {
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Magenta
        Write-Host "    |                    COMPUTER HISTORY DATABASE                          |" -ForegroundColor Yellow
        Write-Host "    +======================================================================+" -ForegroundColor Magenta
        Write-Host ""
        Write-Host "    EXPLORE THE LEGENDS THAT SHAPED THE DIGITAL REVOLUTION!" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | RETRO COMPUTER SYSTEMS (1-10)                                        |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        
        # Display systems 1-10
        for ($i = 1; $i -le 10; $i++) {
            $splash = $Script:SplashScreens["$i"]
            $num = "[$i]".PadRight(5)
            Write-Host "    $num $($splash.Name.PadRight(25))" -NoNewline -ForegroundColor Green
            if ($i % 2 -eq 0) { Write-Host "" } else { Write-Host "  " -NoNewline }
        }
        Write-Host ""
        Write-Host ""
        
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | ADVANCED SYSTEMS (11-20)                                             |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        
        # Display systems 11-20
        for ($i = 11; $i -le 20; $i++) {
            $splash = $Script:SplashScreens["$i"]
            $num = "[$i]".PadRight(6)
            Write-Host "    $num $($splash.Name.PadRight(25))" -NoNewline -ForegroundColor Yellow
            if ($i % 2 -eq 0) { Write-Host "" } else { Write-Host " " -NoNewline }
        }
        Write-Host ""
        Write-Host ""
        
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
        Write-Host "    | SELECT NUMBER TO VIEW HISTORY                                        |" -ForegroundColor White
        Write-Host "    | [B] BACK TO MENU                                                     |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Yellow
        $historyChoice = Read-Host
        
        if ($historyChoice -eq "B" -or $historyChoice -eq "b") {
            return
        }
        elseif ($historyChoice -match "^([1-9]|1[0-9]|20)$" -and $Script:SplashScreens.ContainsKey($historyChoice)) {
            Show-HistoryDetail -systemNumber $historyChoice
        }
        else {
            Write-Host "    INVALID SELECTION!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
        
    } while ($true)
}

function Show-HistoryDetail {
    param([string]$systemNumber)
    
    Clear-Host
    Write-Host ""
    Write-Host "    +======================================================================+" -ForegroundColor Magenta
    Write-Host "    |                    COMPUTER HISTORY DATABASE                          |" -ForegroundColor Yellow
    Write-Host "    +======================================================================+" -ForegroundColor Magenta
    Write-Host ""
    
    $systemName = $Script:SplashScreens[$systemNumber].Name.ToUpper()
    Write-Host "    SYSTEM: $systemName" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Green
    Write-Host "    | HISTORICAL IMPACT                                                    |" -ForegroundColor White
    Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Green
    Write-Host ""
    
    # Call the appropriate history function
    switch ([int]$systemNumber) {
        1 { Show-History1 }
        2 { Show-History2 }
        3 { Show-History3 }
        4 { Show-History4 }
        5 { Show-History5 }
        6 { Show-History6 }
        7 { Show-History7 }
        8 { Show-History8 }
        9 { Show-History9 }
        10 { Show-History10 }
        11 { Show-History11 }
        12 { Show-History12 }
        13 { Show-History13 }
        14 { Show-History14 }
        15 { Show-History15 }
        16 { Show-History16 }
        17 { Show-History17 }
        18 { Show-History18 }
        19 { Show-History19 }
        20 { Show-History20 }
    }
    
    Write-Host ""
    Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
    Write-Host "    | [B] BACK TO HISTORY MENU                                             |" -ForegroundColor White
    Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Yellow
    $backChoice = Read-Host
    
    # Return to history menu regardless of input
}


# Initialize on load
Load-UserConfig
Show-SplashScreen

function Perform-Search {
    param(
        [string]$searchTerm,
        [int]$resultCount = 10,
        [bool]$skipAnimation = $false,
        [bool]$useQuickMode = $false
    )
    
    # Show search header
    Write-Host ""
    Write-Host "    +======================================================================+" -ForegroundColor Cyan
    Write-Host "    |                    MOVIE SEARCH DATABASE Version $Script:ApplicationVersion                        |" -ForegroundColor Yellow
    Write-Host "    +======================================================================+" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    SEARCHING FOR: $($searchTerm.ToUpper())" -ForegroundColor Green
    Write-Host ""
    Write-Host "    RESULTS TO DISPLAY: $resultCount" -ForegroundColor Cyan
    Write-Host ""
    
    # Encode and create URL
    $encodedSearchTerm = $searchTerm -replace ' ', '%20'
    $url = "https://thepiratebay10.info/search/$encodedSearchTerm/1/99/200"
    
    if (-not $skipAnimation) {
        Write-Host ""
        
        # Set delays based on quick mode
        if ($useQuickMode) {
            $stepDelay = 50      # 10x faster (was 500ms)
            $bufferDelay = 5     # 10x faster (was 50ms)
            Write-Host "    INITIALIZING SEARCH MATRIX [QUICK MODE]..." -ForegroundColor Green
        } else {
            $stepDelay = 500     # Original delay
            $bufferDelay = 50    # Original delay
            Write-Host "    INITIALIZING SEARCH MATRIX..." -ForegroundColor Yellow
        }
        
        # Fake loading animation
        $loadingSteps = @(
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
            "OPTIMIZING DOWNLOAD QUEUE..."
        )

        # Progress bar example
        $totalSteps = $loadingSteps.Count
        $currentStep = 0

        foreach ($step in $loadingSteps) {
            $currentStep++
            $percentComplete = [int](($currentStep / $totalSteps) * 100)

            Write-Host "`r$step" -NoNewline -ForegroundColor Green
            Write-Host "`n[" -NoNewline
            Write-Host ("#" * ($percentComplete / 5)) -NoNewline -ForegroundColor Yellow
            Write-Host ("-" * (20 - ($percentComplete / 5))) -NoNewline
            Write-Host "] $percentComplete%"

            Start-Sleep -Milliseconds $stepDelay
        }
        
        Write-Host ""
        Write-Host "[Yea-Buffering" -NoNewline -ForegroundColor Green
        for ($i = 0; $i -lt 36; $i++) {
            Write-Host "=" -NoNewline -ForegroundColor Green
            Start-Sleep -Milliseconds $bufferDelay
        }
        Write-Host "] 100% COMPLETE" -ForegroundColor Green
    }
    else {
        Write-Host "    REFRESHING RESULTS..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 500
    }
    
    try {
        $htmlContent = Invoke-WebRequest -Uri $url -UseBasicParsing
        $htmlContentRaw = $htmlContent.Content
        
        # Find table
        $tableMatch = [regex]::Match($htmlContentRaw, "<table.*?>.*?</table>", [System.Text.RegularExpressions.RegexOptions]::Singleline)
        if (!$tableMatch.Success) {
            Write-Host "    NO RESULTS FOUND IN DATABASE" -ForegroundColor Red
            Read-Host "    PRESS ENTER TO CONTINUE"
            return
        }
        
        # Find rows
        $rowMatches = [regex]::Matches($tableMatch.Value, "<tr.*?>.*?</tr>", [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        # Display results
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Green
        Write-Host "    |                      SEARCH RESULTS FOUND!                           |" -ForegroundColor Green
        Write-Host "    +======================================================================+" -ForegroundColor Green
        Write-Host "    | SEARCH QUERY: $($searchTerm.ToUpper())" -ForegroundColor Yellow
        Write-Host "    +======================================================================+" -ForegroundColor Green
        Write-Host ""
        
        $maxResults = [Math]::Min($rowMatches.Count, $resultCount + 1)
        for ($i = 1; $i -lt $maxResults; $i++) {
            $columnMatches = [regex]::Matches($rowMatches[$i].Value, "<(td|th).*?>.*?</(td|th)>", [System.Text.RegularExpressions.RegexOptions]::Singleline)
            
            if ($columnMatches.Count -ge 6) {
                $description = $columnMatches[1].Value -replace "<.*?>", "" -replace "\s+", " "
                $size = $columnMatches[4].Value -replace "<.*?>", "" -replace "&nbsp;", " " -replace "\s+", " "
                $seeders = $columnMatches[5].Value -replace "<.*?>", "" -replace "\s+"
                
                # Truncate long titles
                if ($description.Length -gt 60) {
                    $description = $description.Substring(0, 57) + "..."
                }
                
                Write-Host "    [$i] $description" -ForegroundColor Yellow
                Write-Host "        SIZE: $size | SEEDS: $seeders | STATUS: ACTIVE" -ForegroundColor Green
                Write-Host ""
            }
        }
        
        # Selection menu
        Write-Host "    +======================================================================+" -ForegroundColor Cyan
        Write-Host "    | [1-$($maxResults-1)] DOWNLOAD | [20] SHOW 20 | [30] SHOW 30 | [B] BACK TO MENU   |" -ForegroundColor White
        Write-Host "    +======================================================================+" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Yellow
        $selection = Read-Host
        
        if ($selection -eq "B" -or $selection -eq "b") {
            return
        }
        elseif ($selection -eq "20") {
            # Re-run search with 20 results
            Clear-Host
            Perform-Search -searchTerm $searchTerm -resultCount 20 -skipAnimation $true
            return
        }
        elseif ($selection -eq "30") {
            # Re-run search with 30 results
            Clear-Host
            Perform-Search -searchTerm $searchTerm -resultCount 30 -skipAnimation $true
            return
        }
        elseif ($selection -match "^\d+$" -and [int]$selection -ge 1 -and [int]$selection -lt $maxResults) {
            $selectedRow = $rowMatches[[int]$selection].Value
            
            # Find magnet link
            $magnetIndex = $selectedRow.IndexOf("magnet:")
            if ($magnetIndex -ge 0) {
                # Extract magnet link
                $endIndex = $selectedRow.IndexOf([char]34, $magnetIndex)
                if ($endIndex -gt $magnetIndex) {
                    $magnetLink = $selectedRow.Substring($magnetIndex, $endIndex - $magnetIndex)
                    
                    # Launch qBittorrent
                    $qBittorrentPath = "C:\Program Files\qBittorrent\qbittorrent.exe"
                    if (Test-Path $qBittorrentPath) {
                        Write-Host ""
                        Write-Host "    INITIATING DOWNLOAD SEQUENCE..." -ForegroundColor Green
                        Write-Host "    [MODEM NOISE] BEEP BOOP BEEP" -ForegroundColor DarkGray
                        Start-Process -FilePath $qBittorrentPath -ArgumentList $magnetLink
                        Write-Host "    DOWNLOAD STARTED SUCCESSFULLY!" -ForegroundColor Green
                        Start-Sleep -Seconds 2
                    }
                    else {
                        Write-Host "    ERROR: QBITTORRENT.EXE NOT FOUND" -ForegroundColor Red
                    }
                }
                else {
                    Write-Host "    ERROR: MAGNET LINK CORRUPTED" -ForegroundColor Red
                }
            }
            else {
                Write-Host "    ERROR: NO MAGNET LINK IN DATABASE" -ForegroundColor Red
            }
        }
        else {
            Write-Host "    INVALID SELECTION - TRY AGAIN" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "    CONNECTION FAILED: $_" -ForegroundColor Red
        Write-Host "    CHECK YOUR MODEM CONNECTION" -ForegroundColor Red
    }
}

function Show-TopDownloads {
    param(
        [int]$resultCount = 10,
        [bool]$skipAnimation = $false
    )
    
    Clear-Host
    Write-Host ""
    Write-Host "    +======================================================================+" -ForegroundColor Yellow
    Write-Host "    |                    TOP DOWNLOADS - HOTTEST TORRENTS                  |" -ForegroundColor Red
    Write-Host "    +======================================================================+" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    SHOWING TOP $resultCount TORRENTS" -ForegroundColor Cyan
    Write-Host ""
    
    if (-not $skipAnimation) {
        Write-Host "    ACCESSING TORRENT CHARTS DATABASE..." -ForegroundColor Green
        Write-Host "    CALCULATING POPULARITY METRICS..." -ForegroundColor Green
        Start-Sleep -Milliseconds 800
        Write-Host ""
    }
    
    # URL for top torrents (sorted by seeders)
    $topUrl = "https://thepiratebay10.info/top/200"
    
    try {
        Write-Host "    RETRIEVING HOT FILES..." -ForegroundColor Yellow
        $htmlContent = Invoke-WebRequest -Uri $topUrl -UseBasicParsing
        $htmlContentRaw = $htmlContent.Content
        
        # Find table
        $tableMatch = [regex]::Match($htmlContentRaw, "<table.*?>.*?</table>", [System.Text.RegularExpressions.RegexOptions]::Singleline)
        if (!$tableMatch.Success) {
            Write-Host "    ERROR: CHART DATABASE OFFLINE" -ForegroundColor Red
            Read-Host "    PRESS ENTER TO CONTINUE"
            return
        }
        
        # Find rows
        $rowMatches = [regex]::Matches($tableMatch.Value, "<tr.*?>.*?</tr>", [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
        Write-Host "    |                    CURRENT TOP $resultCount TORRENTS                           |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
        Write-Host ""
        
        # Display results based on resultCount
        $maxResults = [Math]::Min($rowMatches.Count, $resultCount + 1)  # +1 because first row is header
        for ($i = 1; $i -lt $maxResults; $i++) {
            $columnMatches = [regex]::Matches($rowMatches[$i].Value, "<(td|th).*?>.*?</(td|th)>", [System.Text.RegularExpressions.RegexOptions]::Singleline)
            
            if ($columnMatches.Count -ge 6) {
                $description = $columnMatches[1].Value -replace "<.*?>", "" -replace "\s+", " "
                $seeders = $columnMatches[5].Value -replace "<.*?>", "" -replace "\s+"
                $size = $columnMatches[4].Value -replace "<.*?>", "" -replace "&nbsp;", " " -replace "\s+", " "
                
                # Truncate long titles
                if ($description.Length -gt 50) {
                    $description = $description.Substring(0, 47) + "..."
                }
                
                # Ranking display
                $rank = switch ($i) {
                    1 { "GOLD   " }
                    2 { "SILVER " }
                    3 { "BRONZE " }
                    default { "TOP $i  " }
                }
                
                Write-Host "    [$rank] $description" -ForegroundColor $(if ($i -le 3) { "Yellow" } else { "Green" })
                Write-Host "             SIZE: $size | SEEDS: $seeders | HEAT: $(if ([int]$seeders -gt 1000) { "BLAZING" } elseif ([int]$seeders -gt 500) { "HOT" } else { "WARM" })" -ForegroundColor DarkGray
                Write-Host ""
            }
        }
        
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
        Write-Host "    | [1-$($maxResults-1)] DOWNLOAD | [20] SHOW 20 | [30] SHOW 30 | [B] BACK TO MENU  |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Yellow
        $topChoice = Read-Host
        
        if ($topChoice -eq "B" -or $topChoice -eq "b") {
            # Just return - no "Press any key" prompt
            return
        }
        elseif ($topChoice -eq "20") {
            # Re-show with 20 results
            Show-TopDownloads -resultCount 20 -skipAnimation $true
            return
        }
        elseif ($topChoice -eq "30") {
            # Re-show with 30 results
            Show-TopDownloads -resultCount 30 -skipAnimation $true
            return
        }
        elseif ($topChoice -match "^\d+$" -and [int]$topChoice -ge 1 -and [int]$topChoice -lt $maxResults) {
            $selectedRow = $rowMatches[[int]$topChoice].Value
            
            # Find magnet link
            $magnetIndex = $selectedRow.IndexOf("magnet:")
            if ($magnetIndex -ge 0) {
                # Extract magnet link
                $endIndex = $selectedRow.IndexOf([char]34, $magnetIndex)
                if ($endIndex -gt $magnetIndex) {
                    $magnetLink = $selectedRow.Substring($magnetIndex, $endIndex - $magnetIndex)
                    
                    # Launch qBittorrent
                    $qBittorrentPath = "C:\Program Files\qBittorrent\qbittorrent.exe"
                    if (Test-Path $qBittorrentPath) {
                        Write-Host ""
                        Write-Host "    DOWNLOADING HOT TORRENT..." -ForegroundColor Green
                        Write-Host "    [MODEM SCREAMING] EEEEEEEEEEEEEE" -ForegroundColor DarkGray
                        Start-Process -FilePath $qBittorrentPath -ArgumentList $magnetLink
                        Write-Host "    DOWNLOAD INITIATED!" -ForegroundColor Green
                        Start-Sleep -Seconds 2
                    }
                    else {
                        Write-Host "    ERROR: QBITTORRENT.EXE NOT FOUND" -ForegroundColor Red
                    }
                }
            }
        }
        else {
            Write-Host "    INVALID SELECTION - TRY AGAIN" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
        
    }
    catch {
        Write-Host "    CHART SERVER UNREACHABLE" -ForegroundColor Red
        Write-Host "    TRY AGAIN LATER" -ForegroundColor Yellow
    }
    
}

function Show-Menu {
    Clear-Host
    Write-Host ""
    Write-Host "    +======================================================================+" -ForegroundColor Magenta
    Write-Host "    |                                                                      |" -ForegroundColor Magenta
    Write-Host "    |   GGGGG  EEEEE TTTTT   M   M  OOO  V   V III EEEEE  SSSS             |" -ForegroundColor Cyan
    Write-Host "    |  G      E       T     MM MM O   O V   V  I  E     S                  |" -ForegroundColor Cyan
    Write-Host "    |  G  GG  EEEE    T     M M M O   O V   V  I  EEEE   SSS               |" -ForegroundColor Yellow
    Write-Host "    |  G   G  E       T     M   M O   O  V V   I  E         S              |" -ForegroundColor Yellow
    Write-Host "    |   GGGG  EEEEE   T     M   M  OOO    V   III EEEEE SSSS               |" -ForegroundColor Green
    Write-Host "    |                                                                      |" -ForegroundColor Magenta
    Write-Host "    |                    ###############################                   |" -ForegroundColor DarkGray
    Write-Host "    |                    #  RADICAL TORRENT FINDER    #                    |" -ForegroundColor White
    Write-Host "    |                    #      Version $Script:ApplicationVersion          #                    |" -ForegroundColor White
    Write-Host "    |                    ###############################                   |" -ForegroundColor DarkGray
    Write-Host "    |                                                                      |" -ForegroundColor Magenta
    Write-Host "    +======================================================================+" -ForegroundColor Magenta
    Write-Host ""
    # Dynamic welcome message
    $userName = if ($Script:UserName) { [string]$Script:UserName } else { "User" }
    $welcomeMsg = "WELCOME BACK, $($userName.ToUpper())! READY TO RIP?"
    $boxWidth = $welcomeMsg.Length + 4
    $topBottom = "+" + ("-" * ($boxWidth - 2)) + "+"
    $padding = [Math]::Max(0, (70 - $boxWidth) / 2)
    $spaces = " " * $padding
    
    Write-Host "$spaces$topBottom" -ForegroundColor Cyan
    Write-Host "$spaces| $welcomeMsg |" -ForegroundColor Yellow
    Write-Host "$spaces$topBottom" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    ********************************************************************" -ForegroundColor DarkMagenta
    Write-Host "    *                                                                  *" -ForegroundColor DarkMagenta
    Write-Host "    *  [1] SEARCH MOVIES & TV SHOWS      [6] SPLASH SCREENS            *" -ForegroundColor White
    Write-Host "    *  [2] RECENT SEARCHES               [7] HISTORY                   *" -ForegroundColor White
    Write-Host "    *  [3] TOP DOWNLOADS                 [8] DOCS (RETRO)              *" -ForegroundColor White
    Write-Host "    *  [4] SETTINGS                      [9] DOCS (MODERN)             *" -ForegroundColor White
    Write-Host "    *  [5] CHANGE USER NAME              [X] EXIT TO DOS               *" -ForegroundColor White
    Write-Host "    *                                                                  *" -ForegroundColor DarkMagenta
    Write-Host "    ********************************************************************" -ForegroundColor DarkMagenta
    Write-Host ""
    # Random fake system stats
    $cpuTemp = Get-Random -Minimum 45 -Maximum 65
    $ramUsed = Get-Random -Minimum 256 -Maximum 512
    $diskSpeed = Get-Random -Minimum 80 -Maximum 120
    
    # Format values with proper padding
    $cpuLoad = "{0,2}" -f (Get-Random -Min 15 -Max 45)
    $ramStr = "{0,3}" -f $ramUsed
    $diskStr = "{0,3}" -f $diskSpeed
    $ping = "{0,3}" -f (Get-Random -Min 120 -Max 250)
    $uptimeH = "{0,2}" -f (Get-Random -Min 1 -Max 99)
    $uptimeM = "{0,2}" -f (Get-Random -Min 0 -Max 59)
    
    Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host "    | SYSTEM STATUS MONITOR v1.3                                           |" -ForegroundColor DarkGray
    Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host "    | CPU: Intel 80486 DX2 66MHz | TEMP: $cpuTemp°C | LOAD: $cpuLoad%                    |" -ForegroundColor Green
    Write-Host "    | RAM: $ramStr/640KB | SWAP: ACTIVE | CACHE: OPTIMAL                       |" -ForegroundColor Green
    Write-Host "    | HDD: 420MB FREE | SPEED: $diskStr KB/s | DEFRAG: 3 DAYS AGO               |" -ForegroundColor Green
    Write-Host "    | MODEM: 56K CONNECTED | PING: $ping ms | PACKET LOSS: 0%                |" -ForegroundColor Green
    Write-Host "    | UPTIME: $uptimeH H $uptimeM M                                                    |" -ForegroundColor Green
    Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host ""
}

do {
    Show-Menu
    
    Write-Host "    ENTER COMMAND >>> " -NoNewline -ForegroundColor Cyan
    $choice = Read-Host
    
    if ($choice -eq "1") {
        # Get search term
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Cyan
        Write-Host "    |                    MOVIE SEARCH DATABASE Version $Script:ApplicationVersion                        |" -ForegroundColor Yellow
        Write-Host "    +======================================================================+" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "    ENTER MOVIE/TV SHOW NAME: " -NoNewline -ForegroundColor Green
        $searchTerm = Read-Host
        
        if ($searchTerm -eq "") {
            Write-Host "    ERROR: SEARCH TERM CANNOT BE EMPTY!" -ForegroundColor Red
            Write-Host "    PRESS ANY KEY TO CONTINUE..." -ForegroundColor Gray
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            continue
        }
        
        # Check if we've searched recently BEFORE saving new search
        $recentFile = "$PSScriptRoot\recent_searches.txt"
        $useQuickMode = $false
        if (Test-Path $recentFile) {
            $lastModified = (Get-Item $recentFile).LastWriteTime
            $timeDiff = (Get-Date) - $lastModified
            if ($timeDiff.TotalMinutes -le 60) {
                $useQuickMode = $true
            }
        }
        
        # Save to recent searches
        # Add new search at the beginning and keep only unique entries
        $existingSearches = @()
        if (Test-Path $recentFile) {
            $existingSearches = Get-Content $recentFile
        }
        $newSearches = @($searchTerm) + ($existingSearches | Where-Object { $_ -ne $searchTerm }) | Select-Object -First 10
        $newSearches | Set-Content $recentFile
        
        # Call the search function
        Perform-Search -searchTerm $searchTerm -useQuickMode $useQuickMode
    }
    elseif ($choice -eq "2") {
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Cyan
        Write-Host "    |                    RECENT SEARCH HISTORY Version $Script:ApplicationVersion                        |" -ForegroundColor Yellow
        Write-Host "    +======================================================================+" -ForegroundColor Cyan
        Write-Host ""
        
        # Load recent searches from file
        $recentFile = "$PSScriptRoot\recent_searches.txt"
        if (Test-Path $recentFile) {
            $recentSearches = Get-Content $recentFile | Select-Object -First 10
            
            if ($recentSearches.Count -gt 0) {
                Write-Host "    LOADING SEARCH CACHE..." -ForegroundColor Green
                Write-Host "    MEMORY BANK: ACCESSED" -ForegroundColor Green
                Write-Host ""
                
                $index = 1
                foreach ($search in $recentSearches) {
                    Write-Host "    [$index] $search" -ForegroundColor Yellow
                    Write-Host "        TIMESTAMP: $(Get-Date -Format 'MM/dd HH:mm')" -ForegroundColor DarkGray
                    $index++
                }
                
                Write-Host ""
                Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
                Write-Host "    | [1-$($recentSearches.Count)] RE-SEARCH | [C] CLEAR HISTORY | [B] BACK TO MENU         |" -ForegroundColor White
                Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Yellow
                $recentChoice = Read-Host
                
                if ($recentChoice -eq "C" -or $recentChoice -eq "c") {
                    Remove-Item $recentFile -Force
                    Write-Host "    SEARCH HISTORY CLEARED!" -ForegroundColor Red
                    Write-Host "    MEMORY BANK: WIPED" -ForegroundColor Red
                    Start-Sleep -Seconds 2
                }
                elseif ($recentChoice -eq "B" -or $recentChoice -eq "b") {
                    # Skip the "Press any key" prompt for back
                    continue
                }
                elseif ($recentChoice -match "^\d+$" -and [int]$recentChoice -ge 1 -and [int]$recentChoice -le $recentSearches.Count) {
                    # Re-run the search with the selected term
                    $searchTerm = $recentSearches[[int]$recentChoice - 1]
                    Write-Host "    RE-SEARCHING FOR: $searchTerm" -ForegroundColor Green
                    Start-Sleep -Seconds 1

                    # Check if we've searched recently for quick mode BEFORE updating file
                    $useQuickMode = $false
                    if (Test-Path $recentFile) {
                        $lastModified = (Get-Item $recentFile).LastWriteTime
                        $timeDiff = (Get-Date) - $lastModified
                        if ($timeDiff.TotalMinutes -le 60) {
                            $useQuickMode = $true
                        }
                    }

                    # Update recent searches - move selected search to top and remove duplicates
                    $existingSearches = Get-Content $recentFile
                    $newSearches = @($searchTerm) + ($existingSearches | Where-Object { $_ -ne $searchTerm }) | Select-Object -First 10
                    $newSearches | Set-Content $recentFile
                    
                    # Clear screen before searching
                    Clear-Host
                    
                    # Call the search function directly
                    Perform-Search -searchTerm $searchTerm -resultCount 10 -useQuickMode $useQuickMode
                    
                    # Skip the "Press any key" prompt since we're done
                    continue
                }
            }
            else {
                Write-Host "    NO RECENT SEARCHES FOUND IN MEMORY BANK" -ForegroundColor Red
            }
        }
        else {
            Write-Host "    MEMORY BANK EMPTY - NO SEARCH HISTORY" -ForegroundColor Red
            Write-Host "    TIP: SEARCH FOR MOVIES TO BUILD HISTORY" -ForegroundColor Yellow
        }
        
    }
    elseif ($choice -eq "3") {
        # Call the Top Downloads function
        Show-TopDownloads -resultCount 10
    }
    elseif ($choice -eq "4") {
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Blue
        Write-Host "    |                    SYSTEM CONFIGURATION Version $Script:ApplicationVersion                         |" -ForegroundColor Yellow
        Write-Host "    +======================================================================+" -ForegroundColor Blue
        Write-Host ""
        Write-Host "    LOADING CONFIG.SYS..." -ForegroundColor Green
        Start-Sleep -Milliseconds 500
        Write-Host "    READING AUTOEXEC.BAT..." -ForegroundColor Green
        Start-Sleep -Milliseconds 500
        Write-Host ""
        
        # Get current splash screen name
        if ($Script:SplashScreen -eq "0") {
            $splashName = "DISABLED"
        } elseif ($Script:SplashScreens.ContainsKey($Script:SplashScreen)) {
            $splashName = $Script:SplashScreens[$Script:SplashScreen].Name.ToUpper()
        } else {
            $splashName = "BBS TERMINAL"
        }
        
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | DISPLAY SETTINGS                                                     |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | [0] SPLASH SCREEN......................... [CURRENT: $($splashName.PadRight(10))]     |" -ForegroundColor Green
        Write-Host "    | [1] COLOR MODE: CGA/EGA/VGA............... [CURRENT: VGA 256]        |" -ForegroundColor Green
        Write-Host "    | [2] SCREEN RESOLUTION..................... [CURRENT: 640x480]       |" -ForegroundColor Green
        Write-Host "    | [3] ASCII ART LEVEL....................... [CURRENT: MAXIMUM]       |" -ForegroundColor Green
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | DOWNLOAD SETTINGS                                                    |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | [4] RESULTS PER PAGE...................... [CURRENT: 9]             |" -ForegroundColor Green
        Write-Host "    | [5] MINIMUM SEEDERS....................... [CURRENT: 5]             |" -ForegroundColor Green
        Write-Host "    | [6] QBITTORRENT PATH...................... [CURRENT: C:\Program...] |" -ForegroundColor Green
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | NETWORK SETTINGS                                                     |" -ForegroundColor White
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host "    | [7] MODEM SPEED........................... [CURRENT: 56K]           |" -ForegroundColor Green
        Write-Host "    | [8] CONNECTION TIMEOUT.................... [CURRENT: 30 SEC]        |" -ForegroundColor Green
        Write-Host "    | [9] PROXY SETTINGS........................ [CURRENT: DISABLED]      |" -ForegroundColor Green
        Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "    [0-9] MODIFY SETTING | [S] SAVE CONFIG | [B] BACK TO MENU" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Yellow
        $settingChoice = Read-Host
        
        if ($settingChoice -eq "0") {
            # Splash screen selection
            Clear-Host
            Write-Host ""
            Write-Host "    +======================================================================+" -ForegroundColor Yellow
            Write-Host "    |                    SPLASH SCREEN SELECTOR                            |" -ForegroundColor Cyan
            Write-Host "    +======================================================================+" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "    AVAILABLE SPLASH SCREENS:" -ForegroundColor Green
            Write-Host ""
            
            # Show first page of splash screens (1-10)
            for ($i = 1; $i -le 10; $i++) {
                $splash = $Script:SplashScreens["$i"]
                Write-Host "    [$i] $($splash.Name.ToUpper())" -ForegroundColor White
            }
            
            Write-Host ""
            Write-Host "    [M] MORE OPTIONS (11-20)" -ForegroundColor Yellow
            Write-Host "    [P] PREVIEW SPECIFIC SCREEN" -ForegroundColor Yellow  
            Write-Host "    [A] PREVIEW ALL SCREENS" -ForegroundColor Yellow
            Write-Host "    [0] DISABLE SPLASH SCREEN" -ForegroundColor Red
            Write-Host ""
            Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Cyan
            $splashChoice = Read-Host
            
            if ($splashChoice -eq "M" -or $splashChoice -eq "m") {
                # Show second page of splash screens (11-20)
                Clear-Host
                Write-Host ""
                Write-Host "    +======================================================================+" -ForegroundColor Yellow
                Write-Host "    |                 SPLASH SCREEN SELECTOR - PAGE 2                      |" -ForegroundColor Cyan
                Write-Host "    +======================================================================+" -ForegroundColor Yellow
                Write-Host ""
                Write-Host "    MORE SPLASH SCREENS:" -ForegroundColor Green
                Write-Host ""
                
                for ($i = 11; $i -le 20; $i++) {
                    $splash = $Script:SplashScreens["$i"]
                    Write-Host "    [$i] $($splash.Name.ToUpper())" -ForegroundColor White
                }
                
                Write-Host ""
                Write-Host "    [B] BACK TO FIRST PAGE" -ForegroundColor Yellow
                Write-Host ""
                Write-Host "    SELECT OPTION >>> " -NoNewline -ForegroundColor Cyan
                $page2Choice = Read-Host
                
                if ($page2Choice -match "^(1[1-9]|20)$") {
                    $Script:SplashScreen = $page2Choice
                    Write-Host ""
                    Write-Host "    SPLASH SCREEN UPDATED TO: $($Script:SplashScreens[$page2Choice].Name.ToUpper())" -ForegroundColor Green
                    Write-Host "    CHANGES WILL TAKE EFFECT ON NEXT STARTUP" -ForegroundColor Yellow
                    Start-Sleep -Seconds 2
                }
                # If "B" or invalid, it will just return to the main menu
            }
            elseif ($splashChoice -eq "P" -or $splashChoice -eq "p") {
                # Preview specific screen
                Write-Host ""
                Write-Host "    ENTER SCREEN NUMBER TO PREVIEW (1-20): " -NoNewline -ForegroundColor Yellow
                $previewNum = Read-Host
                
                if ($previewNum -match "^([1-9]|1[0-9]|20)$" -and $Script:SplashScreens.ContainsKey($previewNum)) {
                    Write-Host ""
                    Write-Host "    LOADING $($Script:SplashScreens[$previewNum].Name.ToUpper())..." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    
                    # Call the appropriate splash function
                    switch ([int]$previewNum) {
                        1 { Show-Splash1 }
                        2 { Show-Splash2 }
                        3 { Show-Splash3 }
                        4 { Show-Splash4 }
                        5 { Show-Splash5 }
                        6 { Show-Splash6 }
                        7 { Show-Splash7 }
                        8 { Show-Splash8 }
                        9 { Show-Splash9 }
                        10 { Show-Splash10 }
                        11 { Show-Splash11 }
                        12 { Show-Splash12 }
                        13 { Show-Splash13 }
                        14 { Show-Splash14 }
                        15 { Show-Splash15 }
                        16 { Show-Splash16 }
                        17 { Show-Splash17 }
                        18 { Show-Splash18 }
                        19 { Show-Splash19 }
                        20 { Show-Splash20 }
                    }
                    
                    Write-Host ""
                    Write-Host "    PREVIEW COMPLETE!" -ForegroundColor Green
                    Write-Host "    SET THIS AS YOUR SPLASH SCREEN? (Y/N): " -NoNewline -ForegroundColor Cyan
                    $setChoice = Read-Host
                    
                    if ($setChoice -eq "Y" -or $setChoice -eq "y") {
                        $Script:SplashScreen = $previewNum
                        Write-Host "    SPLASH SCREEN UPDATED!" -ForegroundColor Green
                        Start-Sleep -Seconds 1
                    }
                }
                else {
                    Write-Host "    INVALID SCREEN NUMBER!" -ForegroundColor Red
                    Start-Sleep -Seconds 1
                }
            }
            elseif ($splashChoice -eq "A" -or $splashChoice -eq "a") {
                # Preview all screens
                Write-Host ""
                Write-Host "    PREVIEWING ALL 20 SPLASH SCREENS..." -ForegroundColor Yellow
                Write-Host "    PRESS ENTER BETWEEN EACH PREVIEW" -ForegroundColor Gray
                Start-Sleep -Seconds 1
                
                foreach ($key in 1..20) {
                    $splash = $Script:SplashScreens["$key"]
                    Write-Host ""
                    Write-Host "    [$key] LOADING $($splash.Name.ToUpper())..." -ForegroundColor Cyan
                    Start-Sleep -Milliseconds 500
                    
                    # Call the appropriate splash function
                    switch ($key) {
                        1 { Show-Splash1 }
                        2 { Show-Splash2 }
                        3 { Show-Splash3 }
                        4 { Show-Splash4 }
                        5 { Show-Splash5 }
                        6 { Show-Splash6 }
                        7 { Show-Splash7 }
                        8 { Show-Splash8 }
                        9 { Show-Splash9 }
                        10 { Show-Splash10 }
                        11 { Show-Splash11 }
                        12 { Show-Splash12 }
                        13 { Show-Splash13 }
                        14 { Show-Splash14 }
                        15 { Show-Splash15 }
                        16 { Show-Splash16 }
                        17 { Show-Splash17 }
                        18 { Show-Splash18 }
                        19 { Show-Splash19 }
                        20 { Show-Splash20 }
                    }
                }
                
                Write-Host ""
                Write-Host "    ALL PREVIEWS COMPLETE!" -ForegroundColor Green
                Write-Host "    PRESS ENTER TO RETURN TO SELECTION..." -ForegroundColor Gray
                Read-Host
            }
            elseif ($splashChoice -match "^[0-9]$|^10$") {
                # Set splash screen directly (0-10)
                $Script:SplashScreen = $splashChoice
                if ($splashChoice -eq "0") {
                    Write-Host ""
                    Write-Host "    SPLASH SCREEN DISABLED!" -ForegroundColor Red
                }
                else {
                    Write-Host ""
                    Write-Host "    SPLASH SCREEN UPDATED TO: $($Script:SplashScreens[$splashChoice].Name.ToUpper())" -ForegroundColor Green
                }
                Write-Host "    CHANGES WILL TAKE EFFECT ON NEXT STARTUP" -ForegroundColor Yellow
                Start-Sleep -Seconds 2
            }
        }
        elseif ($settingChoice -match "^[1-9]$") {
            Write-Host ""
            
            # Unique message for each setting
            $settingMessages = @{
                "1" = "SYNCING CGA/EGA/VGA MODES WITH ORBITAL SATELLITES..."
                "2" = "RECALIBRATING CRT ELECTRON BEAM TO 640x480..."
                "3" = "DOWNLOADING ASCII CODEPAGE FROM BBS MAINFRAME..."
                "4" = "ADJUSTING RESULT BUFFER TO OPTIMAL THROUGHPUT..."
                "5" = "UPDATING SEEDER THRESHOLD VIA NEURAL NETWORK..."
                "6" = "REMAPPING QBITTORRENT PATH IN DOS MEMORY..."
                "7" = "NEGOTIATING NEW BAUD RATE WITH TELECOM PROVIDER..."
                "8" = "REPROGRAMMING TIMEOUT INTERRUPT VECTOR..."
                "9" = "ESTABLISHING PROXY TUNNEL THROUGH CYBERSPACE..."
            }
            
            $confirmMessages = @{
                "1" = "VIDEO MODE LOCKED! PIXELS ARE NOW EXTRA CHUNKY!"
                "2" = "RESOLUTION SET! YOUR MONITOR IS BUZZING WITH JOY!"
                "3" = "ASCII ART MAXIMIZED! PREPARE FOR VISUAL OVERLOAD!"
                "4" = "PAGE SIZE OPTIMIZED! MORE TORRENTS PER SCREEN!"
                "5" = "SEEDER FILTER CALIBRATED! ONLY THE FINEST TORRENTS!"
                "6" = "PATH UPDATED! QBITTORRENT LOCATED IN THE MATRIX!"
                "7" = "MODEM TURBOCHARGED! BLAZING 56K SPEEDS ACHIEVED!"
                "8" = "TIMEOUT ADJUSTED! PATIENCE LEVEL: MAXIMUM!"
                "9" = "PROXY CONFIGURED! YOU ARE NOW INVISIBLE!"
            }
            
            if ($settingMessages.ContainsKey($settingChoice)) {
                Write-Host "    $($settingMessages[$settingChoice])" -ForegroundColor Yellow
                Write-Host "    [" -NoNewline -ForegroundColor DarkGray
                for ($i = 0; $i -lt 35; $i++) {
                    Write-Host "*" -NoNewline -ForegroundColor Green
                    Start-Sleep -Milliseconds 40
                }
                Write-Host "] SYNCED!" -ForegroundColor Green
                Write-Host ""
                Write-Host "    $($confirmMessages[$settingChoice])" -ForegroundColor Cyan
                Start-Sleep -Seconds 2
            }
        }
        elseif ($settingChoice -eq "S" -or $settingChoice -eq "s") {
            # Save configuration
            @("username:$($Script:UserName)", "splashscreen:$($Script:SplashScreen)") | Set-Content $Script:ConfigFile
            
            Write-Host ""
            Write-Host "    UPDATING THE MAINFRAME..." -ForegroundColor Green
            Write-Host "    [" -NoNewline -ForegroundColor DarkGray
            for ($i = 0; $i -lt 40; $i++) {
                Write-Host "#" -NoNewline -ForegroundColor Green
                Start-Sleep -Milliseconds 25
            }
            Write-Host "] 100%" -ForegroundColor Green
            Write-Host "    CONFIGURATION SYNCHRONIZED!" -ForegroundColor Green
            Start-Sleep -Seconds 1
            # Return to main menu
            continue
        }
    }
    elseif ($choice -eq "5") {
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Yellow
        Write-Host "    |                    USER PROFILE CONFIGURATION                        |" -ForegroundColor Cyan
        Write-Host "    +======================================================================+" -ForegroundColor Yellow
        Write-Host ""
        $currentUser = if ($Script:UserName) { [string]$Script:UserName } else { "User" }
        Write-Host "    CURRENT USER: $($currentUser.ToUpper())" -ForegroundColor Green
        Write-Host ""
        Write-Host "    LOADING USER DATABASE..." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 500
        Write-Host "    ACCESSING PROFILE SETTINGS..." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 500
        Write-Host ""
        Write-Host "    ENTER NEW USERNAME: " -NoNewline -ForegroundColor Cyan
        $newName = Read-Host
        
        if (![string]::IsNullOrWhiteSpace($newName)) {
            $Script:UserName = $newName
            @("username:$newName", "splashscreen:$($Script:SplashScreen)") | Set-Content $Script:ConfigFile
            
            Write-Host ""
            Write-Host "    UPDATING USER PROFILE in the BIOS of the computer, please wait..." -ForegroundColor Green
            Write-Host "    [" -NoNewline -ForegroundColor DarkGray
            for ($i = 0; $i -lt 30; $i++) {
                Write-Host "=" -NoNewline -ForegroundColor Yellow
                Start-Sleep -Milliseconds 30
            }
            Write-Host "] COMPLETE" -ForegroundColor Green
            Write-Host ""
            Write-Host "    PROFILE UPDATED: $(([string]$Script:UserName).ToUpper())" -ForegroundColor Green
            Write-Host "    WELCOME TO YOUR NEW IDENTITY!" -ForegroundColor Yellow
            Start-Sleep -Seconds 2
        }
        else {
            Write-Host "    USERNAME UPDATE CANCELLED" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
    elseif ($choice -eq "6") {
        # Splash Screen Gallery
        do {
            Clear-Host
            Write-Host ""
            Write-Host "    +======================================================================+" -ForegroundColor Magenta
            Write-Host "    |                    SPLASH SCREEN GALLERY Version $Script:ApplicationVersion                        |" -ForegroundColor Yellow
            Write-Host "    +======================================================================+" -ForegroundColor Magenta
            Write-Host ""
            
            # Get current splash screen info
            $currentSplash = "NONE"
            if ($Script:SplashScreen -eq "0") {
                $currentSplash = "DISABLED"
            } elseif ($Script:SplashScreens.ContainsKey($Script:SplashScreen)) {
                $currentSplash = $Script:SplashScreens[$Script:SplashScreen].Name.ToUpper()
            }
            
            Write-Host "    CURRENT SPLASH SCREEN: $currentSplash" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
            Write-Host "    | RETRO COMPUTER SYSTEMS (1-10)                                        |" -ForegroundColor White
            Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
            
            # Display screens 1-10
            for ($i = 1; $i -le 10; $i++) {
                $splash = $Script:SplashScreens["$i"]
                $num = "[$i]".PadRight(5)
                Write-Host "    $num $($splash.Name.PadRight(25))" -NoNewline -ForegroundColor Green
                if ($i % 2 -eq 0) { Write-Host "" } else { Write-Host "  " -NoNewline }
            }
            
            Write-Host ""
            Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
            Write-Host "    | ADVANCED SYSTEMS (11-20)                                             |" -ForegroundColor White
            Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
            
            # Display screens 11-20
            for ($i = 11; $i -le 20; $i++) {
                $splash = $Script:SplashScreens["$i"]
                $num = "[$i]".PadRight(5)
                Write-Host "    $num $($splash.Name.PadRight(25))" -NoNewline -ForegroundColor Yellow
                if ($i % 2 -eq 0) { Write-Host "" } else { Write-Host "  " -NoNewline }
            }
            
            Write-Host ""
            Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor DarkGray
            Write-Host ""
            Write-Host "    [1-20] SELECT & PREVIEW    [0] DISABLE    [R] RANDOM    [B] BACK" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "    ENTER CHOICE >>> " -NoNewline -ForegroundColor Yellow
            $galleryChoice = Read-Host
            
            if ($galleryChoice -eq "B" -or $galleryChoice -eq "b") {
                break
            }
            elseif ($galleryChoice -eq "R" -or $galleryChoice -eq "r") {
                # Set random splash screen
                $randomNum = Get-Random -Minimum 1 -Maximum 21
                $Script:SplashScreen = "$randomNum"
                @("username:$($Script:UserName)", "splashscreen:$($Script:SplashScreen)") | Set-Content $Script:ConfigFile
                
                Write-Host ""
                Write-Host "    RANDOMIZING SPLASH SCREEN..." -ForegroundColor Yellow
                Write-Host "    [" -NoNewline -ForegroundColor DarkGray
                for ($i = 0; $i -lt 20; $i++) {
                    Write-Host "?" -NoNewline -ForegroundColor (Get-Random @("Red", "Yellow", "Green", "Cyan", "Blue", "Magenta"))
                    Start-Sleep -Milliseconds 50
                }
                Write-Host "] DONE!" -ForegroundColor Green
                Write-Host ""
                Write-Host "    SELECTED: $($Script:SplashScreens[$Script:SplashScreen].Name.ToUpper())" -ForegroundColor Cyan
                Write-Host "    WILL DISPLAY ON NEXT STARTUP!" -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            elseif ($galleryChoice -eq "0") {
                $Script:SplashScreen = "0"
                @("username:$($Script:UserName)", "splashscreen:$($Script:SplashScreen)") | Set-Content $Script:ConfigFile
                Write-Host ""
                Write-Host "    SPLASH SCREEN DISABLED!" -ForegroundColor Red
                Write-Host "    BORING MODE ACTIVATED!" -ForegroundColor DarkGray
                Start-Sleep -Seconds 2
            }
            elseif ($galleryChoice -match "^([1-9]|1[0-9]|20)$") {
                # Preview and optionally set splash screen
                Write-Host ""
                Write-Host "    LOADING $($Script:SplashScreens[$galleryChoice].Name.ToUpper())..." -ForegroundColor Green
                Start-Sleep -Seconds 1
                
                Clear-Host
                # Call the appropriate splash function
                switch ([int]$galleryChoice) {
                    1 { Show-Splash1 }
                    2 { Show-Splash2 }
                    3 { Show-Splash3 }
                    4 { Show-Splash4 }
                    5 { Show-Splash5 }
                    6 { Show-Splash6 }
                    7 { Show-Splash7 }
                    8 { Show-Splash8 }
                    9 { Show-Splash9 }
                    10 { Show-Splash10 }
                    11 { Show-Splash11 }
                    12 { Show-Splash12 }
                    13 { Show-Splash13 }
                    14 { Show-Splash14 }
                    15 { Show-Splash15 }
                    16 { Show-Splash16 }
                    17 { Show-Splash17 }
                    18 { Show-Splash18 }
                    19 { Show-Splash19 }
                    20 { Show-Splash20 }
                }
                
                Write-Host ""
                Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
                Write-Host "    | PREVIEW COMPLETE - SET AS DEFAULT SPLASH SCREEN?                    |" -ForegroundColor Yellow
                Write-Host "    +----------------------------------------------------------------------+" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "    [Y] YES, SET IT!    [N] NO, JUST LOOKING    [V] VIEW AGAIN" -ForegroundColor White
                Write-Host ""
                Write-Host "    CHOICE >>> " -NoNewline -ForegroundColor Yellow
                $setChoice = Read-Host
                
                if ($setChoice -eq "Y" -or $setChoice -eq "y") {
                    $Script:SplashScreen = $galleryChoice
                    @("username:$($Script:UserName)", "splashscreen:$($Script:SplashScreen)") | Set-Content $Script:ConfigFile
                    Write-Host ""
                    Write-Host "    SPLASH SCREEN UPDATED!" -ForegroundColor Green
                    Write-Host "    $($Script:SplashScreens[$galleryChoice].Name.ToUpper()) WILL GREET YOU NEXT TIME!" -ForegroundColor Cyan
                    Start-Sleep -Seconds 2
                }
                elseif ($setChoice -eq "V" -or $setChoice -eq "v") {
                    # View again
                    Clear-Host
                    # Call the appropriate splash function
                    switch ([int]$galleryChoice) {
                        1 { Show-Splash1 }
                        2 { Show-Splash2 }
                        3 { Show-Splash3 }
                        4 { Show-Splash4 }
                        5 { Show-Splash5 }
                        6 { Show-Splash6 }
                        7 { Show-Splash7 }
                        8 { Show-Splash8 }
                        9 { Show-Splash9 }
                        10 { Show-Splash10 }
                        11 { Show-Splash11 }
                        12 { Show-Splash12 }
                        13 { Show-Splash13 }
                        14 { Show-Splash14 }
                        15 { Show-Splash15 }
                        16 { Show-Splash16 }
                        17 { Show-Splash17 }
                        18 { Show-Splash18 }
                        19 { Show-Splash19 }
                        20 { Show-Splash20 }
                    }
                    # Note: Splash screens already have their own "Press ENTER to continue" prompt
                }
            }
            else {
                Write-Host "    INVALID SELECTION!" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
            
        } while ($true)
    }
    elseif ($choice -eq "7") {
        # Computer History
        Show-History
    }
    elseif ($choice -eq "8") {
        # Documentation - Retro Style (show in terminal)
        Clear-Host
        $docFile = "$PSScriptRoot\DOCUMENTATION.txt"
        if (Test-Path $docFile) {
            Write-Host ""
            Write-Host "    +======================================================================+" -ForegroundColor Cyan
            Write-Host "    |                    DOCUMENTATION VIEWER v1.0                         |" -ForegroundColor Yellow
            Write-Host "    +======================================================================+" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "    LOADING DOCUMENTATION FROM MEMORY BANK..." -ForegroundColor Green
            Start-Sleep -Milliseconds 500
            Write-Host "    DECODING ASCII ART..." -ForegroundColor Green
            Start-Sleep -Milliseconds 500
            Write-Host ""
            Write-Host "    ======================================================================" -ForegroundColor DarkGray
            Write-Host ""

            # Read and display the documentation
            $docContent = Get-Content $docFile
            foreach ($line in $docContent) {
                Write-Host $line -ForegroundColor White
            }

            Write-Host ""
            Write-Host "    ======================================================================" -ForegroundColor DarkGray
            Write-Host ""
            Write-Host "    END OF DOCUMENTATION - PRESS ANY KEY TO RETURN TO MAIN MENU" -ForegroundColor Yellow
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        else {
            Write-Host ""
            Write-Host "    ERROR: DOCUMENTATION FILE NOT FOUND!" -ForegroundColor Red
            Write-Host "    EXPECTED: $docFile" -ForegroundColor DarkGray
            Write-Host "    PRESS ANY KEY TO CONTINUE..." -ForegroundColor Yellow
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
    }
    elseif ($choice -eq "9") {
        # Documentation - Modern Style (open in browser)
        $docFile = "$PSScriptRoot\DOCUMENTATION.html"
        if (Test-Path $docFile) {
            Write-Host ""
            Write-Host "    LAUNCHING MODERN DOCUMENTATION..." -ForegroundColor Green
            Write-Host "    OPENING DEFAULT BROWSER..." -ForegroundColor Cyan
            Start-Process $docFile
            Start-Sleep -Seconds 2
        }
        else {
            Write-Host ""
            Write-Host "    ERROR: DOCUMENTATION FILE NOT FOUND!" -ForegroundColor Red
            Write-Host "    EXPECTED: $docFile" -ForegroundColor DarkGray
            Write-Host "    PRESS ANY KEY TO CONTINUE..." -ForegroundColor Yellow
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
    }
    elseif ($choice -eq "X" -or $choice -eq "x") {
        Clear-Host
        Write-Host ""
        Write-Host "    +======================================================================+" -ForegroundColor Red
        Write-Host "    |                                                                      |" -ForegroundColor Red
        Write-Host "    |             THANK YOU FOR USING Get Movies $Script:ApplicationVersion                       |" -ForegroundColor Yellow
        Write-Host "    |                                                                      |" -ForegroundColor Red
        # Pad the name to ensure consistent alignment
        $userName = if ($Script:UserName) { [string]$Script:UserName } else { "User" }
        $paddedName = ($userName.ToUpper() + "!"+ (" " * 50)).Substring(0, 13)
        Write-Host "    |                   HAPPY WATCHING, $paddedName                      |" -ForegroundColor Cyan
        Write-Host "    |                                                                      |" -ForegroundColor Red
        Write-Host "    |                     [SYSTEM SHUTDOWN]                                |" -ForegroundColor White
        Write-Host "    |                                                                      |" -ForegroundColor Red
        Write-Host "    +======================================================================+" -ForegroundColor Red
        Write-Host ""
        break
    }
    else {
        Write-Host "    COMMAND NOT RECOGNIZED - TRY AGAIN" -ForegroundColor Red
        Start-Sleep -Seconds 1
    }
    
} while ($true)


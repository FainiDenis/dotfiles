# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#   https://macos-defaults.com/
#
# Run ./set-defaults.sh and you'll be good to go.

######################## Dock #######################

# Dock icon size
defaults write com.apple.dock tilesize -int 30

# Autohide Dock
defaults write com.apple.dock autohide -bool true

# Dock show/hide animation speed
defaults write com.apple.dock autohide-time-modifier -float 2.0

# Do not show recent apps
defaults write com.apple.dock show-recents -bool false

# Configure Dock apps via dockutil
if command -v dockutil >/dev/null 2>&1; then
  # Remove default apps from Dock
  dockutil --remove 'Mail' --no-restart
  dockutil --remove 'Messages' --no-restart
  dockutil --remove 'Photos' --no-restart
  dockutil --remove 'FaceTime' --no-restart
  dockutil --remove 'Music' --no-restart
  dockutil --remove 'Podcasts' --no-restart
  dockutil --remove 'TV' --no-restart
  dockutil --remove 'Safari' --no-restart
  dockutil --remove 'Calendar' --no-restart
  dockutil --remove 'Contacts' --no-restart
  dockutil --remove 'Reminders' --no-restart
  dockutil --remove 'Notes' --no-restart
  dockutil --remove 'App Store' --no-restart
  dockutil --remove 'System Settings' --no-restart
  dockutil --remove 'Maps' --no-restart
  dockutil --remove 'Games' --no-restart

  # Add preferred apps to Dock
  dockutil --add '/Applications/Firefox.app' --no-restart
  dockutil --add '/Applications/Terminal.app' --no-restart
  dockutil --add '/Applications/Termius.app' --no-restart
  dockutil --add '/Applications/Windows App.app' --no-restart
  dockutil --add '/Applications/Visual Studio Code.app' --no-restart
  dockutil --add '/Applications/VLC.app' --no-restart
  dockutil --add '/Applications/Stremio.app' --no-restart
fi

# Bottom-left hot corner → screensaver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

######################## Finder ########################
#
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top (Finder + Desktop)
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# Search current folder
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'

# Auto-adjust column widths in column view
defaults write com.apple.finder _FXEnableColumnAutoSizing -bool true

# Always use list view
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Disable file extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Auto-delete trash items after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Show title bar icons
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true

# Disable .DS_Store on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show ~/Library
chflags nohidden ~/Library

######################## Safari ########################
#
# Show full URL in address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Hide bookmarks bar
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Show URL overlay on hover
defaults write com.apple.Safari ShowOverlayStatusBar -bool true

################ Input & Interaction ##########

# Disable press-and-hold for keys
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 1

# Mouse & trackpad speed
defaults write -g com.apple.mouse.scaling -float 3.0
defaults write -g com.apple.trackpad.scaling -float 3.0

################ Networking ###################

# Enable AirDrop on all interfaces
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

################ Restart Apps #################

killall Dock Finder Safari 2>/dev/null

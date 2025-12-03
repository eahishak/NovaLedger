# NovaLedger - Crypto Tracking App

**Student:** Emmanuel Ahishakiye  
**Email:** eahishak@u.rochester.edu  
**Course:** CSC 214 - Mobile App Development  
**Instructor:** Prof. Arthur Roolfs  
**Date:** December 2, 2025

---

## Project Overview

NovaLedger is an iOS application that tracks cryptocurrency prices and market data. The app provides real-time Bitcoin information through the CoinGecko API and includes features for user customization and notifications.

---

## Features Implemented

### App Icon & Launch Screen
- Custom app icon in all required sizes
- Launch screen with custom background color and app logo

### Colors & Design
- Two custom colors: AccentColor and PrimaryNavy
- Consistent color scheme throughout the app

### Animations
The app includes three UI animations:
1. Title fade-in effect when the app loads
2. Rotating logo animation
3. Bouncing button animation

### Localization
The app is localized in three languages:
- English
- Spanish
- French

All user-facing text uses NSLocalizedString for proper localization.

### Alert & Action Sheet
- Simple alert that displays a notice to users
- Action sheet with four options: Refresh Data, View Market, Price History, and Cancel

### Information View
Displays app information retrieved from the Bundle:
- App name
- Version number
- Build number
- Copyright information
- App icon

### Settings
A settings screen that persists four user preferences:
- Dark mode toggle
- Currency selection (USD, EUR, GBP, JPY, CAD, AUD)
- Data refresh interval
- Price alerts toggle

Settings are saved using AppStorage and persist between app launches.

### Notifications
Local notification system that allows users to:
- Request notification permissions
- Send test notifications
- Receive price alerts

### API Integration
The app connects to the CoinGecko API to display real-time cryptocurrency data across two main views:

**Crypto Status View:**
- Cryptocurrency name
- Symbol
- Current price in USD
- 24-hour price change percentage

**Market Overview View:**
- Market capitalization
- 24-hour high price
- 24-hour low price
- Visual price range indicator

### Additional Features
- Price history modal showing historical performance data
- Refresh functionality for updating crypto data
- Error handling with retry options
- Loading indicators during data fetch

---

## Technical Details

**API Used:** CoinGecko API (https://api.coingecko.com)
- No API key required
- Fetches Bitcoin market data
- Returns JSON with price and market statistics

**Bundle Identifier:** com.eahishak.NovaLedger

**Minimum iOS Version:** iOS 17.0

---

## Git Repository

Repository: https://github.com/eahishak/NovaLedger

The project includes:
- Complete .gitignore file
- Multiple commits documenting development progress
- Feature branch for API implementation (crypto-api)

---

## Testing Instructions

1. Open NovaLedger.xcodeproj in Xcode
2. Select iPhone simulator or connected device
3. Build and run the project
4. Grant notification permissions when prompted
5. Navigate through all screens to verify functionality
6. Test settings persistence by changing preferences, closing the app, and reopening
7. Change device language to test localization

---

## Known Limitations

- API calls require internet connection
- Real-time data updates require manual refresh
- Currently only displays Bitcoin data

---

## Academic Integrity Statement

I confirm that this work is my own and I have not given or received unauthorized assistance on this assignment.

---

**Signature:** Emmanuel Ahishakiye  
**Date:** December 2, 2025

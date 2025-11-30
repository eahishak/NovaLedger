# CSC 214 – Mobile App Development

**Instructor:** Prof. Arthur Roolfs  
**Name:** Emmanuel Ahishakiye  
**Email:** eahishak@u.rochester.edu  

---
## Project 3 – NovaLedger Crypto App

### Description
NovaLedger is a lightweight crypto-tracking application that demonstrates animations, localization, alerts, settings persistence, notifications, and live API integration. The app displays real-time Bitcoin data, market overview metrics, and allows users to configure their experience through a dedicated settings panel.

### Block I – UI Foundations (20 pts)

#### **1. App Icon**
The project includes a custom app icon generated from an SVG asset (“NovaLedgerImage”).  
All three icon sizes were created and placed inside **Assets.xcassets > AppIcon**.

#### **2. Launch Screen**
The app uses:
- A custom launch background color (`LaunchBackground`)
- Centered NovaLedger icon  
Configured under:
`TARGET → Info → UILaunchScreen`
#### **3. Custom Colors**
Two custom colors were added:
- **AccentColor (#0F5ACC)**  
- **PrimaryNavy (#0D1117)**  

#### **4. Animations**
Three meaningful UI animations were implemented:
- Fade-in title animation  
- Rotating icon animation  
- Bouncing button animation  

#### **5. Localization**
Localizable strings were implemented in **English, French, and Spanish**.  
All onscreen text uses:  
`NSLocalizedString("key", comment: "")`

---

## Block II – Functional Features (50 pts)

### **6. Alert**
A simple alert appears with a localized title and message when the button is tapped.

### **7. Action Sheet**
Shows 3–5 user options using `confirmationDialog`.

### **8. InfoView**
Displays:
- App name  
- Version number  
- Build number  
- App icon  
- Copyright year  

All pulled dynamically from the Bundle.

### **9. SettingsView**
A dedicated Settings view using `@AppStorage`:
- Dark Crypto Mode (toggle)  
- Base Currency Picker  
- Refresh interval Stepper  
- Price Alerts Toggle  
- **Test Notification button**  

Persistence survives app restarts.

### **10. API Content (2 Full Screens)**  
A full Crypto API service was implemented using the public CoinGecko API.

#### **View 1 — Crypto Status**
Displays:
- Bitcoin name  
- Symbol  
- Formatted price  
- 24h change percent  

#### **View 2 — Market Overview**
Displays:
- Global market cap  
- 24h high  
- 24h low  

Both views consume **6 live data points** total.

---

## Block III – Advanced Features (30 pts)

### **11. Local Notification**
A local user notification is scheduled via `UNUserNotificationCenter` and can be triggered from Settings.

### **12. Custom Feature**
The custom feature is the **Crypto API Integration + Fullscreen Market Views**, implemented in a separate branch and merged into `main`.

### **13. Git**
This project includes:
- A complete `.gitignore` for Xcode  
- A full Git repository:  
  **https://github.com/eahishak/NovaLedger**
- At least **12 meaningful commits**, including:
  - Project setup  
  - Launch screen  
  - Colors + assets  
  - Animations  
  - Localization  
  - Alerts + action sheet  
  - Info and Settings views  
  - Notifications  
  - Crypto services  
  - Crypto API first view  
  - Market overview  
  - Final cleanup & README  

A feature branch named `crypto-feature` was created for API work and successfully merged.

---

## Academic Honesty  
I confirm that I have not given or received any unauthorized help on this assignment, and that all work submitted here is my own.

**Date:** November 29, 2025

//
//  NotificationManager.swift
//  NovaLedger
//
//  Created by Ahishakiye, Emmanuel on 11/29/25.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() {}
    
    // Request notification permissions from user
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
                return
            }
            
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
    // Schedule a test notification
    func scheduleTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "NovaLedger"
        content.body = "Your crypto data has been refreshed successfully!"
        content.sound = .default
        content.badge = 1
        
        // Trigger after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Test notification scheduled")
            }
        }
    }
    
    // Schedule price alert notification
    func schedulePriceAlert(cryptoName: String, price: Double, change: Double) {
        let content = UNMutableNotificationContent()
        content.title = "\(cryptoName) Price Alert"
        
        if change > 0 {
            content.body = "Price increased by \(String(format: "%.2f", change))% to $\(String(format: "%.2f", price))"
        } else {
            content.body = "Price decreased by \(String(format: "%.2f", abs(change)))% to $\(String(format: "%.2f", price))"
        }
        
        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = "CRYPTO_ALERT"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "price-alert-\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule price alert: \(error.localizedDescription)")
            }
        }
    }
    
    // Remove all pending notifications
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All pending notifications removed")
    }
    
    // Remove all delivered notifications
    func removeAllDeliveredNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().setBadgeCount(0)
        print("All delivered notifications removed")
    }
}

//
//  NotificationManager.swift
//  GeofenceTrigger
//
//  Created by umud on 7.12.2024.
//

import Foundation
import UserNotifications

open class NotificationManager {
    static let shared = NotificationManager()

    public func sendNotification(locationName: String, status: String) {
        let content = UNMutableNotificationContent()
        content.title = "Geofence Update"
        content.body = "\(locationName) - \(status)"
        content.userInfo = ["locationName": locationName, "status": status]
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

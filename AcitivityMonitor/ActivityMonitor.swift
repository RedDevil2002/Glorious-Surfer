//
//  ActivityMonitor.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-15.
//

import Foundation
import UIKit
import SwiftUI
import MobileCoreServices
import DeviceActivity
import ManagedSettings

class ActivityMonitor: DeviceActivityMonitor {
    let model = Model.shared
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        let applications = model.selectionToDiscourage.applicationTokens
        model.store.shield.applications = applications
        for customURL in model.customURLstoBLock {
            if let token = WebDomain(domain: customURL).token {
                model.store.shield.webDomains?.insert(token)
            }
        }
        model.store.dateAndTime.requireAutomaticDateAndTime = true
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        model.store.shield.applications = nil
        model.store.dateAndTime.requireAutomaticDateAndTime = false
    }
}

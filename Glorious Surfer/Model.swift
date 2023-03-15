//
//  Model.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-15.
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

class Model: ObservableObject {
    let store = ManagedSettingsStore()
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    @Published var selectionToEncourage: FamilyActivitySelection
    
    private init() {
        selectionToEncourage = FamilyActivitySelection()
        selectionToDiscourage = FamilyActivitySelection()
    }
    
    static let shared: Model = Model()
    
    func setShieldRestrictions() {
        let applications = selectionToDiscourage
        
        store.shield.applications = applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty ? nil: ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
        
    }
    
    func initiateMonitoring() {
        let schedule = DeviceActivitySchedule(intervalStart: DateComponents(hour: 0, minute: 0), intervalEnd: DateComponents(hour: 23, minute: 59), repeats: true)
        let center = DeviceActivityCenter()
        do {
            try center.startMonitoring(.daily, during: schedule)
        } catch {
            print(error.localizedDescription)
        }
        
        store.dateAndTime.requireAutomaticDateAndTime = true
        store.account.lockAccounts = true
        store.passcode.lockPasscode = true
        store.siri.denySiri = true
        store.appStore.denyInAppPurchases = true
        store.appStore.maximumRating = 200
        store.appStore.requirePasswordForPurchases = true
        store.media.denyExplicitContent = true
        store.gameCenter.denyMultiplayerGaming = true
        store.media.denyMusicService = false
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}

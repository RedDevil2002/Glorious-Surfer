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
    
    // Change this line later! (should have no default custom list.)
    @Published var customDomainsToBlock: [WebDomain] = ["mobile.twitter.com", "twitter.com", "google.com", "netflix.com", "naver.com", "reddit.com"].compactMap { domain in
        WebDomain(domain: domain)
    }
    
    @Published var customAdultDomainsToBlock: [WebDomain] = ["nude.com", "tooHot.19.com"].compactMap { domain in
        WebDomain(domain: domain)
    }
        
    init() {
        selectionToEncourage = FamilyActivitySelection()
        selectionToDiscourage = FamilyActivitySelection()
    }
        
    static let shared: Model = Model()
    
    func unblock() {
        store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.none
    }
    
    func adultFilterToggled() {
        if store.webContent.blockedByFilter == .auto() {
            store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.none
        } else {
            store.webContent.blockedByFilter = .auto()
        }
    }
    
    func setShieldRestrictions() {
        // SET UP DOMAINS
        let domainsToBLocks = Set(selectionToDiscourage.webDomains).union(customDomainsToBlock)
        print("model.setShieledRestrictions()\ncustomDomainsToBlock = \(customDomainsToBlock)")
        print("model.setShieledRestrictions()\ndomainsToBlock = \(domainsToBLocks)")
        
        print("model.setShieldRestrictions()\nwebDonmains = \(selectionToDiscourage.webDomains)")
        print("Comparison between \(selectionToDiscourage.webDomains.first.debugDescription) and \(WebDomain(domain: "twitter.com"))")
        print(selectionToDiscourage.webDomains.first == WebDomain(domain: "twitter.com"))
        
        store.shield.applications = selectionToDiscourage.applicationTokens
        store.shield.applicationCategories = selectionToDiscourage.categoryTokens.isEmpty ? nil: ShieldSettings.ActivityCategoryPolicy.specific(selectionToDiscourage.categoryTokens)
        store.shield.webDomainCategories = ShieldSettings.ActivityCategoryPolicy.specific(selectionToDiscourage.categoryTokens, except: Set())
        store.shield.webDomains = selectionToDiscourage.webDomainTokens.union(Set([WebDomain(domain: "twitter.com")].compactMap({ $0.token
        })))
        
        store.webContent.blockedByFilter = WebContentSettings.FilterPolicy.auto(domainsToBLocks)
        
        store.dateAndTime.requireAutomaticDateAndTime = true
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
    
    func addToBlockList(url: String) {
        let domain = WebDomain(domain: url)
        customDomainsToBlock.append(domain)
        guard let token = domain.token else { return }
        store.shield.webDomains?.insert(token)
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}

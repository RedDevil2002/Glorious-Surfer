//
//  Glorious_SurferApp.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-14.
//

import SwiftUI
import FamilyControls

@main
struct Glorious_SurferApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    let center = AuthorizationCenter.shared
    @StateObject var model = Model.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .onAppear {
                    Task {
                        do {
                            try await center.requestAuthorization(for: .individual)
                        } catch {
                            print("Failed to authorized \(error.localizedDescription)")
                        }
                        model.initiateMonitoring()
                    }
                }
        }
    }
}


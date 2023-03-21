//
//  SettingView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-15.
//

import SwiftUI

struct SettingView: View {
    @State private var isNotificationOn = false
    @State private var colorChoice: Color = .clear
    
    @State private var showSignOutPrompt = false
    var body: some View {
        Form {
            Section {
                ColorPicker (selection: $colorChoice) {
                    Text("Choose a color")
                }
            } header: {
                Text("Theme")
            }
            
            Section {
                Toggle(isOn: $isNotificationOn) {
                    Text("Turn On Notification")
                }
            } header: {
                Text("Notification")
            }
            
            Section {
                Text("Sign Out")
                    .foregroundColor(.red)
                    .onTapGesture {
                        showSignOutPrompt = true
                    }
            } header: {
                Text("Account")
            }
        }
        .sheet(isPresented: $showSignOutPrompt) {
            Text("To be implemented")
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

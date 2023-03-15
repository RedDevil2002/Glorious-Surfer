//
//  ContentView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-14.
//

import SwiftUI
import FamilyControls

struct ContentView: View {
    @State private var showDiscouragedAppsPicker = false
    @State private var showEncouragedAppsPicker = false
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        TabView {
            Button("Select Apps to Discourage") {
                showDiscouragedAppsPicker = true
            }
            .familyActivityPicker(isPresented: $showDiscouragedAppsPicker, selection: $model.selectionToDiscourage)
            .onChange(of: model.selectionToDiscourage) { newValue in
                model.setShieldRestrictions()
            }
            .tabItem {
                Label("Set Not Allowed Apps", systemImage: "xmark.square.fill")
                    .font(.title3)
                    .foregroundColor(.red)
            }
            
            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gear.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model.shared)
    }
}

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
            Button(action: {
                showDiscouragedAppsPicker = true
            }, label: {
                VStack {
                    Image(systemName: "xmark.shield.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                    
                    Text("Select Apps to Discourage")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .scaledToFill()
                }
                .padding()
                .frame(width: 270.0, height: 130.0)
                .background(.orange)
                .cornerRadius(15.0)
                .toolbarColorScheme(.light, for: .tabBar)
                
                
                
            })
            .familyActivityPicker(isPresented: $showDiscouragedAppsPicker, selection: $model.selectionToDiscourage)
            .onChange(of: model.selectionToDiscourage) { newValue in
                model.setShieldRestrictions()
            }
                .tabItem {
                    Label("Set Not Allowed Apps", systemImage: "xmark.shield.fill")
                        .font(.title3)
                }
                .foregroundColor(.red)
            
            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gear.circle.fill")
                }
        }
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model.shared)
    }
}

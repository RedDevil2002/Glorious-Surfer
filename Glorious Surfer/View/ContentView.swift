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
    
    @State private var isAdultFilterOn = false {
        didSet {
            model.adultFilterToggled()
        }
    }
    @State private var isDatingFilterOn = false
    @State private var isDrugFilterOn = false
    
    @EnvironmentObject var model: Model
    
    @State private var showAddCustomAdultWebsiteToBlockView = false
    
    var body: some View {
        TabView {
            CustomBlockListView(model: _model)
                .tabItem {
                    Label("Custom", systemImage: "")
                }
            
            VStack(spacing: 35.0) {
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
                
                
                VStack {
                    Toggle(isOn: $isAdultFilterOn) {
                        Label {
                            Text("Adult")
                        } icon: {
                            Image(systemName: "19.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal)
                    
                    if isAdultFilterOn {
                        List {
                            Button {
                                showAddCustomAdultWebsiteToBlockView.toggle()
                            } label: {
                                Label("Add a new website to block", systemImage: "plus.circle.fill")
                            }

                            ForEach(model.customAdultDomainsToBlock, id: \.self) {
                                Text($0.domain ?? "")
                            }
                            .onDelete { indices in
                                model.customAdultDomainsToBlock.remove(atOffsets: indices)
                            }
                        }
                    }
                }
                
                Toggle(isOn: $isDrugFilterOn) {
                    Label {
                        Text("Drug")
                    } icon: {
                        Image(systemName: "pills.circle.fill")
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)
                
                Toggle(isOn: $isDatingFilterOn) {
                    Label {
                        Text("Dating")
                    } icon: {
                        Image(systemName: "heart.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)

            }
            .sheet(isPresented: $showAddCustomAdultWebsiteToBlockView, content: {
                AddCustomURLView(model: _model)
            })
            .tabItem {
                Label("Set Not Allowed Apps", systemImage: "xmark.shield.fill")
                    .font(.title3)
            }
            
            
            
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

//
//  CustomBlockListView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-20.
//

import SwiftUI

struct CustomBlockListView: View {
//    var viewModel: CustomBLockListViewModel = CustomBLockListViewModel()
    
    @EnvironmentObject var model: Model
    @State private var showAddCustomURLView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.customURLstoBLock, id: \.self) { mockURL in
                    Text(mockURL)
                }
                .onDelete(perform: delete)
                .onMove { model.customURLstoBLock.move(fromOffsets: $0, toOffset: $1) }
            }
            .toolbar {
                Button {
                    showAddCustomURLView = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                
                Button {
                    model.setShieldRestrictions()
                } label: {
                    Text("Block!")
                        .foregroundColor(.red)
                }
                
                Button {
                    model.unblock()
                } label: {
                    Text("UnBlock!")
                        .foregroundColor(.red)
                }
                EditButton()
            }
        }
        .sheet(isPresented: $showAddCustomURLView) {
            AddCustomURLView(model: _model)
        }
    }
    
    func delete(at offsets: IndexSet) {
        model.customURLstoBLock.remove(atOffsets: offsets)
    }
}

struct CustomBlockListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBlockListView()
            .environmentObject(Model.shared)
    }
}

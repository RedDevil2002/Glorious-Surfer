//
//  CustomBlockListView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-20.
//

import SwiftUI

struct CustomBlockListView: View {
//    var viewModel: CustomBLockListViewModel = CustomBLockListViewModel()
    
    @State var mockURLs: [String] = ["https://www.google.com"]
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mockURLs, id: \.self) { mockURL in
                    Text(mockURL)
                }
                .onDelete(perform: delete)
                .onMove { mockURLs.move(fromOffsets: $0, toOffset: $1) }
            }
            .toolbar {
                Button {
                    mockURLs.append("google\(mockURLs.count).com")
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                
                Button {
                    model.customURLstoBLock = mockURLs
                    model.blockCustomURLs()
                } label: {
                    Text("Block!")
                        .foregroundColor(.red)
                }
                
                EditButton()
                
                
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        mockURLs.remove(atOffsets: offsets)
    }
}

struct CustomBlockListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBlockListView()
            .environmentObject(Model.shared)
    }
}

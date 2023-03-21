//
//  AddCustomURLView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-20.
//

import SwiftUI

struct AddCustomURLView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model
    @State private var name = ""
    
    
    var body: some View {
        Form {
            Section {
                TextField("Custom Domain to block", text: $name)
                    .keyboardType(.URL)
                    .textContentType(.URL)
                    .textCase(.lowercase)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            Section {
                Button("Save") {
                    model.addToBlockList(url: name)
                    dismiss()
                }
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
    
}

struct AddCustomURLView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Model.shared
        AddCustomURLView()
            .environmentObject(model)
    }
}


class AddCustomURLViewModel: ObservableObject {
    @Published var name: String = ""
}

//
//  AddCustomAdultURLView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-23.
//

import SwiftUI

struct AddCustomAdultURLView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: Model
    @State private var name = ""
        
    var body: some View {
        Form {
            Section {
                TextField("Custom Adult Website Domain to block", text: $name)
                    .keyboardType(.URL)
                    .textContentType(.URL)
                    .textCase(.lowercase)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            Section {
                Button("Save") {
                    model.addToAdultBlockList(url: name)
                    dismiss()
                }
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}

struct AddCustomAdultURLView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomAdultURLView()
    }
}

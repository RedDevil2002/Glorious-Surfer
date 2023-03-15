//
//  SettingView.swift
//  Glorious Surfer
//
//  Created by Brian Seo on 2023-03-15.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        Form {
            Section {
                Text("Sign Out")
                    .foregroundColor(.red)
            } header: {
                Text("Account")
            }
            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

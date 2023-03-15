//
//  ShieldConfigurationExtension.swift
//  GloriousCustomShield
//
//  Created by Brian Seo on 2023-03-15.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

fileprivate let imageName = "Shield"

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        return ShieldConfiguration(
            icon: UIImage(named: imageName),
            title: ShieldConfiguration.Label(text: "High Tide!! Bring your parents!!", color: .blue),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Dismiss", color: .black)
        )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        return ShieldConfiguration(
            icon: UIImage(named: imageName),
            title: ShieldConfiguration.Label(text: "High Tide!! Bring your parents!!", color: .blue),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Dismiss", color: .black)
        )
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        return ShieldConfiguration(
            icon: UIImage(named: "safeSurferIcon"),
            title: ShieldConfiguration.Label(text: "High Tide!! Bring your parents!!", color: .blue),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Dismiss", color: .black)
        )
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        return ShieldConfiguration(
            icon: UIImage(named: "safeSurferIcon"),
            title: ShieldConfiguration.Label(text: "High Tide!! Bring your parents!!", color: .blue),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Dismiss", color: .black)
        )
    }
}

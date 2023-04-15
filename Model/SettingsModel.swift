//
//  SettingsModel.swift
//  BusApp
//
//  Created by REEMOTTO on 30.08.22.
//

import UIKit

struct SettingsModel {
    
    var title : String
    var currency : String
    
}

extension SettingsModel {
    static func  mocks() -> [SettingsModel] {
        return [
            .init(title: LocalizedString.SettingsView.currency, currency: ""),
            .init(title: LocalizedString.SettingsView.messages, currency: ""),
            .init(title: LocalizedString.SettingsView.privacy, currency: "")
            ]
    }
}

//
//  LocalizedString.swift
//  BusApp
//
//  Created by REEMOTTO on 1.09.22.
//

import UIKit

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

class LocalizedString {
    
    struct TableView {
        
        static var help: String{"help".localized()}
        static var terms: String{"terms".localized()}
        static var policy: String{"policy".localized()}
        static var stations: String{"stations".localized()}
        static var notice: String{"notice".localized()}
        static var settings: String{"settings".localized()}
        static var feedback: String{"feedback".localized()}
    }
    
    struct SettingsView {
        
        static var currency: String{"currency".localized()}
        static var messages: String{"messages".localized()}
        static var privacy: String{"privacy".localized()}
    }
    
    struct ViewController {
        
        static var from: String{"from".localized()}
        static var to: String{"to".localized()}
        static var passangers: String{"passangers".localized()}
        static var placeholder: String{"placeholder".localized()}
        static var travel: String{"travel".localized()}
        static var security: String{"security".localized()}
        static var depart: String{"depart".localized()}
        static var returnBack: String{"return".localized()}
        static var search: String{"search".localized()}
        static var adult: String{"adult".localized()}
        static var bike: String{"bike".localized()}
        static var child: String{"child".localized()}
        static var buy: String{"buy".localized()}
        static var ticket: String{"ticket".localized()}
        static var book: String{"book".localized()}
        static var booking: String{"booking".localized()}
        static var tickets: String{"tickets".localized()}
        static var info: String{"info".localized()}
        static var warning: String{"warning".localized()}
        static var reset: String{"reset".localized()}
        static var cancel: String{"cancel".localized()}
    }
    
    
    
}

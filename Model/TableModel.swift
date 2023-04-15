//
//  TableModel.swift
//  BusApp
//
//  Created by REEMOTTO on 30.08.22.
//

import UIKit

struct TableModel {
    
    var title : String
    var url : String
    var icon : UIImage?
    var controller : UIViewController?
    
}

extension TableModel {
    static func  mocks() -> [TableModel] {
        return [
            .init(title: LocalizedString.TableView.help, url: "https://help.flixbus.com/s/contact-us"),
            .init(title: LocalizedString.TableView.terms, url: "https://global.flixbus.com/general-terms-business-and-booking-conditions"),
            .init(title: LocalizedString.TableView.policy, url: "https://global.flixbus.com/privacy-policy"),
            .init(title: LocalizedString.TableView.stations, url: "https://global.flixbus.com/bus"),
            .init(title: LocalizedString.TableView.notice, url: "https://global.flixbus.com/legal-notice"),
            .init(title: LocalizedString.TableView.settings, url: "", icon: UIImage(systemName: "gear"), controller: SettingsViewController()),
            .init(title: LocalizedString.TableView.feedback, url: "", icon: UIImage(systemName: "paperplane"))
            ]
    }
}

//
//  MoreViewController.swift
//  BusApp
//
//  Created by REEMOTTO on 22.08.22.
//

import UIKit
import MessageUI

class MoreViewController: UIViewController {
    
    // MARK: - Properties
    
    var tableArray = TableModel.mocks()
    
//    ["Need help?", "T&Cs", "Privacy policy", "Station Locations", "Legal Notice", "Settings", "Send us feedback"]
    
    let feedBackEmail = "app@flixbus.com"
    
    
    // MARK: - Subviews
    
    let tableView = UITableView()
    
    
    // MARK: - Initializers
    
    deinit {
        print("Deinit ViewController")
    }
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.setStatusBar(backgroundColor: .green)
    }
    
    // MARK: -  Methods
    
    private func setup() {
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 40
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.pin(to:view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Handlers
    
    func feedbackButtonTapped() {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([feedBackEmail])
            composeVC.setSubject("Feedback BusApp!")
            composeVC.setMessageBody("<p>Hello, BusApp team!</p>", isHTML: true)
            
            self.navigationController?.present(composeVC, animated: true)
        } else {
            print("This device is currently unable to send e-mail")
        }
    }

}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        let table = tableArray[indexPath.row]
        cell.set(cell: table)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableArray[indexPath.row].title == LocalizedString.TableView.feedback {
            feedbackButtonTapped()
            
        } else if tableArray[indexPath.row].title == LocalizedString.TableView.settings {
            let settingsVC = SettingsViewController()
            self.tableView.reloadData()
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
        
        guard let url = URL(string: tableArray[indexPath.row].url) else {return}
        UIApplication.shared.open(url)
        
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension MoreViewController: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension MoreViewController: UIDocumentInteractionControllerDelegate {
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}

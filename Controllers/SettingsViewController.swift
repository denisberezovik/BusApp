//
//  SettingsViewController.swift
//  BusApp
//
//  Created by REEMOTTO on 30.08.22.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var settingsArray = SettingsModel(title: "", currency: "")
    
    var currencyArray = ["EUR", "GBP", "USD", "PLN", "BYN", "UAH"]
    
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - Subviews
    
    let tableView = UITableView()
    let stackView = UIStackView()
    
    let currencyPicker = UIPickerView()
    let textfield = UITextField()
    
    let currencyView = CustomSettingsView(title: LocalizedString.SettingsView.currency, currency: "", state: .label)
    let inAppMessagesView = CustomSettingsView(title: LocalizedString.SettingsView.messages, currency: "", state: .switcher)
    let privacySettingsView = CustomSettingsView(title: LocalizedString.SettingsView.privacy, currency: "", state: .usual)
    
    
    // MARK: - Initializers
    
    deinit {
        print("Deinit ViewController")
    }
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .green
        self.navigationController?.setStatusBar(backgroundColor: .green)
    }
    
    // MARK: -  Methods
    
    private func setup() {
        configureSubviews()
        layoutSubviews()
    }
    
    func configureSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(currencyView)
        stackView.addArrangedSubview(inAppMessagesView)
        stackView.addArrangedSubview(privacySettingsView)
        currencyView.addSubview(textfield)
        
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        textfield.inputView = currencyPicker
        textfield.inputAccessoryView = createToolBar()
        
    }
    
    private func layoutSubviews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.topAnchor.constraint(equalTo: currencyView.topAnchor).isActive = true
        textfield.leadingAnchor.constraint(equalTo: currencyView.leadingAnchor).isActive = true
        textfield.trailingAnchor.constraint(equalTo: currencyView.trailingAnchor).isActive = true
        textfield.bottomAnchor.constraint(equalTo: currencyView.bottomAnchor).isActive = true
    }
    
    // MARK: - Handlers
    
    func createToolBar() -> UIToolbar {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton], animated: true)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.barTintColor = UIColor.white
        return toolbar
    }
    
    @objc func donePressed(sender:UIPickerView) {
        
        self.view.endEditing(true)
    }
    
    
}

// MARK: -- SomeProtocol

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let row = currencyArray[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyView.currencyLabel.text = currencyArray[row]
        settingsArray.currency = currencyArray[row]

    }
    
    
}


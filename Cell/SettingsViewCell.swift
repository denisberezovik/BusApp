//
//  SettingsViewCell.swift
//  BusApp
//
//  Created by REEMOTTO on 30.08.22.
//

import UIKit

class SettingsViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencyArray[row]
    }
    
    // MARK: - Properties

    static var identifier = "SettingsViewCell"
    
    var currencyArray = ["EUR", "GBP", "USD", "PLN", "BYN", "UAH"]
    
    
    // MARK: - Subviews


    var titleLabel = UILabel()
    var currencyLabel = UILabel()
    var picker = UIPickerView()
    var switcher = UISwitch()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(currencyLabel)
//        addSubview(picker)
        addSubview(switcher)

        
        configureLabel()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configureLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        switcher.isHidden = true
        switcher.setOn(true, animated: true)
        switcher.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        
        currencyLabel.numberOfLines = 0
        currencyLabel.textColor = .black
        currencyLabel.font = .systemFont(ofSize: 16)
        currencyLabel.backgroundColor = .red
//        currencyLabel.isHidden = true
        currencyLabel.text = "Label"
        
        picker.dataSource = self
        picker.delegate = self
        picker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickerTapped)))
  
    }
    
    func set(cell: SettingsModel) {
        titleLabel.text = cell.title
        currencyLabel.text = cell.currency
//        self.picker = cell.picker
//        self.switcher = cell.cellSwitch
    }

    func setLabelConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        currencyLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
        
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        switcher.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
       {
           if (sender.isOn == true){
               print("UISwitch state is now ON")
           }
           else{
               print("UISwitch state is now Off")
           }
       }
    
    @objc func pickerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
            guard let pickerView = gestureRecognizer.view as? UIPickerView else {
                return
            }
            let row = pickerView.selectedRow(inComponent: 0)
            currencyLabel.text = currencyArray[row]
        }

}

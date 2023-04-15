//
//  ViewController.swift
//  BusApp
//
//  Created by REEMOTTO on 22.08.22.
//

import UIKit
import GooglePlaces
import CoreLocation


class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    var firstText = ""
    var secondText = ""
    
    var startLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var endLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    
    var distanceLocation = CLLocationDistance()
    
    var liter = 30
    var gasolinePrice: Double = 0.0
    var ticketPrice: Double = 0.0
    var passengerTicketPrice: Double = 0.0
    
    var adultNumber = 0
    var bikeNumber = 0
    var childNumber = 0
    
    var currency: String = ""
    
    var ticket = TicketModel(travelFrom: "", travelTo: "", departDate: "", returnDate: "", passenger: "", adult: 0, bike: 0, child: 0, ticketPrice: "")
    
    // MARK: - Subviews
    
    var fromTextfield = CustomTextfieldView(title: LocalizedString.ViewController.from, placeholder: LocalizedString.ViewController.from)
    var toTextfield = CustomTextfieldView(title: LocalizedString.ViewController.to, placeholder: LocalizedString.ViewController.to)
    let circleButton = UIButton()
    var departureTextField = UITextField()
    var returnTextField = UITextField()
    var passengerTextField = CustomTextfieldView(title: LocalizedString.ViewController.passangers, placeholder: LocalizedString.ViewController.placeholder)
    var arrowImage = UIImageView()
    let searchButton = UIButton()
    let warningView = SafetyCustomView(title: LocalizedString.ViewController.travel, text: LocalizedString.ViewController.security)
    
    var activeTextField : UITextField?
    
    var departLabel = UILabel()
    var returnLabel = UILabel()
    
    lazy var safeArea = view.safeAreaLayoutGuide
    
    // MARK: - Initializers
    
    deinit {
        print("Deinit ViewController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        textFieldsIsNotEmpty()
        //        setupAddTargetIsNotEmptyTextFields()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .white
        self.navigationController?.setStatusBar(backgroundColor: .green)
        navigationController?.navigationBar.backgroundColor = .green
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewDidLayoutSubviews() {
        circleButton.layer.cornerRadius = 0.5 * circleButton.bounds.size.width
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldsIsNotEmpty()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: -  Methods
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
        setupActions()
        setHeight()
        datePickerConfig()
    }
    
    private func buildHierarchy() {
        
        view.addSubview(fromTextfield)
        view.addSubview(toTextfield)
        view.addSubview(circleButton)
        view.addSubview(departureTextField)
        departureTextField.addSubview(departLabel)
        view.addSubview(returnTextField)
        returnTextField.addSubview(returnLabel)
        view.addSubview(passengerTextField)
        passengerTextField.addSubview(arrowImage)
        view.addSubview(searchButton)
        view.addSubview(warningView)
        
    }
    
    private func configureSubviews() {
        
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.calendar = .current
        datePicker.minimumDate = Date()
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        fromTextfield.textField.delegate = self
        toTextfield.textField.delegate = self
        departureTextField.delegate = self
        returnTextField.delegate = self
        passengerTextField.textField.delegate = self
        
        departureTextField.backgroundColor = .white
        departureTextField.borderStyle = .roundedRect
        departureTextField.placeholder = LocalizedString.ViewController.depart
        departureTextField.inputView = datePicker
        
        departLabel.text = LocalizedString.ViewController.depart
        departLabel.textColor = .gray
        departLabel.textAlignment = .left
        departLabel.font = .systemFont(ofSize: 12)
        departLabel.isHidden = true
        
        returnLabel.text = LocalizedString.ViewController.returnBack
        returnLabel.textColor = .gray
        returnLabel.textAlignment = .left
        returnLabel.font = .systemFont(ofSize: 12)
        returnLabel.isHidden = true
        
        returnTextField.backgroundColor = .white
        returnTextField.borderStyle = .roundedRect
        returnTextField.delegate = self
        returnTextField.placeholder = LocalizedString.ViewController.returnBack
        returnTextField.inputView = datePicker
        
        passengerTextField.textField.clearButtonMode = .never
        
        circleButton.backgroundColor = .white
        circleButton.layer.cornerRadius = 0.5 * circleButton.bounds.size.width
        circleButton.setImage(UIImage(named: "swapArrows"), for: .normal)
        circleButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        circleButton.contentMode = .scaleAspectFit
        circleButton.layer.borderColor = UIColor.gray.cgColor
        circleButton.layer.borderWidth = 1
        circleButton.clipsToBounds = true
        circleButton.addTarget(self, action: #selector(circleButtonTapped), for: .touchUpInside)
        
        passengerTextField.textField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentModal)))
        
        arrowImage.image = UIImage(named: "arrow")
        arrowImage.contentMode = .scaleAspectFit
        
        searchButton.setTitle(LocalizedString.ViewController.search, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .green
        searchButton.layer.cornerRadius = 5
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        warningView.isUserInteractionEnabled = true
        warningView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(warningViewTapped)))
        
    }
    
    private func layoutSubviews() {
        
        fromTextfield.translatesAutoresizingMaskIntoConstraints = false
        fromTextfield.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        fromTextfield.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17).isActive = true
        fromTextfield.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17).isActive = true
        fromTextfield.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        toTextfield.translatesAutoresizingMaskIntoConstraints = false
        toTextfield.topAnchor.constraint(equalTo: fromTextfield.bottomAnchor, constant: 10).isActive = true
        toTextfield.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17).isActive = true
        toTextfield.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17).isActive = true
        
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        circleButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        circleButton.topAnchor.constraint(equalTo: fromTextfield.topAnchor, constant: 55).isActive = true
        circleButton.trailingAnchor.constraint(equalTo: fromTextfield.trailingAnchor, constant: -25).isActive = true
        
        departureTextField.translatesAutoresizingMaskIntoConstraints = false
        departureTextField.topAnchor.constraint(equalTo: toTextfield.bottomAnchor, constant: 10).isActive = true
        departureTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17).isActive = true
        departureTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        departureTextField.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        departLabel.translatesAutoresizingMaskIntoConstraints = false
        departLabel.topAnchor.constraint(equalTo: departureTextField.topAnchor, constant: 5).isActive = true
        departLabel.leadingAnchor.constraint(equalTo: departureTextField.leadingAnchor, constant: 8).isActive = true
        departLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        returnLabel.translatesAutoresizingMaskIntoConstraints = false
        returnLabel.topAnchor.constraint(equalTo: returnTextField.topAnchor, constant: 5).isActive = true
        returnLabel.leadingAnchor.constraint(equalTo: returnTextField.leadingAnchor, constant: 8).isActive = true
        returnLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        returnTextField.translatesAutoresizingMaskIntoConstraints = false
        returnTextField.topAnchor.constraint(equalTo: toTextfield.bottomAnchor, constant: 10).isActive = true
        returnTextField.leadingAnchor.constraint(equalTo: departureTextField.trailingAnchor, constant: 10).isActive = true
        returnTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17).isActive = true
        returnTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        passengerTextField.translatesAutoresizingMaskIntoConstraints = false
        passengerTextField.topAnchor.constraint(equalTo: returnTextField.bottomAnchor, constant: 10).isActive = true
        passengerTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17).isActive = true
        passengerTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17).isActive = true
        
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.trailingAnchor.constraint(equalTo: passengerTextField.trailingAnchor, constant: -5).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: passengerTextField.centerYAnchor).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowImage.widthAnchor.constraint(equalTo: arrowImage.heightAnchor).isActive = true
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: passengerTextField.bottomAnchor, constant: 10).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        warningView.translatesAutoresizingMaskIntoConstraints = false
        warningView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 10).isActive = true
        warningView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17).isActive = true
        warningView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17).isActive = true
        
    }
    
    // MARK: - Handlers
    
    
    private func setupActions() {
        
        fromTextfield.onTapAction = { [weak self] in
            
            
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            
            autocompleteController.tableCellBackgroundColor = UIColor.systemGreen
            autocompleteController.tableCellSeparatorColor = .clear
            
            self?.present(autocompleteController, animated: true, completion: nil)
            
            self?.fromTextfield.textField.becomeFirstResponder()
        }
        
        toTextfield.onTapAction = { [weak self] in
            
            
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            
            autocompleteController.tableCellBackgroundColor = UIColor.systemGreen
            autocompleteController.tableCellSeparatorColor = .clear
            
            self?.present(autocompleteController, animated: true, completion: nil)
            
            self?.toTextfield.textField.becomeFirstResponder()
        }
    }
    
    func datePickerConfig() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: true)
        departureTextField.inputAccessoryView   = toolBar
        returnTextField.inputAccessoryView     = toolBar
        
    }
    
    func setHeight() {
        
        if Locale.current.languageCode == "en" {
            warningView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        }
    }
    
    @objc func doneButtonTapped() {
        
        if departureTextField.isFirstResponder {
            departureTextField.text = dateFormatter.string(from: datePicker.date)
            ticket.departDate = dateFormatter.string(from: datePicker.date)
            departLabel.isHidden = false
        }
        
        if returnTextField.isFirstResponder {
            returnTextField.text = dateFormatter.string(from: datePicker.date)
            ticket.returnDate = dateFormatter.string(from: datePicker.date)
            returnLabel.isHidden = false
        }
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if toTextfield.textField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height / 4
            }
        }
    }
    
    @objc func presentModal() {
        let detailViewController = DetailViewController()
        
        detailViewController.threeInt = { [weak self] adult, bike, child in
            
            self?.ticket.adult = adult
            self?.ticket.bike = bike
            self?.ticket.child = child
            self?.passengerTextField.textField.text = self?.stringToShow(adult: adult, bike: bike, child: child)
            
            
            self?.textFieldsIsNotEmpty()
            
            
        }
        
        detailViewController.adultCounter = ticket.adult
        detailViewController.bikeCounter = ticket.bike
        detailViewController.childCounter = ticket.child
        
        detailViewController.transitioningDelegate  = detailViewController.overlayTransitioningDelegate
        detailViewController.modalPresentationStyle = .custom
        self.present(detailViewController, animated: true, completion: nil)
        
        //        let nav = UINavigationController(rootViewController: detailViewController)
        //        nav.modalPresentationStyle = .pageSheet
        //
        //        if let sheet = nav.sheetPresentationController {
        //
        //            sheet.detents = [.medium()]
        //            sheet.prefersGrabberVisible = true
        //            sheet.preferredCornerRadius = 15
        //            sheet.prefersEdgeAttachedInCompactHeight = true
        //            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        //        }
        //        present(nav, animated: true, completion: nil)
    }
    
    func stringToShow(adult: Int, bike: Int, child: Int) -> String {
        
        var finalString = ""
        
        if adult != 0 {
            finalString = LocalizedString.ViewController.adult + " \(adult)"
        }
        
        if bike != 0 {
            finalString += LocalizedString.ViewController.bike + " \(bike)"
        }
        
        if child != 0 {
            finalString += LocalizedString.ViewController.child + " \(child)"
        }
        
        return finalString
    }
    
    @objc func warningViewTapped() {
        if let url = NSURL(string:"https://global.flixbus.com/network-safety-updates") { UIApplication.shared.open(url as URL) }
    }

    func textFieldsIsNotEmpty() {
        
        if ticket.travelFrom.isEmpty || ticket.travelTo.isEmpty || ticket.departDate.isEmpty || ticket.returnDate.isEmpty || ticket.adult == 0 {
            searchButton.isEnabled = false
        } else {
            searchButton.isEnabled = true
        }
    }
    
    
    //        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
    //
    //        guard
    //            let from = fromTextfield.textField.text, !from.isEmpty,
    //            let to = toTextfield.textField.text, !to.isEmpty,
    //            let depart = departureTextField.text, !depart.isEmpty,
    //            let returnTo = returnTextField.text, !returnTo.isEmpty,
    //
    //                ticket.adult != 0 || ticket.bike != 0 || ticket.child != 0
    //        else {
    //            self.searchButton.isEnabled = false
    //            return
    //        }
    //
    //        searchButton.isEnabled = true
    
    
    @objc func circleButtonTapped() {
        
        firstText = fromTextfield.textField.text ?? ""
        secondText = toTextfield.textField.text ?? ""
        
        fromTextfield.textField.text = secondText
        toTextfield.textField.text   = firstText
    }
    
    @objc func searchButtonTapped() {
        
        
        let bc = BookingViewController()
        
        adultNumber = ticket.adult
        bikeNumber = ticket.bike
        childNumber = ticket.child
        
        ticketPrice = Double(40)//Double(((distanceLocation / 100) * Double(liter) * gasolinePrice))
        
        var trialPrice = (Double(adultNumber) * 0.5) + (Double(bikeNumber) * 0.3) + (Double(childNumber) * 0.1) + ticketPrice * 3
        
        passengerTicketPrice = trialPrice
        ticket.ticketPrice = String(format: "%.2f ", self.passengerTicketPrice)
        
        
        bc.finalTickerPrice = ticket.ticketPrice
        bc.currencyTicket = currency
        bc.departLabel.text = ticket.travelFrom
        bc.arrivalLabel.text = ticket.travelTo
        bc.passengerLabel.text = passengerTextField.textField.text
        bc.fromDateLabel.text = LocalizedString.ViewController.from + " \(ticket.departDate)"
        bc.returnDateLabel.text = LocalizedString.ViewController.returnBack + " \(ticket.returnDate)"
        
        self.navigationController?.pushViewController(bc, animated: true)
        
    }
    
    
}
// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == fromTextfield.textField && textField == toTextfield.textField {
            return false
        }
        
        return true
    }
    
}

// MARK: - GMSAutocompleteViewControllerDelegate

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let long = place.coordinate.longitude
        let lat = place.coordinate.latitude
        
        
        if let name = place.name {
            
            if activeTextField == fromTextfield.textField {
                
                startLocation = CLLocation(latitude: lat, longitude: long)
                fromTextfield.textField.text = name
                ticket.travelFrom = name
                fromTextfield.textField.resignFirstResponder()
                fromTextfield.titleLabel.isHidden = false
                
                
                NetworkManager.shared.getGasolinePrice(long: long, lat: lat) { gasoline in
                    DispatchQueue.main.async {
                        if let gasoline = gasoline {
                            self.gasolinePrice = Double(gasoline.result.gasoline)!
                            self.currency = gasoline.result.currency
                            print(gasoline)
                        }
                    }
                }
                
                
            } else if activeTextField == toTextfield.textField {
                
                endLocation = CLLocation(latitude: lat, longitude: long)
                toTextfield.textField.text = name
                ticket.travelTo = name
                toTextfield.titleLabel.isHidden = false
            }
            
        }
        
        var distance: CLLocationDistance = startLocation.distance(from: endLocation) / 10000
        
        distanceLocation = distance
        
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: DetailViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return UIPresentationController(presentedViewController:presented, presenting:presenting)
    }
    
}


//
//  BookingViewController.swift
//  BusApp
//
//  Created by REEMOTTO on 24.08.22.
//

import UIKit

class BookingViewController: UIViewController {
    
    // MARK: - Properties

    var finalTickerPrice: String = ""
    var currencyTicket: String = ""
    
    lazy var model = SettingsModel(title: "", currency: "")
    
    // MARK: - Subviews
    
    let routeImageView = UIImageView()
    let busImageView = UIImageView()
    let passagerImageView = UIImageView()
    
    var dateView = UIView()
    var ticketView = UIView()
    var ticketLabel = UILabel()
    var departLabel = UILabel()
    var arrivalLabel = UILabel()
    var passengerLabel = UILabel()
    var buyButton = UIButton()
    var fromDateLabel = UILabel()
    var returnDateLabel = UILabel()

    lazy var safeArea = view.safeAreaLayoutGuide
    
    // MARK: - Initializers
    
    deinit {
        print("Deinit ViewController")
    }
    
    // MARK: - Lifecycle


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .green
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.setStatusBar(backgroundColor: .green)
        setup()
    }
    
    // MARK: -  Methods
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
    }
    
    private func buildHierarchy() {
        
        view.addSubview(dateView)
        view.addSubview(ticketView)
        dateView.addSubview(fromDateLabel)
        dateView.addSubview(returnDateLabel)
        ticketView.addSubview(routeImageView)
        ticketView.addSubview(busImageView)
        ticketView.addSubview(passagerImageView)
        ticketView.addSubview(departLabel)
        ticketView.addSubview(arrivalLabel)
        ticketView.addSubview(ticketLabel)
        ticketView.addSubview(passengerLabel)
        ticketView.addSubview(buyButton)
    }
    
    private func configureSubviews() {
        
        dateView.backgroundColor = .systemGreen
        
        ticketView.backgroundColor = .secondarySystemBackground
        
        fromDateLabel.textColor = .black
        fromDateLabel.textAlignment = .center
        fromDateLabel.font = .systemFont(ofSize: 22)
        fromDateLabel.numberOfLines = 0
        fromDateLabel.adjustsFontSizeToFitWidth = true
        
        returnDateLabel.textColor = .black
        returnDateLabel.textAlignment = .center
        returnDateLabel.font = .systemFont(ofSize: 22)
        returnDateLabel.numberOfLines = 0
        returnDateLabel.adjustsFontSizeToFitWidth = true
        
        busImageView.image = UIImage(named: "bus")
        busImageView.contentMode = .scaleAspectFit
        
        routeImageView.image = UIImage(named: "route")
        routeImageView.contentMode = .scaleAspectFit

        passagerImageView.image = UIImage(named: "man")
        passagerImageView.contentMode = .scaleAspectFit

        departLabel.textColor = .black
        departLabel.backgroundColor = .white
        departLabel.textAlignment = .center
        departLabel.font = .systemFont(ofSize: 16)
        departLabel.numberOfLines = 0
        departLabel.layer.masksToBounds = true
        departLabel.layer.cornerRadius = 15
        
        arrivalLabel.textColor = .black
        arrivalLabel.backgroundColor = .white
        arrivalLabel.textAlignment = .center
        arrivalLabel.font = .systemFont(ofSize: 16)
        arrivalLabel.numberOfLines = 0
        arrivalLabel.layer.masksToBounds = true
        arrivalLabel.layer.cornerRadius = 15
        
        passengerLabel.textColor = .black
        passengerLabel.backgroundColor = .white
        passengerLabel.textAlignment = .center
        passengerLabel.font = .systemFont(ofSize: 16)
        passengerLabel.numberOfLines = 0
        passengerLabel.layer.masksToBounds = true
        passengerLabel.layer.cornerRadius = 15
        
        ticketLabel.backgroundColor = .white
        ticketLabel.textColor = .black
        ticketLabel.textAlignment = .center
        ticketLabel.font = .boldSystemFont(ofSize: 18)
        ticketLabel.text = finalTickerPrice + model.currency //"USD" //currencyTicket.uppercased()
        ticketLabel.numberOfLines = 0
        ticketLabel.adjustsFontSizeToFitWidth = true
        ticketLabel.layer.masksToBounds = true
        ticketLabel.layer.cornerRadius = 15
        
        buyButton.setTitle(LocalizedString.ViewController.buy, for: .normal)
        buyButton.setTitleColor(.black, for: .normal)
        buyButton.backgroundColor = .green
        buyButton.layer.cornerRadius = 15
    }
    
    private func layoutSubviews() {
        
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        dateView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        dateView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        dateView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        fromDateLabel.translatesAutoresizingMaskIntoConstraints = false
        fromDateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor).isActive = true
        fromDateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 15).isActive = true
        fromDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        fromDateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        returnDateLabel.translatesAutoresizingMaskIntoConstraints = false
        returnDateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor).isActive = true
        returnDateLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -15).isActive = true
        returnDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        returnDateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        ticketView.translatesAutoresizingMaskIntoConstraints = false
        ticketView.topAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
        ticketView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        ticketView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        ticketView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        routeImageView.translatesAutoresizingMaskIntoConstraints = false
        routeImageView.topAnchor.constraint(equalTo: ticketView.topAnchor, constant: 25).isActive = true
        routeImageView.leadingAnchor.constraint(equalTo: ticketView.leadingAnchor, constant: 15).isActive = true
        routeImageView.bottomAnchor.constraint(equalTo: arrivalLabel.bottomAnchor).isActive = true
        routeImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        busImageView.translatesAutoresizingMaskIntoConstraints = false
        busImageView.topAnchor.constraint(equalTo: ticketView.topAnchor, constant: 25).isActive = true
//        busImageView.trailingAnchor.constraint(equalTo: ticketView.trailingAnchor, constant: -15).isActive = true
        busImageView.centerXAnchor.constraint(equalTo: ticketLabel.centerXAnchor).isActive = true
        busImageView.bottomAnchor.constraint(equalTo: ticketLabel.topAnchor, constant: -5).isActive = true
        busImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        departLabel.translatesAutoresizingMaskIntoConstraints = false
        departLabel.topAnchor.constraint(equalTo: ticketView.topAnchor, constant: 25).isActive = true
        departLabel.leadingAnchor.constraint(equalTo: routeImageView.trailingAnchor, constant: 15).isActive = true
        departLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        departLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        arrivalLabel.translatesAutoresizingMaskIntoConstraints = false
        arrivalLabel.topAnchor.constraint(equalTo: departLabel.bottomAnchor, constant: 15).isActive = true
        arrivalLabel.leadingAnchor.constraint(equalTo: departLabel.leadingAnchor).isActive = true
        arrivalLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        arrivalLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        passagerImageView.translatesAutoresizingMaskIntoConstraints = false
        passagerImageView.topAnchor.constraint(equalTo: passengerLabel.topAnchor).isActive = true
        passagerImageView.leadingAnchor.constraint(equalTo: ticketView.leadingAnchor, constant: 15).isActive = true
        passagerImageView.bottomAnchor.constraint(equalTo: passengerLabel.bottomAnchor).isActive = true
        //        passagerImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        passagerImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        passengerLabel.translatesAutoresizingMaskIntoConstraints = false
        passengerLabel.topAnchor.constraint(equalTo: arrivalLabel.bottomAnchor, constant: 15).isActive = true
        passengerLabel.leadingAnchor.constraint(equalTo: departLabel.leadingAnchor).isActive = true
        passengerLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passengerLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        ticketLabel.translatesAutoresizingMaskIntoConstraints = false
        ticketLabel.centerYAnchor.constraint(equalTo: ticketView.centerYAnchor).isActive = true
        ticketLabel.trailingAnchor.constraint(equalTo: ticketView.trailingAnchor, constant: -15).isActive = true
        ticketLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ticketLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.topAnchor.constraint(equalTo: ticketLabel.bottomAnchor, constant: 20).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: ticketView.trailingAnchor, constant: -15).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    

    }

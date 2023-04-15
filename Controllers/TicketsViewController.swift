//
//  TicketsViewController.swift
//  BusApp
//
//  Created by REEMOTTO on 22.08.22.
//

import UIKit

class TicketsViewController: UIViewController {
    
    // MARK: - Properties

    
    // MARK: - Subviews

    var noTicketImage = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    lazy var safeArea = view.safeAreaLayoutGuide
    
    // MARK: - Initializers
    
    deinit {
        print("Deinit ViewController")
    }
    
    // MARK: - Lifecycle


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationController?.setStatusBar(backgroundColor: .green)
        navigationController?.navigationBar.backgroundColor = .green

    }
    
    // MARK: -  Methods

    private func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
    }
    
    private func buildHierarchy() {
        view.addSubview(noTicketImage)
        view.addSubview(label)
        view.addSubview(button)
    }
    
    private func configureSubviews() {
        
        noTicketImage.image = UIImage(named: "ticket")
        noTicketImage.contentMode = .scaleAspectFit
        
        label.text = LocalizedString.ViewController.ticket
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        button.setTitle(LocalizedString.ViewController.book, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
        
    }
    
    private func layoutSubviews() {
        
        noTicketImage.translatesAutoresizingMaskIntoConstraints = false
        noTicketImage.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -50).isActive = true
        noTicketImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -17).isActive = true
        noTicketImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17).isActive = true
        noTicketImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: noTicketImage.bottomAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -17).isActive = true
        label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 17).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -48).isActive = true
        button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 48).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK: - Handlers

    @objc func bookButtonTapped() {
        
        self.tabBarController?.selectedIndex = 0
        
    }

}

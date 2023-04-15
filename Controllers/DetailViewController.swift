//
//  DetailViewController.swift
//  BusApp
//
//  Created by REEMOTTO on 23.08.22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var adultCounter: Int = 0
    var bikeCounter: Int = 0
    var childCounter: Int = 0
    var passenger = ""
    public var threeInt: ((Int, Int, Int) -> Void)?
    
    let overlayTransitioningDelegate = OverlayTransitioningDelegate()

    
    
    // MARK: - Subviews
    
    let titleLabel = UILabel()
    lazy var adultView = CustomPassangersView(title: LocalizedString.ViewController.adult, infoIcon: false, count: adultCounter)
    lazy var bikeView = CustomPassangersView(title: LocalizedString.ViewController.bike, infoIcon: true, count: bikeCounter)
    lazy var childView = CustomPassangersView(title: LocalizedString.ViewController.child, infoIcon: false, count: childCounter)
    
    lazy var safeArea = view.safeAreaLayoutGuide
    
    // MARK: - Initializers
    
    deinit {
        print("Deinit ViewController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setup()
        
    }
    
    // MARK: -  Methods
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        layoutSubviews()
        setupAction()
    }
    
    private func buildHierarchy() {
        
        view.addSubview(titleLabel)
        view.addSubview(adultView)
        view.addSubview(bikeView)
        view.addSubview(childView)
    }
    
    private func configureSubviews() {
        
        titleLabel.text = LocalizedString.ViewController.passangers
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 26)
        titleLabel.textAlignment = .left
    }
    
    private func layoutSubviews() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        adultView.translatesAutoresizingMaskIntoConstraints = false
        adultView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        adultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        adultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        adultView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bikeView.translatesAutoresizingMaskIntoConstraints = false
        bikeView.topAnchor.constraint(equalTo: adultView.bottomAnchor, constant: 5).isActive = true
        bikeView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        bikeView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        bikeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.topAnchor.constraint(equalTo: bikeView.bottomAnchor, constant: 5).isActive = true
        childView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        childView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        childView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAction() {
        
        adultView.completionHadler = { [weak self] int in
            guard let self = self else { return }
            self.adultCounter = int
            self.threeInt?(self.adultCounter, self.bikeCounter, self.childCounter)
        }
        
        bikeView.completionHadler = { [weak self] int in
            guard let self = self else { return }
            self.bikeCounter = int
            self.threeInt?(self.adultCounter, self.bikeCounter, self.childCounter)
            
        }
        
        childView.completionHadler = { [weak self] int in
            guard let self = self else { return }
            self.childCounter = int
            self.threeInt?(self.adultCounter, self.bikeCounter, self.childCounter)
        }
        
    }
}

class OverlayTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    internal func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
            return OverlayPresentationController(presentedViewController:presented, presenting:presenting)
        }
    
}

class OverlayPresentationController: UIPresentationController {

    private let dimmedBackgroundView = UIView()
    private let height: CGFloat = 300.0

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.dimmedBackgroundView.addGestureRecognizer(tapGestureRecognizer)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        var frame =  CGRect.zero
        if let containerBounds = containerView?.bounds {
            frame = CGRect(x: 0,
                           y: containerBounds.height - height,
                           width: containerBounds.width,
                           height: height)
        }
        return frame
    }

    override func presentationTransitionWillBegin() {
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            containerView.addSubview(self.dimmedBackgroundView)
            self.dimmedBackgroundView.backgroundColor = .black
            self.dimmedBackgroundView.frame = containerView.bounds
            self.dimmedBackgroundView.alpha = 0
            coordinator.animate(alongsideTransition: { _ in
                self.dimmedBackgroundView.alpha = 0.5
            }, completion: nil)
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        self.dimmedBackgroundView.removeFromSuperview()
    }

    @objc private func backgroundTapped() {

        self.presentedViewController.dismiss(animated: true, completion: nil)
    }


}


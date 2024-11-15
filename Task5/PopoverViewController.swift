//
//  PopoverViewController.swift
//  Task5
//
//  Created by Gusev Kirill on 15.11.2024.
//

import UIKit

protocol PopoverViewControllerDelegate {
    func popoverDidDissmised()
}

final class PopoverViewController: UIViewController {
    
    public var delegate: PopoverViewControllerDelegate?
    
    private let switchView = UISegmentedControl(items: ["280 pt", "150 pt "])
    
    private let closeBtn = UIButton(type: .close)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    private func setupView() {
        view.addSubview(switchView)
        view.addSubview(closeBtn)
        
        switchView.selectedSegmentIndex = 0
        
        switchView.setAction(UIAction(title: "280 pt", handler: { _ in
            UIView.animate(withDuration: 0.2) {
                self.preferredContentSize = CGSize(width: 300, height: 280)
            }
        }), forSegmentAt: 0)
        
        switchView.setAction(UIAction(title: "150 pt", handler: { _ in
            UIView.animate(withDuration: 0.2) {
                self.preferredContentSize = CGSize(width: 300, height: 150)
            }
        }), forSegmentAt: 1)
        
        closeBtn.addTarget(self, action: #selector(dismissPopover), for: .touchUpInside)
    }
    
    @objc func dismissPopover() {
        delegate?.popoverDidDissmised()
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        switchView.sizeToFit()
        switchView.center = CGPoint(x: view.bounds.midX, y: 40)
        
        closeBtn.sizeToFit()
        closeBtn.center = CGPoint(x: view.bounds.width - closeBtn.bounds.midX - 10, y: 40)
    }
}

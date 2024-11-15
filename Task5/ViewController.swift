//
//  ViewController.swift
//  Task5
//
//  Created by Gusev Kirill on 15.11.2024.
//

import UIKit

class ViewController: UIViewController {

    private let presentButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        presentationController?.delegate = self
        setupBtn()
    }
    
    private func setupBtn() {
        view.addSubview(presentButton)
        
        NSLayoutConstraint.activate([
            presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        presentButton.setTitle("Present", for: .normal)
        presentButton.setTitleColor(.link, for: .normal)
        presentButton.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
    }
    
    @objc private func presentVC() {
        let vc = PopoverViewController()
        vc.preferredContentSize = .init(width: 300, height: 280)
        vc.modalPresentationStyle = .popover
        vc.delegate = self
        
        guard let presentVC = vc.popoverPresentationController else { return }
        presentVC.delegate = self
        presentVC.sourceView = presentButton
        presentVC.sourceRect = CGRect(x: presentButton.bounds.midX, y: presentButton.bounds.maxY, width: 0, height: 0)
        presentVC.permittedArrowDirections = .up
        presentButton.setTitleColor(.lightGray, for: .normal)
        present(vc, animated: true)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false
    }
}

extension ViewController: PopoverViewControllerDelegate {
    func popoverDidDissmised() {
        presentButton.setTitleColor(.link, for: .normal)
    }
}

//
//  BeneficiaryModalViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 08/09/2020.
//

import UIKit

public class BillDetailsModalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private lazy var contentView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = .smallestMargin
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        return $0
    }(UIView(frame: .zero))

    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Detalhes da conta"
        $0.textAlignment = .left
        $0.textColor = .grayKit
        $0.font = .customFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var headerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGrayKitBg
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var closeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .grayKit
        $0.setImage(UIImage.bundleImage(named: "x-circle"), for: .normal)
        $0.addTarget(self, action: #selector(self.dismissModal), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        self.view.isOpaque = false
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.headerView)
        self.headerView.addSubview(self.titleLabel)
        self.headerView.addSubview(self.closeButton)
        
        self.headerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.headerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.headerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: 528).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.bigMediumMargin).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: .bigMediumMargin).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.headerView.topAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.closeButton.leadingAnchor).isActive = true
        self.closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.closeButton.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -.smallMargin).isActive = true
        self.closeButton.centerYAnchor.constraint(equalTo: self.headerView.centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissModal))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    public func setup(data: Payment, highlightColor: UIColor) {
        
        
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard
            !self.contentView.bounds.contains(touch.location(in: self.contentView))
        else {
           return false
        }
       return true
    }

    @objc private func dismissModal() {
        self.dismiss(animated: false)
    }
    
    @objc func textDidChange(_ textField: UITextField) {

        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
}

extension BillDetailsModalViewController {
    public static func showModal(from vc: UIViewController)  {
        let modalViewController = BillDetailsModalViewController()
        modalViewController.modalPresentationStyle = .overCurrentContext
        vc.present(modalViewController, animated: false, completion: nil)
    }
}

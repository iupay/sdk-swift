//
//  IPPaymentLimitModalViewController.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 02/09/2020.
//

import UIKit

// MARK: - Class
public class IPPaymentLimitModalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /** Closure to handle the submit action  */
    public var handleSubmit: ((Bool, String?) -> ())?
    
    // MARK: - Private variables
    private lazy var contentRadio: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = .smallestMargin
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: .zero))
    
    private lazy var contentSearch: UIView = {
       $0.backgroundColor = .white
       $0.layer.cornerRadius = .smallestMargin
       $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
   }(UIView(frame: .zero))
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Deseja colocar limite de pagamento?"
        $0.textAlignment = .center
        $0.textColor = .grayKit
        $0.font = .customFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var titleSearch: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Valor para Limite Máximo:"
        $0.textAlignment = .center
        $0.textColor = .grayKit
        $0.font = .customFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var searchField: UITextField = {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1.0
        $0.keyboardType = .decimalPad
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)

        return $0
    }(UITextField(frame: .zero))
    
    private lazy var radioButtons: RDGroup = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isVertical = false
        $0.tintColor = .grayKit
        $0.selectedColor = .grayKit
        $0.titleColor = .grayKit
        $0.buttonSize = .smallMargin
        RDButton.appearance().ringWidth = 1
        $0.titleFont = .customFont(ofSize: 16, weight: .semibold)
        $0.titleAlignment = .left
        return $0
    }(RDGroup(titles: ["SIM", "NÃO"]))
    
    private lazy var submitButton: UIButton = {
        $0.backgroundColor = .grayKit
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("ok", for: .normal)
        $0.layer.cornerRadius = .smallestMargin
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(frame: .zero))
    
    
    // MARK: - Lifecycle methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        self.view.isOpaque = false
        self.view.addSubview(self.contentRadio)
        self.view.addSubview(self.contentSearch)
        
        self.contentRadio.addSubview(self.titleLabel)
        self.contentRadio.addSubview(self.radioButtons)
        self.contentSearch.addSubview(self.titleSearch)
        self.contentSearch.addSubview(self.searchField)
        self.contentSearch.addSubview(self.submitButton)
        
        self.contentRadio.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -.mediumMargin).isActive = true
        
        self.contentRadio.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .mediumMargin).isActive = true
        self.contentRadio.heightAnchor.constraint(equalToConstant: 65).isActive = true
        self.contentRadio.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -45).isActive = true
        
        self.contentSearch.topAnchor.constraint(equalTo: self.contentRadio.bottomAnchor, constant: .smallMargin).isActive = true
        self.contentSearch.trailingAnchor.constraint(equalTo: self.contentRadio.trailingAnchor).isActive = true
              
        self.contentSearch.leadingAnchor.constraint(equalTo: self.contentRadio.leadingAnchor).isActive = true
        self.contentSearch.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.contentRadio.topAnchor, constant: .smallestMargin).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentRadio.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentRadio.trailingAnchor).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
      
        self.radioButtons.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        self.radioButtons.centerXAnchor.constraint(equalTo: self.contentRadio.centerXAnchor).isActive = true
        self.radioButtons.widthAnchor.constraint(equalToConstant: 160).isActive = true
        self.radioButtons.bottomAnchor.constraint(equalTo: self.contentRadio.bottomAnchor).isActive = true
        
        self.titleSearch.topAnchor.constraint(equalTo: self.submitButton.topAnchor).isActive = true
        self.titleSearch.leadingAnchor.constraint(equalTo: self.contentSearch.leadingAnchor, constant: .smallestMargin).isActive = true
        self.titleSearch.widthAnchor.constraint(equalToConstant: 190).isActive = true
        self.titleSearch.heightAnchor.constraint(equalTo: self.submitButton.heightAnchor).isActive = true

        self.submitButton.trailingAnchor.constraint(equalTo: self.contentSearch.trailingAnchor, constant: -.smallestMargin).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: .bigMediumMargin).isActive = true
        self.submitButton.widthAnchor.constraint(equalToConstant: .defaultArea).isActive = true
        self.submitButton.centerYAnchor.constraint(equalTo: self.contentSearch.centerYAnchor).isActive = true
        
        self.searchField.topAnchor.constraint(equalTo: self.submitButton.topAnchor).isActive = true
        self.searchField.leadingAnchor.constraint(equalTo: self.titleSearch.trailingAnchor, constant: .smallestMargin).isActive = true
        self.searchField.trailingAnchor.constraint(equalTo: self.submitButton.leadingAnchor, constant: -.smallestMargin).isActive = true
        self.searchField.heightAnchor.constraint(equalTo: self.submitButton.heightAnchor).isActive = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissModal))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        self.submitButton.addTarget(self, action: #selector(self.submitAction), for: .touchUpInside)
    }
    
    // MARK: - Public methods
    public func setup(title: String, searchTitle: String, buttonTitle: String) {
        self.titleLabel.text = title
        self.titleSearch.text = searchTitle
        self.submitButton.setTitle(buttonTitle, for: .normal)
    }
    
    // MARK: - Private methods
    @objc private func submitAction() {
        self.view.endEditing(true)
        self.dismiss(animated: true) {
            self.handleSubmit?(self.radioButtons.selectedIndex == 0 ? true : false, self.searchField.text)
        }
    }
    
    @objc private func dismissModal() {
        self.view.endEditing(true)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func textDidChange(_ textField: UITextField) {

        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard
            !self.contentRadio.bounds.contains(touch.location(in: self.contentRadio)),
            !self.contentSearch.bounds.contains(touch.location(in: self.contentSearch))
        else {
            return false
        }
        
        return true
    }
}

extension IPPaymentLimitModalViewController {
    /**
     Static method to present the current controller modally and with transparent background
     
     - parameter vc: reference to the controller presenting it.
     - parameter handleSubmit: closure that will pass the user inputs
     */
    public static func showModal(from vc: UIViewController, handleSubmit:  ((Bool, String?) -> ())?)  {
        let modalViewController = IPPaymentLimitModalViewController()
        modalViewController.modalPresentationStyle = .overCurrentContext
        vc.present(modalViewController, animated: false, completion: nil)
        modalViewController.handleSubmit = handleSubmit
    }
}

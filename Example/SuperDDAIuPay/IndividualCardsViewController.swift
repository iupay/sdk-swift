//
//  IndividualCardsViewController.swift
//  SuperDDAIuPay
//
//  Created by lucianobohrer on 08/11/2020.
//  Copyright (c) 2020 lucianobohrer. All rights reserved.
//

import UIKit
import SuperDDAIuPay

class IndividualCardsViewController: UIViewController {

    @IBOutlet weak var beneficiaryCard: BeneficiaryCardView!
    @IBOutlet weak var baseCardView: BaseCardView!
    @IBOutlet weak var featuredCardView: BaseCardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // MARK: - BeneficiaryCard
        self.beneficiaryCard.configure(settings: BeneficiaryConfig(
                                        barColor: .systemRed,
                                        cardTextColor: .darkGray,
                                        selectorColor: .systemRed,
                                        cardTitle: "CERJ",
                                        cnpj: "99.999.999.0001-99",
                                        activated: false,
                                        amount: 300,
                                        amountLabel: "Valor Limite:",
                                        text: "Débito automático no dia do vencimento",
                                        imageUrl: "https://devshift.biz/wp-content/uploads/2017/04/profile-icon-png-898.png",
                                        type: .monthly))
        
        self.beneficiaryCard.handleSelectorChange = { [weak self] isOn in
            guard let self = self, isOn else { return }
            
            PaymentLimitModalViewController.showModal(from: self) { [weak self] (selected, query) in
                self?.presentAlert(withTitle: "Result", message: "Selected: \(selected)\nQuery:\(String(describing: query))")
            }
        }
        
        // MARK: Base Card View
        self.baseCardView.configure(settings: BaseConfig(barColor: .systemRed,
                                    dueText: "Vencendo hoje,",
                                    cardTextColor: .darkGray,
                                    cnpj: "99.999.999.0001-99",
                                    paid: true,
                                    isDue: false,
                                    fromEmail: false,
                                    addedByUser: false,
                                    amount: 50,
                                    date: "03 Ago",
                                    text: "Tipo de Plano: Premium ULTRA HD",
                                    type: .locked))
        
        
        // MARK: Base Card View as Featured
        self.featuredCardView.configure(settings:
            BaseConfig(barColor: UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1.0),
                                        dueText: "Vencendo hoje",
                                        cardTextColor: .darkGray,
                                        cnpj: "99.999.999.0001-99",
                                        paid: true,
                                        isDue: true,
                                        fromEmail: true,
                                        addedByUser: true,
                                        amount: 50,
                                        date: "03 Ago",
                                        text: "Bandeira Amarela",
                                        featured: true,
                                        featuredColor: UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 0.7),
                                        type: .lightbill(flag: .yellow)))
    }
}

extension UIViewController {

    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func generatePaymentData() -> Payment {
        guard
            let url = Bundle.main.url(forResource: "PaymentDetailsData", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let payment = try? JSONDecoder().decode(Payment.self, from: data)
        else {
            fatalError()
        }
        return payment
    }
}


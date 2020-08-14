//
//  ViewController.swift
//  SuperDDAIuPay
//
//  Created by lucianobohrer on 08/11/2020.
//  Copyright (c) 2020 lucianobohrer. All rights reserved.
//

import UIKit
import SuperDDAIuPay

class ViewController: UIViewController {

    @IBOutlet weak var beneficiaryCard: BeneficiaryCardView!
    @IBOutlet weak var monthSelector: MonthSelectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.beneficiaryCard.configure(barColor: .systemRed,
                                       cardTextColor: .darkGray,
                                       selectorColor: .systemRed,
                                       cardTitle: "CERJ",
                                       cnpj: "99.999.999.0001-99",
                                       imageHeight: 32,
                                       imageWidth: 32,
                                       activated: false,
                                       amountLimit: "R$ 300",
                                       amountLimitTitle: "Valor Limite:",
                                       text: "Débito automático no dia do vencimento",
                                       imageUrl: "https://devshift.biz/wp-content/uploads/2017/04/profile-icon-png-898.png",
                                       type: .Account)
        
        self.beneficiaryCard.handleSelectorChange = { [weak self] isOn in
            self?.presentAlert(withTitle: "Toggle", message: "You set toggle to \(isOn)")
        }
        
        
        self.monthSelector.set(currentMonth: 2)
        self.monthSelector.handleMonthChange = { [weak self] month in
            self?.presentAlert(withTitle: "Month Tab", message: "Month selected \(month)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}


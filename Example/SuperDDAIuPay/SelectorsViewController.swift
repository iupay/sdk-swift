//
//  SelectorsViewController.swift
//  SuperDDAIuPay_Example
//
//  Created by Luciano Bohrer on 25/08/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SuperDDAIuPay

class SelectorsViewController: UIViewController {

    @IBOutlet weak var tabSelector: TabSelectorView!
    @IBOutlet weak var monthSelector: MonthSelectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Month Selector
        self.monthSelector.handleMonthChange = { [weak self] month in
            self?.presentAlert(withTitle: "Month Tab", message: "Month selected \(month)")
        }
        
        self.tabSelector.configure(items: ["Pagamentos", "Beneficiários", "Serviços", "Recusados"], tabColor: .systemRed)
        
        self.tabSelector.handleItemChange = { [weak self] item in
            self?.presentAlert(withTitle: "Tab", message: "Item selected \(item)")
        }
    }
}

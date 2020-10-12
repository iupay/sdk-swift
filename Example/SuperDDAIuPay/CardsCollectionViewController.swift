//
//  CardsCollectionViewController.swift
//  SuperDDAIuPay_Example
//
//  Created by Luciano Bohrer on 21/08/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SuperDDAIuPay

class CardsCollectionViewController: UIViewController {

    @IBOutlet weak var cardsView: IPCardListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())!

        let items = [
            IPCardItem(barColor: .systemRed, cardTitle: nil, dueDate: nextMonthDate, isPaid: false, type: .netflix, amount: 100.0, isLocked: false),
            IPCardItem(barColor: UIColor.from(hex: "#0d56f3"), cardTitle: nil, dueDate: Date(), isPaid: true,  type: .nubank, amount: 150.0, isLocked: false),
            IPCardItem(barColor: .systemGreen, cardTitle: nil, dueDate:Date(), isPaid: false, type: .spotify, amount: 400, isLocked: false),
            IPCardItem(barColor: .systemRed, cardTitle: nil, dueDate:Date(), isPaid: false, type: .lightbill(flag: .red), amount: 400, isLocked: false),
            IPCardItem(barColor: .lightGray, cardTitle: "ARNALDO PESSOA LEAL", dueDate: Date(), type: .standard(imageUrl: "https://devshift.biz/wp-content/uploads/2017/04/profile-icon-png-898.png"), amount: 100.0, isLocked: false),
            IPCardItem(barColor: UIColor.from(hex: "#0d56f3"), cardTitle: nil, dueDate: Date(), isPaid: true, type: .standard(imageUrl: "https://logodownload.org/wp-content/uploads/2014/04/bmw-logo-2.png"), amount: 100.0, isLocked: true)
        ]
        
        let text = "Você tem 4 pagamentos vencendo em até <b>7 dias</b>, no valor total de: ".convertHtml(textColor: .white)
        self.cardsView.configure(source: items,
                                 featured: true,
                                 featuredColor: .systemOrange,
                                 featuredTextColor: .white,
                                 titleText: "Vencendo em até 7 dias",
                                 totalPaymentText: text,
                                 totalAlignment: .center,
                                 totalDueOnly: true)
    }
}

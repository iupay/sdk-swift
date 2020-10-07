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

    @IBOutlet weak var cardsView: CardListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())!

        let items = [
            CardItem(barColor: .systemRed, cardTitle: nil, dueDate: nextMonthDate, isPaid: false, type: .netflix, amount: 100.0, isLocked: false),
            CardItem(barColor: UIColor.from(hex: "#0d56f3"), cardTitle: nil, dueDate: Date(), isPaid: true,  type: .nubank, amount: 150.0, isLocked: false),
            CardItem(barColor: .systemGreen, cardTitle: nil, dueDate:Date(), isPaid: false, type: .spotify, amount: 400, isLocked: false),
            CardItem(barColor: .systemRed, cardTitle: nil, dueDate:Date(), isPaid: false, type: .lightbill(flag: .red), amount: 400, isLocked: false),
            CardItem(barColor: .lightGray, cardTitle: "ARNALDO PESSOA LEAL", dueDate: Date(), isPaid: false, type: .standard(imageUrl: "https://devshift.biz/wp-content/uploads/2017/04/profile-icon-png-898.png"), amount: 100.0, isLocked: false),
            CardItem(barColor: UIColor.from(hex: "#0d56f3"), cardTitle: nil, dueDate: Date(), isPaid: true, type: .standard(imageUrl: "https://logodownload.org/wp-content/uploads/2014/04/bmw-logo-2.png"), amount: 100.0, isLocked: true)
        ]
        
        self.cardsView.configure(source: items,
                                 featured: true,
                                 featuredColor: .systemOrange,
                                 featuredTextColor: .white,
                                 totalPaymentText: "Valor total dos pagamentos que vencem hoje:",
                                 totalAlignment: .center,
                                 totalDueOnly: true)
    }
}

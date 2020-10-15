//
//  MenuTableViewController.swift
//  SuperDDAIuPay_Example
//
//  Created by Luciano Bohrer on 06/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SuperDDAIuPay

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }

     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let paidVC = segue.destination as? IPPaidDetailsViewController {
            
            paidVC.setContent(beneficiaryName: "John Doe",
                              paidDate: Date(),
                              dueDate: Date(),
                              navTitle: "CERJ",
                              imageUrl: "https://i.imgur.com/WyzDPRP.png",
                              paymentAmount: 223.24,
                              baseColor: UIColor.from(hex: "#f78c49"),
                              receiptAvailable: true,
                              paymentMessage: "Sua conta está paga")
            
        } else if let payDetailsVC = segue.destination as? IPPaymentDetailsViewController {
            payDetailsVC.setContent(beneficiaryName: "John Doe",
                                    scheduledDueDate: Date(),
                                    dueDate: Date(),
                                    navTitle: "PAGAMENTO",
                                    paymentAmount: 223.24,
                                    currentBalance: 3250,
                                    baseColor: UIColor.from(hex: "#f78c49"),
                                    paymentMessage: "",
                                    payerName: "Jane Doe",
                                    bankName: "ITAU",
                                    barcode: "34191.09065 44830. 1285 40141.906 8 00001.83120.59475",
                                    payWithType: "My Banking",
                                    isPayment: false)
            
            payDetailsVC.handleButtonClick = {
                IPMessageModalViewController.showModal(from: self, title: "Agendamento da Conta", message: "O seu pagamento será debitado às 16h do dia de pagamento\n\nVocê pode cancelar o agendamento / pagamento até às 16hs do dia.")
            }
        } else if let receiptVC = segue.destination as? IPReceiptViewController {
            receiptVC.setContent(cedentName: "COMPANHIA DE ELETRICIDADE DO RIO DE JANEIRO",
                                 cnpj: "15.139.629/0001-99",
                                 payerName: "ROBERTO DE OLIVEIRA SANTOS",
                                 barcode: "34191.09065 44830. 1285 40141.906 8 00001.83120.59475",
                                 dueDate: Date(),
                                 paidDate: Date(),
                                 value: 223.24,
                                 discount: 0.0,
                                 interest: 0.0,
                                 fine: 0.0,
                                 chargedValue: 223.24,
                                 authCode: "A.6DE.DF4.75E.DBB,128",
                                 baseColor: UIColor.from(hex: "#f78c49"))
            
            receiptVC.handleShareClick = {
                print("SHARE")
            }
            
            receiptVC.handleOptionsClick = {
                print("OPTIONS")
            }
        } else if let benDetails = segue.destination as? IPBeneficiaryDetailsViewController {
            benDetails.setupContent(payment: self.generatePaymentData(),
                                    baseColor: UIColor.from(hex: "#8e05c2"))
            benDetails.handleSeeDetails = {
                IPBillDetailsModalViewController.showModal(from: benDetails,
                                                           payment: self.generatePaymentData(),
                                                           highlightColor: UIColor.from(hex: "#8e05c2"),
                                                           type: .beneficiary)
            }
        } else if let paymentAccount = segue.destination as? IPPaymentAccountViewController {
            let payData = self.generatePaymentData(autoPayment: segue.identifier == "alternative" ? true : false)
            paymentAccount.setupContent(payment: payData,
                                        pdfAvailable: true,
                                        paymentHistoryEnabled: true,
                                        chartDataText: "OUTUBRO",
                                        chartDataValue: "R$ 1.983,36",
                                        chartLegend: "Resumo das Faturas Anteriores",
                                        chartData: [IPChartData(label: "JUN", value: 950),
                                                    IPChartData(label: "JUL", value: 1050),
                                                    IPChartData(label: "AGO", value: 800),
                                                    IPChartData(label: "SET", value: 970),
                                                    IPChartData(label: "OUT", value: 1300),
                                                    IPChartData(label: "NOV", value: 1500)],
                                        baseColor: UIColor.from(hex: "#8e05c2"))
            
            paymentAccount.handleSeeDetails = {
                IPBillDetailsModalViewController.showModal(from: paymentAccount, payment: self.generatePaymentData(),  highlightColor: UIColor.from(hex: "#8e05c2"), type: .bill)
            }
        }
    }
}

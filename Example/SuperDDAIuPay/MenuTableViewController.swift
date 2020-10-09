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
        return 8
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


     // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let paidVC = segue.destination as? PaidDetailsViewController {
            
            paidVC.setContent(beneficiaryName: "John Doe",
            paidDate: Date(),
            dueDate: Date(),
            navTitle: "CERJ",
            imageUrl: "https://i.imgur.com/WyzDPRP.png",
            paymentAmount: 223.24,
            baseColor: UIColor.from(hex: "#f78c49"),
            receiptAvailable: true,
            paymentMessage: "Sua conta está paga")
            
        } else if let payDetailsVC = segue.destination as? PaymentDetailsViewController {
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
                MessageModalViewController.showModal(from: self, title: "Agendamento da Conta", message: "O seu pagamento será debitado às 16h do dia de pagamento\n\nVocê pode cancelar o agendamento / pagamento até às 16hs do dia.")
            }
        } else if let receiptVC = segue.destination as? ReceiptViewController {
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
        } else if let benDetails = segue.destination as? BeneficiaryDetailsViewController {
            benDetails.setupContent(payment: self.generatePaymentData(), baseColor: UIColor.from(hex: "#8e05c2"))
            benDetails.handleSeeDetails = {
                BillDetailsModalViewController.showModal(from: benDetails, payment: self.generatePaymentData(),  highlightColor: UIColor.from(hex: "#8e05c2"), type: .benificiary)
            }
        } else if let paymentAccount = segue.destination as? PaymentAccountViewController {
            paymentAccount.setupContent(payment: self.generatePaymentData(),
                                        pdfAvailable: true,
                                        paymentHistoryEnabled: true,
                                        chartDataText: "OUTUBRO",
                                        chartDataValue: "R$ 1.983,36",
                                        chartLegend: "Resumo das Faturas Anteriores",
                                        chartData: [ChartData(label: "JUN", value: 950),
                                                    ChartData(label: "JUL", value: 1050),
                                                    ChartData(label: "AGO", value: 800),
                                                    ChartData(label: "SET", value: 970),
                                                    ChartData(label: "OUT", value: 1300),
                                                    ChartData(label: "NOV", value: 1500)],
                                        baseColor: UIColor.from(hex: "#8e05c2"))
            
            paymentAccount.handleSeeDetails = {
                BillDetailsModalViewController.showModal(from: paymentAccount, payment: self.generatePaymentData(),  highlightColor: UIColor.from(hex: "#8e05c2"), type: .bill)
            }
        }
    }
}

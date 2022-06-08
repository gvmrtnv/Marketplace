//
//  Invoice.swift
//  Influencer
//
//  Created by Gleb Martynov on 03.03.22.
//

import Foundation
public struct Invoice {
    var collabKey: String?
    var cfid: String?
    var collab: Collab
    var myName: String
    var myLastName: String
    var myCompanyName: String
    var myAddress: String
    var myTaxNumber: String
    var myAccountHolder: String
    var myIban: String
    var myBankName: String
    var recName: String?
    var recLastName: String?
    var recCompanyName: String?
    var recAddress: String?
    var recTaxNumber: String?
    var service: String?
    var compensation: String?
    var taxPercent: String?
    var brand: String?
    var invoiceNumber: String?
    var date: TimeInterval?
}



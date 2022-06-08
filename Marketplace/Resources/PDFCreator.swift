//
//  PDFCreator.swift
//  Influencer
//
//  Created by Gleb Martynov on 28.02.22.
//

import UIKit
import PDFKit

class PDFCreator: NSObject {
    var invoice: Invoice
    var invTitle: String
  
    init(invoice: Invoice, invTitle: String) {
        self.invoice = invoice
        self.invTitle = invTitle
  }
  
  func createInvoice() -> Data {
  
    let pdfMetaData = [
      kCGPDFContextCreator: "SOCIALZONE",
      kCGPDFContextAuthor: "gvmrtnv",
      kCGPDFContextTitle: invTitle,
      kCGPDFContextSubject: "invoice"
    ]
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]
    

    let pageWidth = 8.27 * 72.0
      let pageHeight = 11.69 * 72.0
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    
    // 3
    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
    // 4
    let data = renderer.pdfData { (context) in
      // 5
        context.beginPage()
        let context = context.cgContext
      // 6
        drawBackground(context, pageRect: pageRect)
        let titleBottom = addTitle(pageRect: pageRect)
//      let imageBottom = addImage(pageRect: pageRect, imageTop: titleBottom + 18.0)
        addBodyText(pageRect: pageRect, textTop: titleBottom + 3.5 / 2.54 * 72)
        
        
    }
    
    return data
  }
    
   
    func drawBackground(_ drawContext: CGContext, pageRect: CGRect) {
        
        drawContext.saveGState()
        drawContext.setFillColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        drawContext.fill(CGRect(x: 2.5 / 2.54 * 72, y: 13.5 / 2.54 * 72, width: 16.5 / 2.54 * 72, height: 0.75 / 2.54 * 72))
   

        drawContext.restoreGState()
    }
  
    func addTitle(pageRect: CGRect) -> CGFloat {
    // 1
      let titleFont = UIFont.systemFont(ofSize: 20.0, weight: .regular)
    // 2
    let titleAttributes: [NSAttributedString.Key: Any] =
      [NSAttributedString.Key.font: titleFont]
    let attributedTitle = NSAttributedString(string: "RECHNUNG", attributes: titleAttributes)
    // 3
    let titleStringSize = attributedTitle.size()
    // 4
      let titleStringRect = CGRect(x: 2.5 / 2.54 * 72,
                                   y: 1 / 2.54 * 72, width: titleStringSize.width,
                                 height: titleStringSize.height)
    // 5
    attributedTitle.draw(in: titleStringRect)
    // 6
    return titleStringRect.origin.y + titleStringRect.size.height
    }

  func addBodyText(pageRect: CGRect, textTop: CGFloat) {
    // 1
      let textFont = UIFont.systemFont(ofSize: 9.0, weight: .regular)
     
    // 2
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping
    // 3
    let textAttributes = [
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.font: textFont
    ]
     
      let recipientText = "Empfänger\n\(invoice.recName!) \(invoice.recLastName!)\n\(invoice.recCompanyName!)\n\n\(invoice.recTaxNumber!)\n\n\(invoice.recAddress!)"
      let attributedRecText = NSAttributedString(string: recipientText, attributes: textAttributes)
      let recTextSize = attributedRecText.size()
    // 4
      let recTextRect = CGRect(x: 2.5 / 2.54 * 72, y: textTop, width: recTextSize.width,
                          height: recTextSize.height)
      attributedRecText.draw(in: recTextRect)
      
      
      let senderText = "Absender\n\(invoice.myName) \(invoice.myLastName)\n\(invoice.myCompanyName)\n\n\(invoice.myTaxNumber)\n\nRechnungsnummer: \(invoice.invoiceNumber!)\nRechnungsdatum: \nLeistungsdatum: \(invoice.date!)"
      let attributedSenderText = NSAttributedString(string: senderText, attributes: textAttributes)
      let senderTextSize = attributedSenderText.size()
      let senderTextRect = CGRect(x: 12.5 / 2.54 * 72, y: textTop, width: senderTextSize.width,
                          height: senderTextSize.height)
      attributedSenderText.draw(in: senderTextRect)
      
      
      let boldTextFont = UIFont.systemFont(ofSize: 11.0, weight: .bold)
      let textAttributes1 = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: boldTextFont
      ]
      let text1 = "Rechnung"
      let attributedText1 = NSAttributedString(string: text1, attributes: textAttributes1)
      let text1Size = attributedText1.size()
      let text1Rect = CGRect(x: 2.5 / 2.54 * 72, y: 10.0 / 2.54 * 72, width: text1Size.width,
                          height: text1Size.height)
      attributedText1.draw(in: text1Rect)
      
      
      let textFont2 = UIFont.systemFont(ofSize: 10.0, weight: .regular)
      let textAttributes2 = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont2
      ]
      let text2 = "Sehr geehrte Damen und Herren,\n\nanbei erhalten Sie die Rechnung für meine erbrachten Leistungen."
      let attributedText2 = NSAttributedString(string: text2, attributes: textAttributes2)
      let text2Size = attributedText2.size()
      let text2Rect = CGRect(x: 2.5 / 2.54 * 72, y: 11.5 / 2.54 * 72, width: text2Size.width,
                          height: text2Size.height)
      attributedText2.draw(in: text2Rect)
      
      
      let textFont3 = UIFont.systemFont(ofSize: 10.0, weight: .semibold)
      let textAttributes3 = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont3,
        NSAttributedString.Key.foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
      ] as [NSAttributedString.Key : Any]
      let text31 = "Leistung"
      let text32 = "Beschreibung"
      let text33 = "Summe netto"
      let attributedText31 = NSAttributedString(string: text31, attributes: textAttributes3)
      let text31Size = attributedText31.size()
      let text31Rect = CGRect(x: 3 / 2.54 * 72, y: 13.6 / 2.54 * 72, width: text31Size.width,
                          height: text31Size.height)
      attributedText31.draw(in: text31Rect)
      
      let attributedText32 = NSAttributedString(string: text32, attributes: textAttributes3)
      let text32Size = attributedText32.size()
      let text32Rect = CGRect(x: 6 / 2.54 * 72, y: 13.6 / 2.54 * 72, width: text32Size.width,
                          height: text32Size.height)
      attributedText32.draw(in: text32Rect)
      
      let attributedText33 = NSAttributedString(string: text33, attributes: textAttributes3)
      let text33Size = attributedText33.size()
      let text33Rect = CGRect(x: 18.8 / 2.54 * 72 - text33Size.width, y: 13.6 / 2.54 * 72, width: text33Size.width,
                          height: text33Size.height)
      attributedText33.draw(in: text33Rect)
      
     // Invoice values
      let textFont5 = UIFont.systemFont(ofSize: 10.0, weight: .bold)
      let textAttributes5 = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont5,
        NSAttributedString.Key.foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
      ] as [NSAttributedString.Key : Any]
      let description = invoice.collab.note
      let attributedDescription = NSAttributedString(string: description, attributes: textAttributes5)
      let descrSize = attributedDescription.size()
      let descrRect = CGRect(x: 6 / 2.54 * 72, y: 14.75 / 2.54 * 72, width: 16 / 2.54 * 72,
                          height: descrSize.height)
      attributedDescription.draw(in: descrRect)
      
      
      let textFont4 = UIFont.systemFont(ofSize: 10.0, weight: .regular)
      let textAttributes4 = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont4,
        NSAttributedString.Key.foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
      ] as [NSAttributedString.Key : Any]
      var contentString = ""
      invoice.collab.content?.forEach({ content in
          guard let number = content.number,
              number > 0
          else {return}
          contentString.append("\(number) \(content.title),\n")
      })
      contentString = contentString.replacingOccurrences(of: "-", with: "/")
      let summe = invoice.collab.revard
      var amountWithPrefix = summe
      let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
      amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, summe.count), withTemplate: "")
  
      let double = (amountWithPrefix as NSString).doubleValue
      
      let ust = double * 0.19
      let total = ust + double
      let ustNumber = NSNumber(value: (ust/100))
      let totalNumber = NSNumber (value: (total/100))
      let formatter = NumberFormatter()
      formatter.numberStyle = .currencyAccounting
      formatter.currencySymbol = "$"
      formatter.maximumFractionDigits = 2

      let ustString = formatter.string(from: ustNumber)!
      let totalString = formatter.string(from: totalNumber)!
      

      let attributedContent = NSAttributedString(string: contentString, attributes: textAttributes4)
      let contentSize = attributedContent.size()
      let contentRect = CGRect(x: 2.8 / 2.54 * 72, y: 14.75 / 2.54 * 72, width: contentSize.width / 2.54 * 72,
                          height: contentSize.height)
      contentString.draw(in: contentRect)
      
      let attributedSumme = NSAttributedString(string: summe, attributes: textAttributes4)
      let summeSize = attributedSumme.size()
      let summeRect = CGRect(x: 18.8 / 2.54 * 72 - summeSize.width, y: 14.75 / 2.54 * 72, width: summeSize.width / 2.54 * 72,
                          height: summeSize.height)
      
      let sumY = max(contentRect.maxY, descrRect.maxY)
      let summeRect2 = CGRect(x: 18.8 / 2.54 * 72 - summeSize.width, y: sumY + 0.2 / 2.54 * 72, width: summeSize.width / 2.54 * 72,
                          height: summeSize.height)
      summe.draw(in: summeRect)
      summe.draw(in: summeRect2)
      
      let attributedUst = NSAttributedString(string: ustString, attributes: textAttributes4)
      let ustSize = attributedUst.size()
      let ustRect = CGRect(x: 18.8 / 2.54 * 72 - ustSize.width, y: summeRect2.maxY + 0.2 / 2.54 * 72, width: ustSize.width / 2.54 * 72,
                          height: ustSize.height)
      ustString.draw(in: ustRect)
      
      let attributedTotal = NSAttributedString(string: totalString, attributes: textAttributes4)
      let totalSize = attributedTotal.size()
      let totalRect = CGRect(x: 18.8 / 2.54 * 72 - totalSize.width , y: ustRect.maxY + 0.2 / 2.54 * 72, width: totalSize.width / 2.54 * 72,
                          height: totalSize.height)
      totalString.draw(in: totalRect)
      
      // Further text
      
      let text51 = "Summe netto"
      let attributedText51 = NSAttributedString(string: text51, attributes: textAttributes5)
      let text51Size = attributedText51.size()
      let text51Rect = CGRect(x: 12.5 / 2.54 * 72, y: summeRect2.minY, width: text51Size.width,
                          height: text51Size.height)
      attributedText51.draw(in: text51Rect)
      
      let text52 = "USt. 19%"
      let attributedText52 = NSAttributedString(string: text52, attributes: textAttributes5)
      let text52Size = attributedText52.size()
      let text52Rect = CGRect(x: 12.5 / 2.54 * 72, y: ustRect.minY, width: text52Size.width,
                          height: text52Size.height)
      attributedText52.draw(in: text52Rect)
      
      let text53 = "Rechnungssumme"
      let attributedText53 = NSAttributedString(string: text53, attributes: textAttributes5)
      let text53Size = attributedText53.size()
      let text53Rect = CGRect(x: 12.5 / 2.54 * 72, y: totalRect.minY, width: text53Size.width,
                          height: text53Size.height)
      attributedText53.draw(in: text53Rect)
      
      // Tail text
      let text21 = "Vielen Dank für die Zusammenarbeit.\n\nMit Freundlichen Grüßen\n\n\(invoice.myName) \(invoice.myLastName)\n\(invoice.myCompanyName)"
      let attributedText21 = NSAttributedString(string: text21, attributes: textAttributes2)
      let text21Size = attributedText21.size()
      let text21Rect = CGRect(x: 2.5 / 2.54 * 72, y: totalRect.maxY + 1.5 / 2.54 * 72, width: text21Size.width,
                          height: text21Size.height)
      attributedText21.draw(in: text21Rect)
      
      // Bottom text
      let textFont6 = UIFont.systemFont(ofSize: 7.0, weight: .regular)
      let textAttributes6 = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont6,
        NSAttributedString.Key.foregroundColor: UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1)
      ] as [NSAttributedString.Key : Any]
      
      let text61 = "\(invoice.myName) \(invoice.myLastName)\n\(invoice.myCompanyName)\n\(invoice.myAddress)"
      let attributedText61 = NSAttributedString(string: text61, attributes: textAttributes6)
      let tetx61Size = attributedText61.size()
      let text61Rect = CGRect(x: 2.5 / 2.54 * 72, y: 27.5 / 2.54 * 72, width: tetx61Size.width,
                          height: tetx61Size.height)
      attributedText61.draw(in: text61Rect)
      
      let text62 = "\(invoice.myAccountHolder)\n\(invoice.myBankName)\nIBAN: \(invoice.myIban)\nBIC: "
      let attributedText62 = NSAttributedString(string: text62, attributes: textAttributes6)
      let tetx62Size = attributedText62.size()
      let text62Rect = CGRect(x: 10 / 2.54 * 72, y: 27.5 / 2.54 * 72, width: tetx62Size.width,
                          height: tetx62Size.height)
      attributedText62.draw(in: text62Rect)
      
      let text63 = "USt.-IdNr. \(invoice.myTaxNumber)"
      let attributedText63 = NSAttributedString(string: text63, attributes: textAttributes6)
      let tetx63Size = attributedText63.size()
      let text63Rect = CGRect(x: text62Rect.maxX + 0.5 / 2.54 * 72, y: 27.5 / 2.54 * 72, width: tetx63Size.width,
                          height: tetx63Size.height)
      attributedText63.draw(in: text63Rect)
  }

  
}

//
//  PdfViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 13.03.22.
//

import UIKit
import PDFKit

class PdfViewController: UIViewController {
    
    
    //MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Preview"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var previewView: PDFView = {
        let view = PDFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.pageShadowsEnabled = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var shadowView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()

    //MARK: - Values
    
    var pdfTitle: String! {
        didSet {
            titleLabel.text = pdfTitle
        }
    }
    var document: PDFDocument!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(previewView)
        view.addSubview(shadowView)
        
        previewView.document = document
        previewView.autoScales = true
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            shadowView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            previewView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 20),
            previewView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewView.heightAnchor.constraint(greaterThanOrEqualTo: previewView.widthAnchor, multiplier: 11.69 / 8.27),
            previewView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    


}

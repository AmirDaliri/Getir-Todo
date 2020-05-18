//
//  DetailVC.swift
//  To Do Lists
//
//  Created by Amir Daliri on 5/17/20.
//  Copyright © 2020 Amir Daliri. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    //MARK: - Properties
    
    var cellData: List! {
        didSet {
            titleLabel.text = cellData.title
            if let existedDescription = cellData.descriptionText {
                textView.text = existedDescription
            }
        }
    }
    
    
    lazy var headerView: UIView = {
        let bv = UIView()
        bv.backgroundColor = colors.customBlack
        bv.layer.cornerRadius = 12
        bv.layer.shadowColor   = UIColor.black.cgColor
        bv.layer.shadowOffset  = CGSize(width: 0.5, height: 6.0)
        bv.layer.shadowRadius  = 12
        bv.layer.shadowOpacity = 0.8
        //        bv.clipsToBounds       = false
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    lazy var titleLabel: UILabel = {
        let nl = UILabel()
        nl.adjustsFontSizeToFitWidth = true
        nl.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        nl.textAlignment = .right
        nl.backgroundColor = .clear
        nl.textColor = colors.customWhite
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    lazy var mainView: UIView = {
        let mv = UIView()
        mv.backgroundColor = colors.customWhite
        mv.layer.cornerRadius = 12
        mv.layer.shadowColor   = UIColor.black.cgColor
        mv.layer.shadowOffset  = CGSize(width: 0.5, height: 6.0)
        mv.layer.shadowRadius  = 12
        mv.layer.shadowOpacity = 0.8
        mv.clipsToBounds       = false
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.text = "afdsafvsfvsfs"
        tv.isEditable = true
        tv.textColor = colors.customBlack
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var backBtn: UIButton = {
        let ab = UIButton()
        ab.backgroundColor = colors.customWhite
        ab.setTitle("<", for: .normal)
        ab.setTitleColor(colors.customBlack, for: .normal)
        ab.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 13)
        ab.layer.cornerRadius = 20
        ab.layer.shadowColor   = UIColor.black.cgColor
        ab.layer.shadowOffset  = CGSize(width: 0.1, height: 3)
        ab.layer.shadowRadius  = 10
        ab.layer.shadowOpacity = 0.8
        ab.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        ab.translatesAutoresizingMaskIntoConstraints = false
        return ab
    }()
    
    
    
    
    //MARK: - Inits
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
        view.backgroundColor = colors.customWhite
        view.clipsToBounds = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if let UpdatedDescription = textView.text {
            CoreDataManager.shared.updateList(list: self.cellData, description: UpdatedDescription, isDone: self.cellData.done)
        }
    }
    
    //MARK: - Methods
    
    
    @objc func backToMain() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraint() {
        view.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(backBtn)
        view.addSubview(textView)
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor , constant: -10)])
        
        NSLayoutConstraint.activate([
            backBtn.heightAnchor.constraint(equalToConstant: 40),
            backBtn.widthAnchor.constraint(equalToConstant: 40),
            backBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            backBtn.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 18)])
        
        NSLayoutConstraint.activate([
            titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -14),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.8),
            titleLabel.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor)])
    }
    
    
}

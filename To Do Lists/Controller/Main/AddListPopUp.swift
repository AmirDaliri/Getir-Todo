//
//  AddListPopUp.swift
//  To Do Lists
//
//  Created by Amir Daliri on 5/17/20.
//  Copyright © 2020 Amir Daliri. All rights reserved.
//

import UIKit

class AddListPopUp: UIView {
    
    
    
    //MARK: - Properties
    
    weak var informationDelegate: NewListInformation!
    
    
    let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 24
        cv.clipsToBounds = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.adjustsFontSizeToFitWidth = true
        tl.textAlignment = .left
        tl.text = "Title:"
        tl.textColor = .black
        tl.font = UIFont(name: "Futura-CondensedExtraBold", size: 14)
        tl.backgroundColor = .clear
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let titletextField: UITextField = {
        let tl = UITextField()
        tl.backgroundColor = .clear
        tl.layer.cornerRadius = 8
        tl.layer.borderWidth = 1
        tl.layer.borderColor = colors.customBlack.cgColor
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let descriptionLabel: UILabel = {
        let tl = UILabel()
        tl.adjustsFontSizeToFitWidth = true
        tl.textAlignment = .left
        tl.text = "Description:"
        tl.textColor = .black
        tl.font = UIFont(name: "Futura-CondensedExtraBold", size: 16)
        tl.backgroundColor = .clear
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let descriptionField: UITextField = {
        let tl = UITextField()
        tl.backgroundColor = .clear
        tl.layer.cornerRadius = 8
        tl.layer.borderWidth = 1
        tl.layer.borderColor = colors.customBlack.cgColor
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let addButton: UIButton = {
        let tl = UIButton()
        tl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        tl.setTitle("Add", for: .normal)
        tl.setTitleColor(colors.customWhite, for: .normal)
        tl.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 13)
        tl.layer.cornerRadius = 8
        tl.layer.shadowColor   = UIColor.black.cgColor
        tl.layer.shadowOffset  = CGSize(width: 0.1, height: 3)
        tl.layer.shadowRadius  = 10
        tl.layer.shadowOpacity = 0.8
        tl.backgroundColor = colors.customBlack
        tl.titleLabel?.textAlignment = .center
        tl.addTarget(self, action: #selector(handleAddNewObj), for: .touchUpInside)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    
    @objc fileprivate func handleAddNewObj() {
        if let titleName = titletextField.text {
            guard let descriptionText = descriptionField.text else {
                informationDelegate.addBtnTaped(title: titleName, description: nil)
                self.animateOut()
                return
            }
            informationDelegate.addBtnTaped(title: titleName, description: descriptionText)
            animateOut()
        }
    }
    
    @objc fileprivate func animateOut() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height )
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc fileprivate func animateIn() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height )
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.transform = .identity
            self.alpha = 1
        })
    }
    
    
    
    fileprivate func setConstraint() {
        
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.frame = UIScreen.main.bounds
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)])
        
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.24),
            titleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12)])
        
        containerView.addSubview(titletextField)
        NSLayoutConstraint.activate([
            titletextField.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 4),
            titletextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12),
            titletextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.16),
            titletextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12)])
        
        containerView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.14),
            descriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8)])
        
        containerView.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.38),
            addButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.14),
            addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6)])
        
        containerView.addSubview(descriptionField)
        NSLayoutConstraint.activate([
            descriptionField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            descriptionField.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -6),
            descriptionField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            descriptionField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -12)])
        
        //adding collection view and seting constraint up!
        
        
        animateIn()
    }
}



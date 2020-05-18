//
//  MainClCell.swift
//  To Do Lists
//
//  Created by Amir Daliri on 5/17/20.
//  Copyright © 2020 Amir Daliri. All rights reserved.
//

import UIKit


class MainClCell: UICollectionViewCell {
    
    //MARK: - Propersties
    
    
    var cellData: List? {
        didSet {
            if let existedData = cellData {
                titleLabel.text = existedData.title
                descriptionLabel.text = existedData.descriptionText
                if existedData.done == true {
                    situationImageView.image = UIImage(named: "done")
                    completedLabel.alpha = 1
                } else {
                    situationImageView.image = UIImage(named: "undone")
                    completedLabel.alpha = 0
                }
            }
            
        }
    }
    
    weak var updatelistDelegate: UpdateListInformation?
    
    lazy var situationImageView: UIImageView = {
        let siv = UIImageView()
//        siv.image = UIImage(named: "undone")
        siv.contentMode = .scaleAspectFit
        siv.backgroundColor = .clear
        siv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateList)))
        siv.isUserInteractionEnabled = true
        siv.translatesAutoresizingMaskIntoConstraints = false
        return siv
    }()
    
    let completedLabel: UILabel = {
        let nl = UILabel()
        nl.adjustsFontSizeToFitWidth = true
        nl.text = "Done!"
        nl.alpha = 0
        nl.textAlignment = .center
        nl.textColor = colors.customWhite
        nl.font = UIFont(name: "Futura-CondensedExtraBold", size: 9)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    let sepView: UIView = {
        let sv = UIView()
        sv.backgroundColor = colors.customWhite
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let titleLabel: UILabel = {
        let nl = UILabel()
        nl.adjustsFontSizeToFitWidth = true
        nl.font = UIFont(name: "Futura-CondensedExtraBold", size: 16)
        nl.textAlignment = .left
        nl.backgroundColor = .clear
        nl.textColor = colors.customWhite
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    
    let descriptionLabel: UILabel = {
        let hl = UILabel()
        hl.font = UIFont(name: "Futura-CondensedExtraBold", size: 9)
        hl.textAlignment = .left
        hl.numberOfLines = 2
        hl.textColor = colors.customWhite
        hl.backgroundColor = .clear
//        hl.backgroundColor = .clear
        hl.translatesAutoresizingMaskIntoConstraints = false
        return hl
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        backgroundColor = colors.customBlack
        layer.cornerRadius = 10
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.1, height: 3)
        layer.shadowOpacity = 0.8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    
    @objc func updateList() {
        if let existedData = cellData {
            if existedData.done == true {
                situationImageView.image = UIImage(named: "undone")
                UIView.animate(withDuration: 0.3) {
                    self.completedLabel.alpha = 0
                }
                self.updatelistDelegate?.updatelist(list: existedData, description: existedData.descriptionText , isDone: false)
                existedData.done = false
            } else if existedData.done == false {
                    self.situationImageView.image = UIImage(named: "done")
                    UIView.animate(withDuration: 0.3) {
                        self.completedLabel.alpha = 1
                    }
                self.updatelistDelegate?.updatelist(list: existedData, description: existedData.descriptionText , isDone: true)
                existedData.done = true
                }
        }
    }
    
    func setupConstraint() {
        
        addSubview(situationImageView)
        NSLayoutConstraint.activate([
            situationImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4),
            situationImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            situationImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            situationImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1)])
        
        addSubview(completedLabel)
        NSLayoutConstraint.activate([
            completedLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            completedLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12),
            completedLabel.topAnchor.constraint(equalTo: situationImageView.bottomAnchor, constant: 6),
            completedLabel.centerXAnchor.constraint(equalTo: situationImageView.centerXAnchor)])
        
        
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: situationImageView.leftAnchor, constant: -10)])
        
        addSubview(sepView)
        NSLayoutConstraint.activate([
            sepView.heightAnchor.constraint(equalToConstant: 1),
            sepView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            sepView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            sepView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1)])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: sepView.bottomAnchor, constant: 1),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            descriptionLabel.rightAnchor.constraint(equalTo: situationImageView.leftAnchor, constant: -10)])
    }
    
    
}

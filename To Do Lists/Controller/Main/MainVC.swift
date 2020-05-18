//
//  MainVC.swift
//  To Do Lists
//
//  Created by Amir Daliri on 5/17/20.
//  Copyright © 2020 Amir Daliri. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    
    //MARK: - Properties
    
    let collectionViewID = "clViewID"
    
    var lists: [List] = []
    
    
    
    lazy var headerView: UIView = {
        let bv = UIView()
        bv.backgroundColor = colors.customBlack
        bv.layer.cornerRadius = 12
        bv.layer.shadowColor   = UIColor.black.cgColor
        bv.layer.shadowOffset  = CGSize(width: 0.5, height: 6.0)
        bv.layer.shadowRadius  = 2
        bv.layer.shadowOpacity = 0.2
//        bv.clipsToBounds       = false
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    lazy var titleLabel: UILabel = {
        let nl = UILabel()
        nl.adjustsFontSizeToFitWidth = true
        
        nl.text = "My To Do List(s)"
        nl.font = UIFont(name: "Futura-CondensedExtraBold", size: 20)
        nl.textAlignment = .left
        nl.backgroundColor = .clear
        nl.textColor = colors.customWhite
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    lazy var backgroundImage: UIImageView = {
       let bImage = UIImageView()
       bImage.image = UIImage(named: "bvbv")
       bImage.contentMode = .scaleAspectFill
        
       bImage.translatesAutoresizingMaskIntoConstraints = false
       return bImage
    }()
    
    lazy var addButton: UIButton = {
        let tl = UIButton()
        tl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        tl.setTitle("Add", for: .normal)
        tl.setTitleColor(.black, for: .normal)
        tl.clipsToBounds = true
        
        tl.titleLabel?.textAlignment = .left
        //        tl.addTarget(self, action: #selector(backToMainSearchBar), for: .touchUpInside)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        let cl = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cl.backgroundColor = .clear
        cl.register(MainClCell.self, forCellWithReuseIdentifier: collectionViewID)
        cl.delegate = self
        cl.dataSource = self
        cl.translatesAutoresizingMaskIntoConstraints = false
        return cl
    }()
    
    
    lazy var addNewListBtn: UIButton = {
        let ab = UIButton()
        ab.backgroundColor = colors.customWhite
        ab.setTitle("Add", for: .normal)
        ab.setTitleColor(.black, for: .normal)
        ab.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 13)
        ab.layer.cornerRadius = 30
        ab.layer.shadowColor   = UIColor.black.cgColor
        ab.layer.shadowOffset  = CGSize(width: 0.1, height: 3)
        ab.layer.shadowRadius  = 10
        ab.layer.shadowOpacity = 0.8
        ab.addTarget(self, action: #selector(addNewList), for: .touchUpInside)
        ab.translatesAutoresizingMaskIntoConstraints = false
        return ab
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraint()
        lists = CoreDataManager.shared.fetchLists()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    //MARK: - Helper Functions
    
    @objc func addNewList() {
        let addNewlistPopUp = AddListPopUp()
        addNewlistPopUp.informationDelegate = self
        view.addSubview(addNewlistPopUp)
    }
    
    func configureUI() {
        view.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isHidden = true
      
    }
    
    func setupConstraint() {
        view.addSubview(backgroundImage)
        view.addSubview(collectionView)
        view.addSubview(headerView)
        view.addSubview(addNewListBtn)
        headerView.addSubview(titleLabel)
        
        
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor)])
        
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.68),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor , constant: -10)])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 18),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.8),
            titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor)])
        
        NSLayoutConstraint.activate([
            addNewListBtn.widthAnchor.constraint(equalToConstant: 60),
            addNewListBtn.heightAnchor.constraint(equalToConstant: 60),
            addNewListBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            addNewListBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12)])
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewID, for: indexPath) as! MainClCell
        let cellData = lists[indexPath.item]
        cell.updatelistDelegate = self
        cell.cellData = cellData
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        let listData = lists[indexPath.item]
        detailVC.cellData = listData
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.84, height: collectionView.frame.size.height * 0.08)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    }
    
}

extension MainVC: NewListInformation {
    func addBtnTaped(title: String, description: String?) {
        let newList = CoreDataManager.shared.createList(title: title, description: description)
        lists.append(newList)
        self.collectionView.reloadData()
    }
}

extension MainVC: UpdateListInformation {
    func updatelist(list: List, description: String?, isDone: Bool) {
        if let existedDes = description {
            CoreDataManager.shared.updateList(list: list, description: existedDes, isDone: isDone)
            self.collectionView.reloadData()
        } else {
            CoreDataManager.shared.updateList(list: list, description: "", isDone: isDone)
            self.collectionView.reloadData()
        }
        
    }
}

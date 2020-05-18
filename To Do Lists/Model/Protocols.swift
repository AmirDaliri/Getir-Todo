//
//  Protocols.swift
//  To Do Lists
//
//  Created by Amir Daliri on 5/17/20.
//  Copyright © 2020 Amir Daliri. All rights reserved.
//

import UIKit

protocol NewListInformation: class {
    func addBtnTaped(title: String, description: String?)
    
}

protocol UpdateListInformation: class {
    func updatelist(list: List, description: String?, isDone: Bool)
}

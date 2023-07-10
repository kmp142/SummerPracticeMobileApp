//
//  CalloriesTableViewCell.swift
//  Project
//
//  Created by Mac on 2023-07-08.
//

import UIKit

struct Property {
    let type: String
    let textField: UITextField
}

final class CalloriesTableViewCell : UITableViewCell {
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var numberOfCaloriesTextField: UITextField!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpForCalloriesTable (_ calories: Property) {
        caloriesLabel.text = calories.type
        numberOfCaloriesTextField = calories.textField
    }
}


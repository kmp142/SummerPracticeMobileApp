//
//  MealsTableViewCell.swift
//  Project
//
//  Created by Mac on 2023-07-06.
//

import UIKit

struct Meal {
    let name : String
    let image : UIImage
    let button : UIButton
}

final class MealsTableViewCell : UITableViewCell {
    
    @IBOutlet weak var nameOfMealTitleLabel : UILabel!
    @IBOutlet weak var imageOfMealImageView : UIImageView!
    @IBOutlet weak var addFoodButton : UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func addFoodButtonDidTap(_ sender: Any) {
        // настроен переход на экран AddFoodViewController через сториборды
    }
    
    func setUpForMealsTable (_ meal: Meal) {
        nameOfMealTitleLabel.text = meal.name
        imageOfMealImageView.image = meal.image
        addFoodButton = meal.button
    }
    
    
}

//
//  DiaryViewController.swift
//  Project
//
//  Created by Mac on 2023-07-06.
//

import UIKit
import Charts

final class DiaryViewController : UIViewController {
    
    @IBOutlet weak var mealsTableView : UITableView!
    
    private func createButton () -> UIButton {
        let button = UIButton()
        return button
    }
    
    private lazy var dataWithMeals : [Meal] = [
        Meal(name: "Завтрак", image: .checkmark, button: createButton()),
        Meal(name: "Обед", image: .checkmark, button: createButton()),
        Meal(name: "Ужин", image: .checkmark, button: createButton()),
        Meal(name: "Перекус", image: .checkmark, button: createButton())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealsTableView.dataSource = self
        mealsTableView.delegate = self
        mealsTableView.layer.cornerRadius = 10
    }
    
}

extension DiaryViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        59
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataWithMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mealsTableView.dequeueReusableCell(withIdentifier: "MealsTableViewCell") as? MealsTableViewCell else { return UITableViewCell() }
        
        let meal = dataWithMeals[indexPath.row]
        cell.setUpForMealsTable(meal)
        
        return cell
    }
}



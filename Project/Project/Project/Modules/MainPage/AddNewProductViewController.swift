//
//  AddNewProductViewController.swift
//  Project
//
//  Created by Mac on 2023-07-07.
//

import UIKit

final class AddNewProductViewController : UIViewController {
    
    @IBOutlet weak var writeDataAboutProductNavigationBar: UINavigationBar!
    @IBOutlet weak var writeNameLabel: UILabel!
    @IBOutlet weak var nameOfNewProductTextField: UITextField!
    @IBOutlet weak var caloriesTableView: UITableView!
    @IBOutlet weak var otherSpecificationsTableView: UITableView!
    @IBOutlet weak var addNewProductScrollView: UIScrollView!
    @IBOutlet weak var writeCalloriesLabel: UILabel!
    @IBOutlet weak var writeOtherLabel: UILabel!
    @IBOutlet weak var addNewProductButton: UIButton!
    weak var delegate: FindFoodViewControllerDelegate?
    
    private var product: Product = Product(name: "", calories: -1, fats: -1, proteins: -1, carbohydrates: -1, other: nil)
    
    private func tellAboutMistake () {
        writeDataAboutProductNavigationBar.topItem?.title = "Неверные данные"
        writeDataAboutProductNavigationBar.barTintColor = .systemRed
    }
    
    private func createTextField () -> UITextField {
        let textField = UITextField()
        return textField
    }
    
    private lazy var dataWithCaloriesProperties : [Property] = [
        Property(type: "Жиры", textField: createTextField()),
        Property(type: "Белки", textField: createTextField()),
        Property(type: "Углеводы", textField: createTextField())
    ]
    
    private lazy var dataWithOtherSpecificationsProperties : [Property] = [
        Property(type: "Содержание воды", textField: createTextField()),
        Property(type: "Пищевые волокна", textField: createTextField()),
        Property(type: "Витамин A", textField: createTextField()),
        Property(type: "Витамин B1", textField: createTextField()),
        Property(type: "Витамин B9", textField: createTextField()),
        Property(type: "Витамин B12", textField: createTextField()),
        Property(type: "Витамин D", textField: createTextField()),
        Property(type: "Витамин E", textField: createTextField()),
        Property(type: "Витамин C", textField: createTextField())
    ]
    
    private func setViewForTable (_ table: UITableView) {
        table.dataSource = self
        table.delegate = self
        table.layer.cornerRadius = 10
        table.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewForTable(caloriesTableView)
        setViewForTable(otherSpecificationsTableView)
        
        for cell in caloriesTableView.visibleCells {
            if let textFieldCell = cell as? CalloriesTableViewCell {
                textFieldCell.numberOfCaloriesTextField.delegate = self
            }
        }
        for cell in otherSpecificationsTableView.visibleCells {
            if let textFieldCell = cell as? OtherSpecificationsTableViewCell {
                textFieldCell.numberOfOtherSpecificationTextField.delegate = self
            }
        }
        
        // установка размеров элементов страницы для скроллинга
        writeDataAboutProductNavigationBar.frame = CGRect(x: 0, y: 0, width: addNewProductScrollView.frame.width, height: 44)
        writeNameLabel.frame = CGRect(x: 30, y: 60, width: 225, height: 30)
        nameOfNewProductTextField.frame = CGRect(x: 30, y: 100, width: 335, height: 34)
        writeCalloriesLabel.frame = CGRect(x: 30, y: 155, width: 225, height: 30)
        caloriesTableView.frame = CGRect(x: 30, y: 190, width: 335, height: 240)
        writeOtherLabel.frame = CGRect(x: 30, y: 450, width: 335, height: 30)
        otherSpecificationsTableView.frame = CGRect(x: 30, y: 485, width: 335, height: 720)
        addNewProductButton.frame = CGRect(x: 259, y: 1215, width: 110, height: 45)

        // размеры скроллера
        addNewProductScrollView.contentSize = CGSize(width: addNewProductScrollView.frame.width, height: 1315)
        
        // добавление элементов в скроллер
        addNewProductScrollView.addSubview(writeDataAboutProductNavigationBar)
        addNewProductScrollView.addSubview(writeNameLabel)
        addNewProductScrollView.addSubview(nameOfNewProductTextField)
        addNewProductScrollView.addSubview(writeCalloriesLabel)
        
        addNewProductScrollView.addSubview(caloriesTableView)
        addNewProductScrollView.addSubview(otherSpecificationsTableView)
        addNewProductScrollView.addSubview(addNewProductButton)
    }
}

extension AddNewProductViewController : UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    // количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case caloriesTableView:
            return dataWithCaloriesProperties.count
        case otherSpecificationsTableView:
            return dataWithOtherSpecificationsProperties.count
        default:
            return 0
        }
    }
    
    // наполнение ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case caloriesTableView: do {
            
            guard let cell = caloriesTableView.dequeueReusableCell(withIdentifier: "CalloriesTableViewCell") as? CalloriesTableViewCell else { return UITableViewCell() }
            
            let property = dataWithCaloriesProperties[indexPath.row]
            cell.setUpForCalloriesTable(property)
            
            cell.numberOfCaloriesTextField.tag = indexPath.row
            cell.numberOfCaloriesTextField.delegate = self
            
            return cell
        }
        case otherSpecificationsTableView: do {
            
            guard let cell = otherSpecificationsTableView.dequeueReusableCell(withIdentifier: "OtherSpecificationsTableViewCell") as? OtherSpecificationsTableViewCell else { return UITableViewCell() }
            
            let property = dataWithOtherSpecificationsProperties[indexPath.row]
            cell.setUpForOtherSpecificationsTable(property)
            
            cell.numberOfOtherSpecificationTextField.tag = indexPath.row + 3
            cell.numberOfOtherSpecificationTextField.delegate = self
            
            return cell
        }
        default:
            return UITableViewCell()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        valueChanged(textField)
    }
}

extension AddNewProductViewController {
    
    @IBAction func addNewProductButton(_ sender: Any){
        
        guard let name = nameOfNewProductTextField.text, !name.isEmpty else {
            tellAboutMistake()
            return
        }
        product.name = name
        
        /*
        for cell in caloriesTableView.visibleCells {
            if let textFieldCell = cell as? CalloriesTableViewCell {
                textFieldDidChange(caloryCell: textFieldCell)
            }
        }
        
        for cell in otherSpecificationsTableView.visibleCells {
            if let textFieldCell = cell as? OtherSpecificationsTableViewCell {
                textFieldDidChange(otherCell: textFieldCell)
            }
        }

        if let visibleIndexPath1 = caloriesTableView.indexPathsForVisibleRows {
            for indexPath in visibleIndexPath1 {
                guard let cell = caloriesTableView.cellForRow(at: indexPath) as? CalloriesTableViewCell else { return }
                textFieldDidChange(caloryCell: cell)
            }
        }
        
        if let visibleIndexPath2 = otherSpecificationsTableView.indexPathsForVisibleRows {
            for indexPath in visibleIndexPath2 {
                guard let cell = otherSpecificationsTableView.cellForRow(at: indexPath) as? OtherSpecificationsTableViewCell else { return }
                textFieldDidChange(otherCell: cell)
            }
        }
        */
        delegate?.update(newProduct: product)
        dismiss(animated: true, completion: nil)
    }
    
    func checkValue (_ string: String?) -> Bool {
        if fromStringToDouble(string) != nil { return true }
        else { return false }
    }
    
    func fromStringToDouble (_ string: String?) -> Double? {
        if let doubleValue = Double(string ?? "-1"), doubleValue >= 0 {
            return doubleValue
        } else {
            return nil
        }
    }
    
    func valueChanged(_ textField: UITextField){
        let text = textField.text
        if checkValue(text) {
            switch textField.tag {
            case 0:
                product.fats = fromStringToDouble(text) ?? -1
            case 1:
                product.proteins = fromStringToDouble(text) ?? -1
            case 2:
                product.carbohydrates = fromStringToDouble(text) ?? -1
            case 3...:
                product.other?[text!] = fromStringToDouble(text!)
            default:
                tellAboutMistake()
            }
        }
        
    }
    
    /*
    func textFieldDidChange(otherCell: OtherSpecificationsTableViewCell) {
        let name = otherCell.otherSpecificationLabel.text
        let text = otherCell.numberOfOtherSpecificationTextField.text
        if text != "" {
            if checkValue(text!) {
                product.other?[name!] = fromStringToDouble(text!)
            }
        }
        else { tellAboutMistake() }
    }
    
    func textFieldDidChange(caloryCell: CalloriesTableViewCell) {
        let name = caloryCell.caloriesLabel.text
        let text = caloryCell.numberOfCaloriesTextField.text
        if text != "" && text != nil {
            switch name {
            case "Жиры":
                if checkValue(text!) {
                    product.fats = fromStringToDouble(text!) ?? -1
                }
            case "Белки":
                if checkValue(text!) {
                    product.proteins = fromStringToDouble(text!) ?? -1
                }
            case "Углеводы":
                if checkValue(text!) {
                    product.carbohydrates = fromStringToDouble(text!) ?? -1
                }
            default:
                return
            }
        }
        else { tellAboutMistake() }
    }
    */
}

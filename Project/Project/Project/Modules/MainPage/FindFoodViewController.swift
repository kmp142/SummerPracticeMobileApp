//
//  FindFoodViewController.swift
//  Project
//
//  Created by Mac on 2023-07-06.
//

import UIKit

final class FindFoodViewController : UIViewController {
    
    @IBOutlet weak var productsSearchBar: UISearchBar!
    @IBOutlet weak var findProdactTableView: UITableView!
    
    @IBAction func addNewProductButton(_ sender: Any) {
        
    }
    
    private var isSearching = false
    private var filteredSearchedData: [Product] = []
    private var dataWithProducts: [Product] = [
        Product(name: "Яблоко", calories: 47, fats: 0.4, proteins: 0.4, carbohydrates: 9.8, other: nil),
        Product(name: "Яйцо куриное", calories: 157, fats: 11.5, proteins: 12.7, carbohydrates: 0.7, other: ["Содержание воды": 74]),
        Product(name: "Куриная грудка", calories: 113, fats: 1.9, proteins: 23.6, carbohydrates: 0.4, other: nil),
        Product(name: "Гречневая крупа", calories: 308, fats: 3.3, proteins: 12.6, carbohydrates: 57.1, other: nil),
        Product(name: "Молоко", calories: 60, fats: 3.2, proteins: 2.9, carbohydrates: 4.7, other: nil),
        Product(name: "Биг хит из 'Вкусно и точка'", calories: 522, fats: 27, proteins: 27, carbohydrates: 42, other: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findProdactTableView.dataSource = self
        findProdactTableView.delegate = self
        productsSearchBar.delegate = self
    }
}

extension FindFoodViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSearchedData.removeAll()
        
        guard searchText != "" || searchText != " " else { return }
        
        for item in dataWithProducts {
            let text = searchText.lowercased()
            let isArrayContain = item.name.lowercased().range(of: text)
                    
            if isArrayContain != nil { filteredSearchedData.append(item) }
        }
        
        if searchBar.text == "" {
            isSearching = false
            findProdactTableView.reloadData()
        }
        else {
            isSearching = true
            filteredSearchedData = filteredSearchedData.filter({$0.name.lowercased().contains(searchBar.text?.lowercased() ?? "")})
            findProdactTableView.reloadData()
        }
    }
}

extension FindFoodViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return filteredSearchedData.count }
        else { return dataWithProducts.count }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = findProdactTableView.dequeueReusableCell(withIdentifier: "FindProductTableViewCell") as? FindProductTableViewCell else { return UITableViewCell() }

        if isSearching { cell.textLabel?.text = filteredSearchedData[indexPath.row].name }
        else { cell.textLabel?.text = dataWithProducts[indexPath.row].name }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let name = dataWithProducts[indexPath.row].name
        // остальные
        
        //guard let addFoodViewController = storyboard?.instantiateViewController(withIdentifier: "AddFoodViewController") as? AddFoodViewController else { return }
        
        //addFoodViewController.loadViewIfNeeded()
        //addFoodViewController.setPersonalInfo(name: name, number: number, photo: photo)
    }
}

extension FindFoodViewController : FindFoodViewControllerDelegate {
    // подписка на делегат
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddNewProductViewController else { return }
        destination.delegate = self
    }
    
    //функция обновления даты, при добавлении нового контакта
    func update(newProduct: Product) {
        dataWithProducts.append(newProduct)
        findProdactTableView.reloadData()
    }
}

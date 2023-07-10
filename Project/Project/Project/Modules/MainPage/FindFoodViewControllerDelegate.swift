//
//  FindFoodViewControllerDelegate.swift
//  Project
//
//  Created by Mac on 2023-07-10.
//

import Foundation

protocol FindFoodViewControllerDelegate : AnyObject {
    func update(newProduct: Product)
}

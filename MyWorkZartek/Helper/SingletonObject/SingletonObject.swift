//
//  SingletonObject.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 28/10/21.
//

import Foundation


class SingletonObject {
    
    static let shared = SingletonObject()
    private init() {}

    var categoryDish: [CategoryDish]?

    func resetData() {
        categoryDish = nil
    }
}

extension SingletonObject: JsonGenerating {

    func getCategoryDishElement() -> [CategoryDish]? {
        return categoryDish
    }

}

protocol JsonGenerating {
    /// JSON, being sent to backend
    func getCategoryDishElement() -> [CategoryDish]?
}

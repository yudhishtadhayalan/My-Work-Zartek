//
//  ModelCategory.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 27/10/21.
//


import Foundation

// MARK: - ModelCategoryElement
class ModelCategoryElement: Codable {
    var restaurantID, restaurantName: String?
    var restaurantImage: String?
    var tableID, tableName, branchName: String?
    var nexturl: String?
    var tableMenuList: [TableMenuList]?

    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case restaurantName = "restaurant_name"
        case restaurantImage = "restaurant_image"
        case tableID = "table_id"
        case tableName = "table_name"
        case branchName = "branch_name"
        case nexturl
        case tableMenuList = "table_menu_list"
    }
}

// MARK: - TableMenuList
struct TableMenuList: Codable {
    var menuCategory, menuCategoryID: String?
    var menuCategoryImage: String?
    var nexturl: String?
    var categoryDishes: [CategoryDish]?

    enum CodingKeys: String, CodingKey {
        case menuCategory = "menu_category"
        case menuCategoryID = "menu_category_id"
        case menuCategoryImage = "menu_category_image"
        case nexturl
        case categoryDishes = "category_dishes"
    }
}

// MARK: - AddonCat
struct AddonCat: Codable {
    var addonCategory, addonCategoryID: String?
    var addonSelection: Int?
    var nexturl: String?
    var addons: [CategoryDish]?

    enum CodingKeys: String, CodingKey {
        case addonCategory = "addon_category"
        case addonCategoryID = "addon_category_id"
        case addonSelection = "addon_selection"
        case nexturl, addons
    }
}

// MARK: - CategoryDish
struct CategoryDish: Codable {
    var dishID, dishName: String?
    var dishPrice: Double?
    var dishImage: String?
    var dishCurrency: DishCurrency?
    var dishCalories: Int?
    var dishDescription: String?
    var dishAvailability: Bool?
    var dishType: Int?
    var nexturl: String?
    var addonCat: [AddonCat]?
    var numberOfItems: Int?

    enum CodingKeys: String, CodingKey {
        case dishID = "dish_id"
        case dishName = "dish_name"
        case dishPrice = "dish_price"
        case dishImage = "dish_image"
        case dishCurrency = "dish_currency"
        case dishCalories = "dish_calories"
        case dishDescription = "dish_description"
        case dishAvailability = "dish_Availability"
        case dishType = "dish_Type"
        case nexturl, addonCat
        case numberOfItems
    }
    
}

enum DishCurrency: String, Codable {
    case sar = "SAR"
}

typealias ModelCategory = [ModelCategoryElement]

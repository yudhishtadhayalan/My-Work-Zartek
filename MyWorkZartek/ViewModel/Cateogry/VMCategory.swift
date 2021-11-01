//
//  VMCategory.swift
//  MyWorkZartek
//
//  Created by Yudhishta Dhayalan on 27/10/21.
//

import Foundation


// MARK: - Category
protocol DelegateCategory: AnyObject {
    func successCategoryObj(resObj: [ModelCategoryElement])
    func errorCategoryObj(strError: String)
}


class VMCategory {
    
    static weak var delegateCategory: DelegateCategory?
    
    //MARK:- Category
    
    static func getCategoryDetails() {
        
        getttWebService(str_methodName: EnumMethodName.API_Category.rawValue) { resultObj in
                    
            do{
                let data_ = try JSONSerialization.data(withJSONObject:resultObj , options: .prettyPrinted)
                let CategoryObj = try? JSONDecoder().decode([ModelCategoryElement].self, from: data_)
                
                guard CategoryObj != nil else {
                    delegateCategory?.errorCategoryObj(strError: EnumAlertMessage.jsonError.rawValue)
                    return
                }
                                
                DispatchQueue.main.async {
                    delegateCategory?.successCategoryObj(resObj: CategoryObj!)
                }
                
            }catch(let err_){
                
                let data_err = try? JSONSerialization.data(withJSONObject:resultObj , options: .prettyPrinted)
                
                guard (data_err != nil) else {
                    delegateCategory?.errorCategoryObj(strError: err_.localizedDescription)
                    return
                }
                
            }
            
        }
    }
}





// Common Error Message for API

// MARK: - APICategoryErrorObj
struct APICategoryErrorObj: Codable {
    var statusCode: Int?
    var error, message, responseType: String?
}












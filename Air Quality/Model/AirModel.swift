//
//  AirModel.swift
//  Air Quality
//
//  Created by Aleksandr Khalupa on 19.01.2021.
//

import UIKit

struct AirModel {
    let idexAir: Int
    let cityName: String
    
    var getImage: UIImage{
        switch idexAir {
        case 0...50:
            return #imageLiteral(resourceName: "0-50")
            
        case 51...100:
            return #imageLiteral(resourceName: "51-100")
            
        case 101...150:
            return #imageLiteral(resourceName: "101-150")
            
        case 151...200:
            return #imageLiteral(resourceName: "151-200")
            
        case 201...300:
            return #imageLiteral(resourceName: "201-300")
            
        case 301...500:
            return #imageLiteral(resourceName: "300-500")
       
        default:
            return #imageLiteral(resourceName: "300-500")
        }
    }
}

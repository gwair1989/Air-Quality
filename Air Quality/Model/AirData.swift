//
//  AirData.swift
//  Air Quality
//
//  Created by Aleksandr Khalupa on 19.01.2021.
//

import Foundation
typealias myPersonalCodable = Decodable & Encodable
struct AirData:myPersonalCodable {
    
    let timezone: String
    let city_name: String
    let data:[JsonData]
}

struct JsonData:myPersonalCodable {
    let aqi: Int
}

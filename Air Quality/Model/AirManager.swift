//
//  AirManager.swift
//  Air Quality
//
//  Created by Aleksandr Khalupa on 15.01.2021.
//

import Foundation

protocol AirManagerDelegate {
    func getAirData(air:AirModel)
    func getError(serverError:String)
}

class AirManager {
    
    var myDelegate: AirManagerDelegate?
    let airURL = "https://api.weatherbit.io/v2.0/current/airquality?key=\(K.keyAPI)"
    

    func requestAir(long:Double, lat:Double){
        let urlString = "\(airURL)&lon=\(long)&lat=\(lat)"
        fetchAir(urlString: urlString)
        print(urlString)
    }
    
    func requestAir (sityName: String){
        let urlString = "\(airURL)&city=\(sityName)"
        fetchAir(urlString: urlString)
    }
    
    func fetchAir (urlString: String){
        guard let airURL = URL(string: urlString) else {return}
        let urlSesion = URLSession(configuration: .default)
        let dataTask = urlSesion.dataTask(with: airURL) { (data, urlResponse, error) in
            if error != nil {return}
            guard let receivedData = data else {return}
            guard let airMod = self.hendlingJson(recData: receivedData) else{return}
            DispatchQueue.main.async {
                self.myDelegate?.getAirData(air: airMod)
            }
        }
        dataTask.resume()
    }
    
    func hendlingJson(recData: Data) -> AirModel?{
        
        let decoder = JSONDecoder()
        do {
           let decodeData = try decoder.decode(AirData.self, from: recData)
            let airModel = AirModel(idexAir: decodeData.data[0].aqi, cityName: decodeData.city_name)
            return airModel
        } catch  {
            DispatchQueue.main.async {
                self.myDelegate?.getError(serverError: error.localizedDescription)
            }
            return nil
        }
    }
}

extension AirManagerDelegate{
    func getError(serverError:String){}
}

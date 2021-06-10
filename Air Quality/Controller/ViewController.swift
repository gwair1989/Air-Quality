//
//  ViewController.swift
//  Air Quality
//
//  Created by Aleksandr Khalupa on 06.01.2021.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, AirManagerDelegate, CLLocationManagerDelegate {
    
    
    //    MARK: - IBOUTLET PROPERTIS
    @IBOutlet weak var labelYourPlace: UILabel!
    @IBOutlet weak var labelAirIndex: UILabel!
    @IBOutlet weak var textFieldEnterCity: UITextField!
    @IBOutlet weak var faceImage: UIImageView!
    
    //    MARK: - MY PROPERTIS
    let airManager = AirManager()
    let locationManager = CLLocationManager()
    
    //    MARK: - SYCLES MATHOTDS
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldEnterCity.delegate = self
        airManager.myDelegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        print(airManager.airURL)
    }
    
    //    MARK: - ACTION METODS
    @IBAction func pressedSearch(_ sender: UIButton) {
        
        let text = textFieldEnterCity.text!
        if text == ""{
            textFieldEnterCity.placeholder = "Enter city!!!"
            return
        }
        textFieldEnterCity.endEditing(true)
        return
    }
    
    
    @IBAction func pressedLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    //    MARK: - DELEGATS TEXTFIELD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            print(textField.text!)
            textField.endEditing(true)
            return true
        }
        textField.placeholder = "Enter city!!!"
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        airManager.requestAir(sityName: textField.text!)
        textField.text = ""
    }
    
    //    MARK: - DELEGATS AIRMANAGER
    func getAirData(air: AirModel) {
        labelAirIndex.text = "\(air.idexAir)"
        labelYourPlace.text = air.cityName
        faceImage.image = air.getImage
        print(air.cityName)
        print(air.idexAir)
    }
    
    func getError(serverError: String) {
        labelYourPlace.text = serverError
    }
    
    
    //    MARK: - DELEGATS LOCATIONS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = locations.last?.coordinate{
            let latidude = coordinates.latitude
            let longitude = coordinates.longitude
            airManager.requestAir(long: longitude, lat: latidude)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

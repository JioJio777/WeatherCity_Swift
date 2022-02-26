//
//  ViewController.swift
//  weatherPractice
//
//  Created by 郑子炯 on 2022/2/23.
//

import UIKit

import CoreLocation

import Alamofire

import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate,QuiryViewControllerDelegate,CityTableControllerDelegate{
    @IBOutlet weak var tempImageView: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var Text: UILabel!
    var weather = Weather()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()//请求获得用户许可
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lon = locations[0].coordinate.longitude
        let lat = locations[0].coordinate.latitude
        AF.request("https://devapi.qweather.com/v7/weather/now?&location=\(lon),\(lat)&key=975db63e3fc24f1191e79bee50433681").responseJSON{response in
            if let data = response.value{
                let jsonData = JSON(data)
                self.weather.temp = jsonData["now","temp"].stringValue
                self.weather.icon = jsonData["now","icon"].stringValue
                self.weather.feelsLike = jsonData["now","feelsLike"].stringValue
                self.weather.text = jsonData["now","text"].stringValue
                self.weather.wind360 = jsonData["now","wind360"].stringValue
                self.weather.windDir = jsonData["now","windDir"].stringValue
                self.weather.windScale = jsonData["now","windScale"].stringValue
                self.weather.humidity = jsonData["now","humidity"].stringValue
                self.weather.cloud = jsonData["now","cloud"].stringValue

                self.tempImageView.text = "\(self.weather.temp)˚"
                self.iconImageView.image = UIImage(named: "\(self.weather.icon)")
                self.Text.text = self.weather.text
                
            }
        }
        AF.request("https://geoapi.qweather.com/v2/city/lookup?location=\(lon),\(lat)&key=975db63e3fc24f1191e79bee50433681").responseJSON{response in
            if let data = response.value{
                let jsonData = JSON(data)
                self.weather.city = jsonData["location",0,"adm2"].stringValue
                self.cityLabel.text = "\(self.weather.city)"
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "QuiryWeather"{
            let vc = segue.destination as! QuiryViewController
            vc.cityLabel =  weather.city
            vc.weather.icon = weather.icon
            vc.delegate = self
        }
        if segue.identifier == "toCityTable"{
            let vc = segue.destination as! MyCityTableViewController
            vc.weather.icon = weather.icon
            vc.delegate = self
        }
        if segue.identifier == "toDetail"{
            let vc = segue.destination as! DtailWeatherViewController
            vc.weather.feelsLike = weather.feelsLike
            vc.weather.text = weather.text
            vc.weather.wind360 = weather.wind360
            vc.weather.windDir = weather.windDir
            vc.weather.windScale = weather.windScale
            vc.weather.humidity = weather.humidity
            vc.weather.cloud = weather.cloud
            vc.weather.temp = weather.temp
            vc.weather.icon = weather.icon

        }
        
    }
    func changeCity(city: String){
        let parameters = ["location": city,"key": "975db63e3fc24f1191e79bee50433681"]
        AF.request("https://geoapi.qweather.com/v2/city/lookup",parameters:parameters).responseJSON{response in
            if let data = response.value{
                let jsonData = JSON(data)
                self.weather.city = jsonData["location",0,"name"].stringValue
                self.cityLabel.text = "\(self.weather.city)"
                
                AF.request("https://devapi.qweather.com/v7/weather/now?&location=\(jsonData["location",0,"id"])&key=975db63e3fc24f1191e79bee50433681").responseJSON{response in
                    if let data = response.value{
                        let jsonData2 = JSON(data)
                        self.weather.temp = jsonData2["now","temp"].stringValue
                        self.weather.icon = jsonData2["now","icon"].stringValue
                        self.tempImageView.text = "\(self.weather.temp)˚"
                        self.iconImageView.image = UIImage(named: "\(self.weather.icon)")
                        
                    }
                }
            }
        }
    }
    func changeCityName(city: String) {
        let parameters = ["location": city,"key": "975db63e3fc24f1191e79bee50433681"]
        AF.request("https://geoapi.qweather.com/v2/city/lookup",parameters:parameters).responseJSON{response in
            if let data = response.value{
                let jsonData = JSON(data)
                self.weather.city = jsonData["location",0,"name"].stringValue
                self.cityLabel.text = "\(self.weather.city)"
                
                AF.request("https://devapi.qweather.com/v7/weather/now?&location=\(jsonData["location",0,"id"])&key=975db63e3fc24f1191e79bee50433681").responseJSON{response in
                    if let data = response.value{
                        let jsonData2 = JSON(data)
                        self.weather.temp = jsonData2["now","temp"].stringValue
                        self.weather.icon = jsonData2["now","icon"].stringValue
                        self.tempImageView.text = "\(self.weather.temp)˚"
                        self.iconImageView.image = UIImage(named: "\(self.weather.icon)")
                        
                    }
                }
            }
        }
    }
}


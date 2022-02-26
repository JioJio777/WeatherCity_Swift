//
//  DtailWeatherViewController.swift
//  weatherPractice
//
//  Created by 郑子炯 on 2022/2/26.
//

import UIKit

class DtailWeatherViewController: UIViewController {

    var weather = Weather()
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var win360: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var winDir: UILabel!
    @IBOutlet weak var winScale: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var cloud: UILabel!
    @IBOutlet weak var imge: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        temp.text = weather.temp
        text.text = weather.text
        feelsLike.text = weather.feelsLike
        win360.text = weather.wind360
        winDir.text = weather.windDir
        winScale.text = weather.windScale
        humidity.text = weather.humidity
        cloud.text = weather.cloud
        imge.image = UIImage(named: weather.icon)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

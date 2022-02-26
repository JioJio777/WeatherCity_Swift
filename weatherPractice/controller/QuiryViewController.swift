//
//  QuiryViewController.swift
//  weatherPractice
//
//  Created by 郑子炯 on 2022/2/25.
//

import UIKit
protocol QuiryViewControllerDelegate {
    func changeCityName(city: String)
}
class QuiryViewController: UIViewController {
    @IBOutlet weak var cityTextFeild: UITextField!
    var weather = Weather()
    var cityLabel = ""
    var delegate : QuiryViewControllerDelegate?
    
    @IBOutlet weak var imge: UIImageView!
    @IBOutlet weak var curCity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        curCity.text = cityLabel
        imge.image = UIImage(named: weather.icon)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func searchWeather(_ sender: Any) {
        dismiss(animated: true)
        delegate?.changeCityName(city: cityTextFeild.text!)
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

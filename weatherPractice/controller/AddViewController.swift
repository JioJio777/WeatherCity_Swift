//
//  AddViewController.swift
//  weatherPractice
//
//  Created by 郑子炯 on 2022/2/26.
//

import UIKit
protocol addCityControllerDelegate {
    func addCity(city: String)
}
class AddViewController: UIViewController {
    var delegate : addCityControllerDelegate?
    @IBOutlet weak var curCity: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var imge: UIImageView!
    var weather = Weather()
    @IBAction func backToTable(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func addCity(_ sender: Any) {
        dismiss(animated: true)
        delegate?.addCity(city: cityTextField.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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

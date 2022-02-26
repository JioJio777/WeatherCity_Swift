//
//  MyCityTableViewController.swift
//  weatherPractice
//
//  Created by 郑子炯 on 2022/2/25.
//

import UIKit
protocol CityTableControllerDelegate {
    func changeCity(city: String)
}
class MyCityTableViewController: UITableViewController, addCityControllerDelegate {
    var collectCity = [oneCity(cityname: "北京")]
    var delegate : CityTableControllerDelegate?
    var weather = Weather()
    @IBAction func backToMain(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let savedData = UserDefaults.standard.data(forKey: "CollectedCity"){
            if let collectCity = try? JSONDecoder().decode([oneCity].self, from: savedData){
                self.collectCity = collectCity
            }else{
                print("解码失败")
            }
                
        }
        
    }
    func addCity(city: String){
      //  collectCity.append(contentsOf: <#T##Sequence#>)
        collectCity.append(oneCity(cityname: city))
        do {
            let data = try JSONEncoder().encode(collectCity)
            UserDefaults.standard.set(data, forKey: "CollectedCity")

        } catch  {
            print("编码错误",error)
        }
        tableView.insertRows(at: [IndexPath(row: collectCity.count-1, section: 0)], with: .automatic)
    }
    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addCity"{
            let vc = segue.destination as! AddViewController
            vc.weather.icon = weather.icon
            vc.delegate = self
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collectCity.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityTableID", for: indexPath) as! cityTableViewCell
        cell.citytext.text = collectCity[indexPath.row].cityname
        cell.imge.image = UIImage(named: self.weather.icon)
        cell.checkWeather.addAction(UIAction(handler: { action in
            self.dismiss(animated: true)
            self.delegate?.changeCity(city: cell.citytext.text!)
        }), for: .touchUpInside)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            collectCity.remove(at: indexPath.row)
            do {
                let data = try JSONEncoder().encode(collectCity)
                UserDefaults.standard.set(data, forKey: "CollectedCity")

            } catch  {
                print("编码错误",error)
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    func saveCity(){
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

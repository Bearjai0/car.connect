//
//  svp_show.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 6/12/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class svp_show: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var provinceshow: UILabel!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    var id_svp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapData()
        
        let dataurl = "http://it.e-tech.ac.th/carconn/shop/showdata_svp.php?id_svp=\(id_svp)"
        let url = URL(string: dataurl)
        let data = try? Data(contentsOf: url!)
        let stringData = String.init(data: data!, encoding: String.Encoding.utf8)
        let userDefault = UserDefaults.standard
        userDefault.set(stringData!, forKey: "id_svp")
        let id_svpS:String = userDefault.object(forKey: "id_svp") as! String
        let param = "id_svp=\(id_svpS)"
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let data2 = param.data(using: .utf8)
        URLSession.shared.uploadTask(with: request, from: data2) { (data, response, error) in
            print(data!)
            if error != nil{
                print("error")
            }
            if data != nil{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                DispatchQueue.main.async {
                    self.name.text = json!["name_svp"] as? String
                    self.address.text = json!["address_svp"] as? String
                    self.time.text = json!["workingtime_svp"] as? String
                    self.tel.text = json!["tel_svp"] as? String
                    self.provinceshow.text = json!["province"] as? String
                }
            }
        }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapData()
    }
    
    func mapData() {
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/show_svp.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error")
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                
                var id_svp:[String] = []
                var name_svp:[String] = []
                var latitude:[String] = []
                var longitude:[String] = []
                
                for i in 0...json!.count-1{
                    if json![i] is [String:Any]{
                        let data:[String:Any] = json![i] as! [String : Any]
                        
                        id_svp.append((data["id_svp"] as! String))
                        name_svp.append((data["name_svp"] as! String))
                        latitude.append((data["latitude"] as! String))
                        longitude.append((data["longitude"] as! String))
                        
                        
                    }
                }
                print("nn",id_svp)
                self.userDefaults.set(id_svp, forKey: "id_svp")
                self.userDefaults.set(name_svp, forKey: "name_svp")
                self.userDefaults.set(latitude, forKey: "latitude")
                self.userDefaults.set(longitude, forKey: "longitude")
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "svp_service2"{
        let page = segue.destination as! svp_service
        page.id_svp2 = String((sender as! UIButton).tag)
        page.id_svp2 = id_svp
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
           navigationController?.popToRootViewController(animated: true)
       }
}

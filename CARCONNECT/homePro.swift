//
//  homePro.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 7/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class homePro: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var city: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userdefaults:UserDefaults = UserDefaults.standard
        let rhan:String = userdefaults.object(forKey: "id_svp") as! String
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/show_data.php")
        let param = "id_svp=\(rhan)"
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let data = param.data(using: .utf8)
        URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
            if error != nil{
                print("error")
            }
            if data != nil{
                var json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                print(json)
                DispatchQueue.main.async {
                    self.time.text = json!["workingtime_svp"] as? String
                    self.name.text = json!["name_svp"] as? String
                    self.tel.text = json!["tel_svp"] as? String
                    self.mail.text = json!["email_svp"] as? String
                    self.address.text = json!["address_svp"] as? String
                    self.city.text = json!["province"] as? String
                }
            }
        }.resume()
        
    }
    
    @IBAction func sendData(_ sender: Any) {
        let destinationVC = storyboard?.instantiateViewController(identifier: "editprovider") as? editprovider
        destinationVC?.svp_name = self.name.text!
        destinationVC?.svp_address = self.address.text!
        destinationVC?.svp_tel = self.tel.text!
        destinationVC?.svp_wt = self.time.text!
        destinationVC?.svp_mail = self.mail.text!
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @IBAction func exit(_ sender: UIButton) {
        let alert = UIAlertController(title: "แจ้งเตือน", message: "ออกจากระบบ", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
            let userDefault = UserDefaults.standard
            userDefault.set(nil, forKey: "id_svp")
            userDefault.set(nil, forKey: "login_status")
        let main = UIStoryboard(name: "Main", bundle: nil)
        let page = main.instantiateViewController(withIdentifier: "index")
            self.present(page,animated: true)
                              })
                              self.present(alert,animated: true)
                              alert.addAction(ok)
    }
    
}

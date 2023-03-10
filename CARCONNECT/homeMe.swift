//
//  homeMe.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 20/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class homeMe: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var tel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userdefaults:UserDefaults = UserDefaults.standard
            let SV_cus:String = userdefaults.object(forKey: "id_cus") as! String
            let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/show_dataCus.php")
            let param = "id_cus=\(SV_cus)"
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            let data = param.data(using: .utf8)
            URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
                if error != nil{
                    print("error")
                }
                print(data)
                if data != nil{
                    let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                    DispatchQueue.main.async {
            
                        self.name.text = json!["name_cus"] as? String
                        self.email.text = json!["email_cus"] as? String
                        self.tel.text = json!["tel_cus"] as? String
                    }
                }
            }.resume();
            
        }

    @IBAction func exit(_ sender: Any) {
        let alert = UIAlertController(title: "แจ้งเตือน", message: "ออกจากระบบ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                let userDefault = UserDefaults.standard
                userDefault.set(nil, forKey: "id_cus")
                userDefault.set(nil, forKey: "login_status")
            let main = UIStoryboard(name: "Main", bundle: nil)
            let page = main.instantiateViewController(withIdentifier: "index")
                self.present(page,animated: true)
                                  })
                                  self.present(alert,animated: true)
                                  alert.addAction(ok)
        
    }
    
}

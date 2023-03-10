//
//  editprovider.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 21/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class editprovider: UIViewController {
    
    var svp_name = ""
    var svp_address = ""
    var svp_tel = ""
    var svp_wt = ""
    var svp_mail = ""
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var mail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.tintColor = .black
        address.tintColor = .black
        tel.tintColor = .black
        time.tintColor = .black
        mail.tintColor = .black
        
        let userdefaults:UserDefaults = UserDefaults.standard
        let id_svp:String = userdefaults.object(forKey: "id_svp") as! String
        print("id svp = \(id_svp)" )
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/editProviderShow.php?id_svp=\(id_svp)")

        let param = "id_svp=\(id_svp)"
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let data = param.data(using: .utf8)
        URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
            print(data!)
            if error != nil{
                print("error")
            }
            if data != nil{
                print("data is = ")
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                print(json as Any)
                DispatchQueue.main.async {
                    self.name.text = json!["name_svp"] as? String
                    self.address.text = json!["address_svp"] as? String
                    self.tel.text = json!["tel_svp"] as? String
                    self.time.text = json!["workingtime_svp"] as? String
                    self.mail.text = json!["email_svp"] as? String
                }
            }
        }.resume()


        // Do any additional setup after loading the view.
    }
    

    @IBAction func ok(_ sender: Any) {
        let userdefaults:UserDefaults = UserDefaults.standard
        let id_svp:String = userdefaults.object(forKey: "id_svp") as! String
        let dataString = "http://it.e-tech.ac.th/carconn/shop/editprovider.php?name_svp=\(name.text!)&email_svp=\(mail.text!)&workingtime_svp=\(time.text!)&address_svp=\(address.text!)&tel_svp=\(tel.text!)&id_svp=\(id_svp)"
        let allowData = dataString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: allowData!)
        let data = try? Data(contentsOf: url!)
        let stringData = String.init(data: data!, encoding: String.Encoding.utf8)
        print(stringData!)
        if stringData=="Error"{
            let alert = UIAlertController(title: "แจ้งเตือน", message: "แก้ไขไม่สำเร็จ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
            self.present(alert,animated: true)
            alert.addAction(ok)
            }else{
                let alert = UIAlertController(title: "แจ้งเตือน", message: "แก้ไขสำเร็จ", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                })
               
                    alert.addAction(ok)
let getViewController = self.storyboard?.instantiateViewController(withIdentifier: "controPro") as! UITabBarController
getViewController.selectedIndex = 0
present(getViewController, animated: true)
            }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
        @IBAction func back(_ sender: UIButton) {
            navigationController?.popToRootViewController(animated: true)
        }
    }

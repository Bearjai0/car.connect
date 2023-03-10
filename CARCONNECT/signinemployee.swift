//
//  signinemployee.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 1/2/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class signinemployee: UIViewController {

        @IBOutlet weak var user: UITextField!
        @IBOutlet weak var pass: UITextField!
    var type_emp:String = ""
    var str = "false"
    
    var db_id = ""
    var emp_id = ""
        
        @IBAction func signIn(_ sender: Any) {
            if !checkForErrors(){
                let dataurl =  URL(string: "http://it.e-tech.ac.th/carconn/shop/loginemployee.php")
                
                let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/loginemployee.php?name_emp=\(user.text!)&password_emp=\(pass.text!)")
                
                let dats = "name_emp=\(user.text!)&password_emp=\(pass.text!)"
                
                var request = URLRequest(url: dataurl!)
                let data2 = dats.data(using: .utf8)
                
                request.httpMethod = "POST"
                
                URLSession.shared.uploadTask(with: request, from: data2) { (data, response, error) in
                    print(data!)
                    if error != nil{
                        self.str = "true"
                    }
                    if data != nil{
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                        print("json is :\(json)")
                        DispatchQueue.main.async {
                            self.type_emp = (json!["type_emp"] as? String)!
                            print(self.type_emp)
                            self.db_id = (json!["idsvp_frk"] as? String)!
                            self.emp_id = (json!["id_emp"] as? String)!

                        }
                    }
                }.resume()
                
            if str == "true"{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "เข้าสู่ระบบไม่สำเร็จ", preferredStyle: .alert)
                           let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                           self.present(alert,animated: true)
                           alert.addAction(ok)
            
        }else{
                
                
                
                
    //        let userDefault = UserDefaults.standard
    //               userDefault.set(str!, forKey: "id_svp")
                let alert = UIAlertController(title: "แจ้งเตือน", message: "เข้าสู่ระบบสำเร็จ", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                    
                    if self.type_emp == "พนักงาน"{
                let main = UIStoryboard(name: "Main", bundle: nil)
                let page = main.instantiateViewController(withIdentifier: "employee")
                    self.present(page,animated: true)
                        let userDefault = UserDefaults.standard
                        userDefault.set(self.emp_id, forKey: "id_emp")
                        userDefault.set(self.db_id, forKey: "idsvp_frk")
                    }else{
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let page = main.instantiateViewController(withIdentifier: "tap_tech")
                        self.present(page,animated: true)
                        let userDefault = UserDefaults.standard
                        userDefault.set(self.emp_id, forKey: "id_emp")
                        userDefault.set(self.db_id, forKey: "idsvp_frk")
                    }
                    
                })
                    self.present(alert,animated: true)
                    alert.addAction(ok)
                }
            }
        }
        override func viewDidLoad() {
            super.viewDidLoad()

        }
        func checkForErrors() -> Bool {
            var errors = false
                if user.text!.isEmpty {
                    errors = true
                let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกชื่อผู้ใช้", preferredStyle: .alert)
                self.present(alert,animated: true)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                alert.addAction(ok)
            }else if pass.text!.isEmpty{
                    errors = true
                let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกรหัสผ่าน", preferredStyle: .alert)
                self.present(alert,animated: true)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                alert.addAction(ok)
        
            }
            return errors
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }

        @IBAction func back(_ sender: UIButton) {
            navigationController?.popToRootViewController(animated: true)
        }
    

}

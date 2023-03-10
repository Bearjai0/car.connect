//
//  employee_Edit.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 30/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class employee_Edit: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var type: UITextField!
    var id_emp = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.tintColor  = .black
        email.tintColor = .black
        pass.tintColor = .black
        type.tintColor = .black
        
print("id_emp is \(id_emp)")
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/employeeshowedit.php?id_emp=\(id_emp)")
        let param = "id_emp=\(id_emp)"
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let data = param.data(using: .utf8)
        URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
            if error != nil{
                print("error")
            }
            if data != nil{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                DispatchQueue.main.async {
                    self.name.text = json!["name_emp"] as? String
                    self.pass.text = json!["password"] as? String
                    self.email.text = json!["email"] as? String
                    self.type.text = json!["type_emp"] as? String
                }
            }
        }.resume()
        // Do any additional setup after loading the view.
    }
    @IBAction func regis(_ sender: Any) {
           let dataString = "http://it.e-tech.ac.th/carconn/shop/employeeedit.php?id_emp=\(id_emp)&name_emp=\(name.text!)&email=\(email.text!)&password=\(pass.text!)&type_emp=\(type.text!)"
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
                       
                   self.navigationController?.popToRootViewController(animated: true)
                   })
                       self.present(alert,animated: true)
                       alert.addAction(ok)
               }
       }
        
       @IBAction func deleted(_ sender: UIButton) {
           let dataurl = "http://it.e-tech.ac.th/carconn/shop/employeedelete.php?id_emp=\(id_emp)"
           let url = URL(string: dataurl)
           let data = try? Data(contentsOf: url!)
           let stringData = String.init(data: data!, encoding: String.Encoding.utf8)
           print(stringData!)
           if stringData=="Error"{
               let alert = UIAlertController(title: "แจ้งเตือน", message: "ลบข้อมูลไม่สำเร็จ", preferredStyle: .alert)
               let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
               self.present(alert,animated: true)
               alert.addAction(ok)
               }else{
                   let alert = UIAlertController(title: "แจ้งเตือน", message: "ลบข้อมูลสำเร็จ", preferredStyle: .alert)
                   let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                       self.name.text = ""
                       self.email.text = ""
                       self.pass.text = ""
                    self.type.text = ""
                       self.navigationController?.popToRootViewController(animated: true)
                   })
                       self.present(alert,animated: true)
                       alert.addAction(ok)
               }
       }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }


}

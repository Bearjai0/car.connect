//
//  employee_insert.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 30/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class employee_insert: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var type: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.tintColor  = .black
        email.tintColor = .black
        pass.tintColor = .black
        type.tintColor = .black

        // Do any additional setup after loading the view.
    }
    

   @IBAction func regis(_ sender: Any) {
        if !checkForErrors(){
        let userDefault = UserDefaults.standard
        let id_svp = userDefault.string(forKey:"id_svp")
            let stringData = "http://it.e-tech.ac.th/carconn/shop/employeeinsert.php?name_emp=\(name.text!)&email=\(email.text!)&password=\(pass.text!)&type_emp=\(type.text!)&idsvp_frk=\(id_svp!)"
            print(stringData)
            let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let url = URL(string: allowData!)
            let data = try? Data(contentsOf: url!)
        
            let str = String.init(data: data!,encoding: .utf8)
        print(str!)
            if(str == "ok"){
            let alert = UIAlertController(title: "เพิ่มพนักงาน", message: "เพิ่มพนักงานสำเร็จ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            })
            self.present(alert,animated: true)
            alert.addAction(ok)
        }else{
            let alert = UIAlertController(title: "เพิ่มพนักงาน", message: "เพิ่มพนักงานไม่สำเร็จ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
            self.present(alert,animated: true)
            alert.addAction(ok)
        }
    }
    }
        func checkForErrors() -> Bool {
            var errors = false
                if name.text!.isEmpty {
                    errors = true
                let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกชื่อพนักงาน", preferredStyle: .alert)
                self.present(alert,animated: true)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                alert.addAction(ok)
            }else if email.text!.isEmpty{
                    errors = true
                let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกอีเมลพนักงาน", preferredStyle: .alert)
                self.present(alert,animated: true)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                alert.addAction(ok)
            }else if pass.text!.isEmpty{
                        errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกรหัสผ่าน", preferredStyle: .alert)
                    self.present(alert,animated: true)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alert.addAction(ok)
            }else if type.text!.isEmpty{
                errors = true
            let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกตำแหน่ง", preferredStyle: .alert)
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

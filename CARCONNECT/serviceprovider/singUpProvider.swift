//
//  singUpProvider.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 15/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class singUpProvider: UIViewController {
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var workTime: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var province: UITextField!
    override func viewDidLoad() {
            super.viewDidLoad()
            
        user.tintColor = .black
        email.tintColor = .black
        pass.tintColor = .black
        confirm.tintColor = .black
        workTime.tintColor  = .black
        address.tintColor = .black
        tel.tintColor = .black
        province.tintColor = .black

            // Do any additional setup after loading the view.
        }
        @IBAction func regis(_ sender: Any) {
            let userdefaults:UserDefaults = UserDefaults.standard
            let lati:Double = userdefaults.object(forKey: "latitude") as! Double
            let longi:Double = userdefaults.object(forKey: "longitude") as! Double
            if !checkForErrors() {
                let dataurl = "http://it.e-tech.ac.th/carconn/shop/regisProvider.php?name_svp=\(user.text!)&email_svp=\(email.text!)&password_svp=\(pass.text!)&workingtime_svp=\(workTime.text!)&address_svp=\(address.text!)&tel_svp=\(tel.text!)&latitude=\(lati)&longitude=\(longi)&province=\(province.text!)"
            print(dataurl)
            let allowData = dataurl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let url = URL(string: allowData!)
            let data2 = try? Data(contentsOf: url!)
            let str = String.init(data: data2!,encoding: .utf8)
            print(str!)
                if(str == "ok"){
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "ลงทะเบียนสำเร็จ", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let page = main.instantiateViewController(withIdentifier: "singInPro")
                        self.present(page,animated: true)
                    })
                    self.present(alert,animated: true)
                    alert.addAction(ok)
                }else{
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "ลงทะเบียนไม่สำเร็จ", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    self.present(alert,animated: true)
                    alert.addAction(ok)
                }
            }
        }
        func checkForErrors() -> Bool {
                var errors = false
                if user.text!.isEmpty {
                    errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกชื่อผู้ใช้", preferredStyle: .alert)
                    self.present(alert,animated: true)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alert.addAction(ok)
                }else if email.text!.isEmpty{
                    errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกอีเมลล์", preferredStyle: .alert)
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
                else if (pass.text!.count)<8
                {
                    errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร", preferredStyle: .alert)
                    self.present(alert,animated: true)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alert.addAction(ok)
                }else if confirm.text!.isEmpty{
                    errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณายืนยันรหัสผ่าน", preferredStyle: .alert)
                    self.present(alert,animated: true)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.confirm.becomeFirstResponder()
                }else if pass.text != confirm.text{
                    errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "รหัสผ่านที่คุณยืนยันไม่ตรงกัน", preferredStyle: .alert)
                    self.present(alert,animated: true)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alert.addAction(ok)
                }else if workTime.text!.isEmpty{
                    errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกเวลาทำการ", preferredStyle: .alert)
                    self.present(alert,animated: true)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alert.addAction(ok)
                }else if address.text!.isEmpty{
                    errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกที่อยู่", preferredStyle: .alert)
                    self.present(alert,animated: true)
                    let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                    alert.addAction(ok)
                }else if tel.text!.isEmpty{
                errors = true
                let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกเบอร์โทรศัพท์", preferredStyle: .alert)
                self.present(alert,animated: true)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                alert.addAction(ok)
                self.tel.becomeFirstResponder()
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

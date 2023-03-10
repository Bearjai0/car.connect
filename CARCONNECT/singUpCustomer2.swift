//
//  singUpCustomer2.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 6/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class singUpCustomer2: UIViewController {
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var tel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func regis(_ sender: Any) {
        if !checkForErrors() {
        let dataurl = URL(string: "http://it.e-tech.ac.th/carconn/shop/regisUser.php?name_cus=\(user.text!)&email_cus=\(email.text!)&password_cus=\(pass.text!)&tel_cus=\(tel.text!)")!
        print(dataurl)
        let data2 = try? Data(contentsOf: dataurl)
        let str = String.init(data: data2!,encoding: .utf8)
        print(str!)
            if(str == "ok"){
                let alert = UIAlertController(title: "แจ้งเตือน", message: "ลงทะเทียนสำเร็จ", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                    let main = UIStoryboard(name: "Main", bundle: nil)
                    let page = main.instantiateViewController(withIdentifier: "singInCus")
                    self.present(page,animated: true)
                })
                self.present(alert,animated: true)
                alert.addAction(ok)
            }else{
                let alert = UIAlertController(title: "แจ้งเตือน", message: "ลงทะเทียนไม่สำเร็จ", preferredStyle: .alert)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

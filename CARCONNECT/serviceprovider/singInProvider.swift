//
//  singInProvider.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 7/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class singInProvider: UIViewController {
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        if !checkForErrors(){
        let dataurl = "http://it.e-tech.ac.th/carconn/shop/loginPro.php?name_svp=\(user.text!)&password_svp=\(pass.text!)"
        let allowData = dataurl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: allowData!)
        let data = try? Data(contentsOf: url!)
        let str = String.init(data: data!, encoding: String.Encoding.utf8)
        print(str!)
        if str=="Error"{
                let alert = UIAlertController(title: "แจ้งเตือน", message: "เข้าสู่ระบบไม่สำเร็จ", preferredStyle: .alert)
                       let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                       self.present(alert,animated: true)
                       alert.addAction(ok)
        
    }else{
//        let userDefault = UserDefaults.standard
//               userDefault.set(str!, forKey: "id_svp")
            let alert = UIAlertController(title: "แจ้งเตือน", message: "เข้าสู่ระบบสำเร็จ", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
            let main = UIStoryboard(name: "Main", bundle: nil)
            let page = main.instantiateViewController(withIdentifier: "controPro")
                self.present(page,animated: true)
                let userDefault = UserDefaults.standard
                userDefault.set(str!, forKey: "id_svp")
                userDefault.set("1", forKey: "login_status")
                
            })
                self.present(alert,animated: true)
                alert.addAction(ok)
//         let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณาเลือกตำแหน่งของคุณ", preferredStyle: .alert)
//                let pro = UIAlertAction(title: "เจ้าของร้าน", style: .default, handler: {(pro:UIAlertAction) in
//                let main = UIStoryboard(name: "Main", bundle: nil)
//                 let page = main.instantiateViewController(withIdentifier: "controPro")
//
//
//                self.present(page,animated: true)
//                 })
//
//         let emp = UIAlertAction(title: "พนักงาน", style: .default, handler: {(emp:UIAlertAction) in
//         let main = UIStoryboard(name: "Main", bundle: nil)
//          let page = main.instantiateViewController(withIdentifier: "employee")
//             self.present(page,animated: true)
//             })
//
//         let tec = UIAlertAction(title: "ช่างเทคนิค", style: .default, handler: {(tec:UIAlertAction) in
//         let main = UIStoryboard(name: "Main", bundle: nil)
//          let page = main.instantiateViewController(withIdentifier: "tap_tech")
//             self.present(page,animated: true)
//             })
//
//                 self.present(alert,animated: true)
//                 alert.addAction(pro)
//                 alert.addAction(emp)
//                 alert.addAction(tec)
            }
        }
    }
    override func viewDidLoad() {
        user.tintColor = .black
        pass.tintColor = .black
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

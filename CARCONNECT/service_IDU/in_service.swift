//
//  in_service.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 8/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class in_service: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var time: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.tintColor = .black
        price.tintColor = .black
        time.tintColor = .black

        // Do any additional setup after loading the view.
    }
    @IBAction func regis(_ sender: Any) {
        if !checkForErrors(){
        let userDefault = UserDefaults.standard
        let a = userDefault.string(forKey:"id_svp")
        let stringData = "http://it.e-tech.ac.th/carconn/shop/insertSer.php?name_service=\(name.text!)&price_service=\(price.text!)&time_service=\(time.text!)&id_svp=\(a!)"
            let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let url = URL(string: allowData!)
            let data = try? Data(contentsOf: url!)
        
            let str = String.init(data: data!,encoding: .utf8)
        //print(str!)
            if(str == "ok"){
            let alert = UIAlertController(title: "เพิ่มบริการ", message: "เพิ่มบริการสำเร็จ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
//                let main = UIStoryboard(name: "Main", bundle: nil)
//                let page = main.instantiateViewController(withIdentifier: "ser_navi")
//                self.present(page,animated: true)
            })
            self.present(alert,animated: true)
            alert.addAction(ok)
        }else{
            let alert = UIAlertController(title: "เพิ่มบริการ", message: "เพิ่มบริการไม่สำเร็จ", preferredStyle: .alert)
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
                let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกชื่อบริการ", preferredStyle: .alert)
                self.present(alert,animated: true)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                alert.addAction(ok)
            }else if price.text!.isEmpty{
                    errors = true
                let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกราคาค่าบริการ", preferredStyle: .alert)
                self.present(alert,animated: true)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                alert.addAction(ok)
            }else if time.text!.isEmpty{
                        errors = true
                    let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกเวลาในการให้บริการ", preferredStyle: .alert)
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
   


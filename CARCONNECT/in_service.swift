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

        // Do any additional setup after loading the view.
    }
    @IBAction func regis(_ sender: Any) {
        if !checkForErrors(){
        let userDefault = UserDefaults.standard
        let a = userDefault.string(forKey:"id_svp")
        let dataurl = "http://it.e-tech.ac.th/carconn/shop/insertSer.php?name_service=\(name.text!)&price_service=\(price.text!)&time_service=\(time.text!)&id_svp=\(a!)"
        let url = URL(string: dataurl)
        let data2 = try? Data(contentsOf: url!)
        let str = String.init(data: data2!,encoding: .utf8)
        print(str!)
        if(str == "ok"){
            let alert = UIAlertController(title: "เพิ่มบริการ", message: "เพิ่มบริการสำเร็จ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                let main = UIStoryboard(name: "Main", bundle: nil)
                let page = main.instantiateViewController(withIdentifier: "homeService2")
                self.present(page,animated: true)
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
}
   


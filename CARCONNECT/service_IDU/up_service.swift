//
//  up_service.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 8/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class up_service: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var time: UITextField!
    var id_ser2 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.tintColor = .black
        price.tintColor = .black
        time.tintColor = .black
        
        let userdefaults:UserDefaults = UserDefaults.standard
        let id_service:String = userdefaults.object(forKey: "id_svp") as! String
        print("id_serv = : \(id_service)")
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/edit_show.php?id_service=\(id_ser2)")
        let param = "id_service=\(id_service)"
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let data = param.data(using: .utf8)
        URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
            print(data!)
            if error != nil{
                print("error")
            }
            if data != nil{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                //print(json as Any)
                DispatchQueue.main.async {
                    self.time.text = json!["time_service"] as? String
                    self.name.text = json!["name_service"] as? String
                    self.price.text = json!["price_service"] as? String
                }
            }
        }.resume()

        // Do any additional setup after loading the view.
    }
    @IBAction func regis(_ sender: Any) {
        let dataString = "http://it.e-tech.ac.th/carconn/shop/edit.php?id_service=\(id_ser2)&name_service=\(name.text!)&price_service=\(price.text!)&time_service=\(time.text!)"
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
        let dataurl = "http://it.e-tech.ac.th/carconn/shop/delete_ser.php?id_service=\(id_ser2)"
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
                    self.price.text = ""
                    self.time.text = ""
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

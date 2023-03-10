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
    override func viewDidLoad() {
        super.viewDidLoad()
        let userdefaults:UserDefaults = UserDefaults.standard
        let id_service:String = userdefaults.object(forKey: "id_svp") as! String
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/edit.php?id_service=\(id_service)")
        let param = "id_service=\(id_service)"
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        print("id_service ="+id_service)
        
        let data = param.data(using: .utf8)
        URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
            if error != nil{
                print("error")
            }
            if data != nil{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
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
        
    }
    @IBAction func deleted(_ sender: UIButton) {
    }
    
  
}

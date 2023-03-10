//
//  Technicianshow.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 7/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class Technicianshow: UIViewController ,UITableViewDataSource,UITableViewDelegate{

        var id_car = ""
        var id_customer = ""
        var id_serviceProvider = ""
        

        @IBOutlet weak var id_lic: UILabel!
        @IBOutlet weak var BGwhiteView: UIView!
        
        var id:[String] = []
        var name:[String] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            id_lic.text = id_car
            getData()
            bgWhiteSet()
            // Do any additional setup after loading the view.
        }
    
    func bgWhiteSet() {
        tableV.backgroundColor = UIColor.white
        BGwhiteView.layer.shadowColor = UIColor.black.cgColor
        BGwhiteView.layer.shadowOffset = CGSize.zero
        BGwhiteView.layer.shadowOpacity = 0.16
        BGwhiteView.layer.shadowRadius = 10
        BGwhiteView.layer.cornerRadius = 15
    }
    
        @IBOutlet weak var tableV: UITableView!
        
        func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return name.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell:TechnicShowTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! TechnicShowTableViewCell
            cell.namedata.text = name[indexPath.row]
            return cell
        }
        @IBAction func ok(_ sender: UIButton) {
            let userdefaults:UserDefaults = UserDefaults.standard
            let id_emp:String = userdefaults.object(forKey: "id_emp") as! String
            let dataurl = "http://it.e-tech.ac.th/carconn/shop/Technicianconfirmorder.php?cus_lic=\(id_car)&idcus_frk=\(id_customer)&idlvd_frk=\(id_serviceProvider)&id_employee=\(id_emp)"
                let allowData = dataurl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let url = URL(string: allowData!)
                let data = try? Data(contentsOf: url!)
                    let stringData = String.init(data: data!, encoding: String.Encoding.utf8)
                print(stringData!)
                if stringData=="Error"{
                        let alert = UIAlertController(title: "แจ้งเตือน", message: "ยืนยันไม่สำเร็จ", preferredStyle: .alert)
                               let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                               self.present(alert,animated: true)
                               alert.addAction(ok)
                
            }else{
                 let alert = UIAlertController(title: "แจ้งเตือน", message: "ยืนยันสำเร็จ", preferredStyle: .alert)
                           let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                            self.navigationController?.popToRootViewController(animated: true)
                            //self.tabBarController!.selectedIndex = 1
                            })
                            self.present(alert,animated: true)
                            alert.addAction(ok)
                    }
        }
        
        func getData(){
            let dataString =  "http://it.e-tech.ac.th/carconn/shop/Technicianshoworder.php?cus_lic=\(id_car)&idcus_frk=\(id_customer)&idlvd_frk=\(id_serviceProvider)"
            print(dataString as Any)
            let allowData = dataString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let url = URL(string: allowData!)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil{
                    print("error")
                }else{
                    let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                    print(json as Any)
                    print(json!.count)
                    for i in 0...json!.count-1{
                        if json![i] is [String:Any]{
                            let data:[String:Any] = json![i] as! [String : Any]
                            self.id.append(data["cus_lic"] as! String)
                            self.name.append(data["sv_name"] as! String)
                    }
                    DispatchQueue.main.async {
                         
                        self.tableV.reloadData()
                    }
                    }
                }
            }.resume()
            
        }
       @IBAction func back(_ sender: UIButton) {
    //        let main = UIStoryboard(name: "Main", bundle: nil)
    //        let page = main.instantiateViewController(withIdentifier: "showselectservice")
    //        self.present(page,animated: true)
            navigationController?.popToRootViewController(animated: true)
        }
    }


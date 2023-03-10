//
//  TechnicianShowConfrim.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 17/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class TechnicianShowConfrim: UIViewController ,UITableViewDataSource,UITableViewDelegate{

        var id_car = ""
        var id_customer = ""
        var id_serviceProvider = ""
        

        @IBOutlet weak var id_lic: UILabel!
    @IBOutlet weak var BGwhiteView: UIView!
        
        var id:[String] = []
        var name:[String] = []
    var status:[String] = []
        

        override func viewDidLoad() {
            super.viewDidLoad()
            id_lic.text = id_car
            bgWhiteSet()
//            getData()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell:TechnicianShowConfrimTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! TechnicianShowConfrimTableViewCell
            cell.namedata.text = name[indexPath.row]
            
            if status[indexPath.row] == "ดำเนินการเสร็จแล้ว"{
                cell.imgstatus.image = UIImage(named: "suss.png")
            }else{
                //cell.imgstatus.image = UIImage(named: "circle")
            }
            
            
            
            return cell
            
            
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.name.removeAll()
        self.id.removeAll()
        self.status.removeAll()
        getData()
        tableV.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.status[indexPath.row] != "ดำเนินการเสร็จแล้ว" {
            let cell:TechnicianShowConfrimTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! TechnicianShowConfrimTableViewCell
            
            let alert = UIAlertController(title: "แจ้งเตือน", message: "ยืนยันการให้บริการเสร็จสิ้น", preferredStyle: .alert)
            let no = UIAlertAction(title: "ยกเลิก", style: .default)
            let yes = UIAlertAction(title: "ยืนยัน", style: .destructive, handler: {_ in
                if self.status[indexPath.row] == "ดำเนินการเสร็จแล้ว"{
                    self.changstatus(id_customer: self.id_customer,id_car: self.id_car,id_serviceProvider: self.id_serviceProvider,namedata: self.name[indexPath.row])
                    cell.imgstatus.image = UIImage(named: "circle")
                }else{
                    self.changstatus(id_customer: self.id_customer,id_car: self.id_car,id_serviceProvider: self.id_serviceProvider,namedata: self.name[indexPath.row])
                    cell.imgstatus.image = UIImage(named: "tick.png")
                }
                 self.viewWillAppear(true)
            })
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true, completion: nil)
            
        }
        tableV.reloadData()
    }
    
    
    func changstatus(id_customer: String, id_car: String,id_serviceProvider:String,namedata:String) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        let time = Date()
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let timer = format.string(from: time)
        
         let stringData = "http://it.e-tech.ac.th/carconn/shop/Technicianconfirmorderinprogress.php?idcus_frk=\(id_customer)&cus_lic=\(id_car)&idlvd_frk=\(id_serviceProvider)&sv_name=\(namedata)&finisheddate=\(result)&finishedtime=\(timer)"
         let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
         let url = URL(string: allowData!)
         let data = try? Data(contentsOf: url!)
         
     }
    
    
    
        func getData(){
                let dataString =  "http://it.e-tech.ac.th/carconn/shop/Technicianshoworderinprogress.php?cus_lic=\(id_car)&idcus_frk=\(id_customer)&idlvd_frk=\(id_serviceProvider)"
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
                                self.status.append(data["status"] as! String)
                        }
                        DispatchQueue.main.async {
                             
                            self.tableV.reloadData()
                        }
                        }
                    }
                }.resume()
                
            }
         @IBAction func back(_ sender: UIButton) {
                navigationController?.popToRootViewController(animated: true)
            }
}

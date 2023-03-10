//
//  CustomerShowOrder.swift
//  CARCONNECT
//
//  Created by MAC923_48 on 17/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class CustomerShowOrder: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var lic: UILabel!
    @IBOutlet weak var BGwhiteView: UIView!
    
    var id_cus = ""
    var id_car = ""
    var id_ser = ""
    var recevie_d = ""
    var recevie_t = ""
    var name:[String] = []
    var status:[String] = []
    
   override func viewDidLoad() {
        super.viewDidLoad()
    bgWhiteSet()
        lic.text = id_car
        getData()
        // Do any additional setup after loading the view.
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
        
        let cell:CustomerShowOrderTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! CustomerShowOrderTableViewCell
        cell.namedata.text = name[indexPath.row]
        
        if status[indexPath.row] == "ดำเนินการเสร็จแล้ว"{
            cell.imgstatus.image = UIImage(named: "suss.png")
        }
        return cell
    }
    func getData(){
            let dataString =  "http://it.e-tech.ac.th/carconn/shop/customershoworder.php?cus_lic=\(id_car)&idcus_frk=\(id_cus)&idlvd_frk=\(id_ser)&receive_date=\(recevie_d)&receive_time=\(recevie_t)"
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
    
    func bgWhiteSet() {
        tableV.backgroundColor = UIColor.white
        BGwhiteView.layer.shadowColor = UIColor.black.cgColor
        BGwhiteView.layer.shadowOffset = CGSize.zero
        BGwhiteView.layer.shadowOpacity = 0.16
        BGwhiteView.layer.shadowRadius = 10
        BGwhiteView.layer.cornerRadius = 15
    }


}

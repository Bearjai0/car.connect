//
//  Technicianshowemployeeconfirm.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 4/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class Technicianshowemployeeconfirm: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableV: UITableView!
    
    var id_ser3 = ""
        
        var showlicc:[String] = []
        var idcus_frk:[String] = []
        var idlvd_frk:[String] = []
        //var id_ser:[String] = []
        //var nameData:[String] = []
        //var priceData:[String] = []
        //var timeData:[String] = []
    
    
        
        func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
            return 1
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return showlicc.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell:TechnicianshowemployeeconfirmTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! TechnicianshowemployeeconfirmTableViewCell
            viewSet(v: cell.bgView)
            cell.showlic.text = showlicc[indexPath.row]
            //cell.price.text = priceData[indexPath.row]
            //cell.time.text = timeData[indexPath.row]
            //cell.edit1.tag = Int(id_ser[indexPath.row])!
            return cell
        }
    
    func viewSet(v:UIView) {
           v.layer.cornerRadius = 3
           v.layer.shadowColor = UIColor.black.cgColor
           v.layer.shadowOffset = CGSize.zero
           v.layer.shadowOpacity = 0.16
           v.layer.shadowRadius = 5
       }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let destinationVC = storyboard?.instantiateViewController(identifier: "show_tech") as? Technicianshow
            destinationVC?.id_car = showlicc[indexPath.row]
            destinationVC?.id_customer = idcus_frk[indexPath.row]
            destinationVC?.id_serviceProvider = idlvd_frk[indexPath.row]
            self.navigationController?.pushViewController(destinationVC!, animated: true)
            //performSegue(withIdentifier: "show_data", sender: self)
        }
        override func viewDidLoad() {
        super.viewDidLoad()
            //getData()
        }
        
    override func viewWillAppear(_ animated: Bool) {
          showlicc.removeAll()
          idcus_frk.removeAll()
          idlvd_frk.removeAll()
          getData()
          tableV.reloadData()
      }
        
        func getData(){
            let userdefaults:UserDefaults = UserDefaults.standard
            let idsvp_frk:String = userdefaults.object(forKey: "idsvp_frk") as! String
            //let sta = "ยังไม่ดำเนินการ"
            print ("id is = \(idsvp_frk)")
            let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/Technicianshowemployeeconfirm.php?idsvp_frk=\(idsvp_frk)")
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
//                if error != nil{
//                    print("error")
                if data!.count <= 5 {
                }else{
                    let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                    
                    print(json!.count)
                    for i in 0...json!.count-1{
                        if json![i] is [String:Any]{
                            let data:[String:Any] = json![i] as! [String : Any]
                            
                            self.showlicc.append(data["cus_lic"] as! String)
                            self.idcus_frk.append(data["idcus_frk"] as! String)
                            self.idlvd_frk.append(data["idlvd_frk"] as! String)
                    }
                    DispatchQueue.main.async {
                         
                        self.tableV.reloadData()
                    }
                    }
                }
            }.resume()
            
        }
    @IBAction func exit(_ sender: UIButton) {
        let alert = UIAlertController(title: "แจ้งเตือน", message: "ออกจากระบบ", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
        let main = UIStoryboard(name: "Main", bundle: nil)
        let page = main.instantiateViewController(withIdentifier: "index")
            self.present(page,animated: true)
                              })
                              self.present(alert,animated: true)
                              alert.addAction(ok)
    }
       
    
    
    }

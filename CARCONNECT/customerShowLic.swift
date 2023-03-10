//
//  customerShowLic.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 17/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class customerShowLic: UIViewController,UITableViewDataSource,UITableViewDelegate{

   @IBOutlet weak var tableV: UITableView!
    var lic:[String] = []
    var idcus:[String] = []
    var idser:[String] = []
    var re_d:[String] = []
    var re_t:[String] = []
    var name:[String] = []
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
         return 1
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return lic.count
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell:customerShowLicTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! customerShowLicTableViewCell
        viewSet(v: cell.bgView)
         cell.showlic.text = lic[indexPath.row]
        cell.name_svp.text = name[indexPath.row]

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
        let destinationVC = storyboard?.instantiateViewController(identifier: "cus_show") as? CustomerShowOrder
        destinationVC?.id_car = lic[indexPath.row]
        destinationVC?.id_cus = idcus[indexPath.row]
        destinationVC?.id_ser = idser[indexPath.row]
        destinationVC?.recevie_d = re_d[indexPath.row]
        destinationVC?.recevie_t = re_t[indexPath.row]
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
     
     override func viewDidLoad() {
     super.viewDidLoad()
        getData()
     }
    
    override func viewWillAppear(_ animated: Bool) {
    //               showlicc.removeAll()
    //               idcus_frk.removeAll()
    //               idlvd_frk.removeAll()
                  // getData()
                   tableV.reloadData()
           }
     

     
     func getData(){
         let userdefaults:UserDefaults = UserDefaults.standard
         let idcus_frk:String = userdefaults.object(forKey: "id_cus") as! String
         print ("id is = \(idcus_frk)")
         let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/customershowlic.php?idcus_frk=\(idcus_frk)")
         URLSession.shared.dataTask(with: url!) { (data, response, error) in
//             if error != nil{
//                 print("error")
            if data!.count <= 5 {
             }else{
                 let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                 
                 print(json!.count)
                 for i in 0...json!.count-1{
                     if json![i] is [String:Any]{
                         let data:[String:Any] = json![i] as! [String : Any]
                         
                         self.lic.append(data["cus_lic"] as! String)
                        self.name.append(data["name_svp"] as! String)
                        self.idcus.append(data["idcus_frk"] as! String)
                        self.idser.append(data["idlvd_frk"] as! String)
                        self.re_d.append(data["receive_date"] as! String)
                        self.re_t.append(data["receive_time"] as! String)
                 }
                 DispatchQueue.main.async {
                      
                     self.tableV.reloadData()
                 }
                 }
             }
         }.resume()
         
     }
    
}

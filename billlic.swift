//
//  billlic.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 3/2/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class billlic: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var BGwhiteView: UIView!
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
              return 1
          }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lic.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    override func viewWillAppear(_ animated: Bool) {
                  lic.removeAll()
                   date.removeAll()
                 time.removeAll()
                   getData()
                   //billtable.reloadData()
           }
    
    @IBOutlet weak var billtable: UITableView!
    var lic:[String] = []
    var date:[String] = []
    var time:[String] = []
    var idsvp:[String] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:billlicTableViewCell = self.billtable.dequeueReusableCell(withIdentifier: "liccell") as! billlicTableViewCell
        cell.showlic.text = lic[indexPath.row]
        cell.showdate.text = date[indexPath.row]
        cell.showtime.text = time[indexPath.row]
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = storyboard?.instantiateViewController(identifier: "licS") as? HistoryReceive
        destinationVC?.id_car = lic[indexPath.row]
        destinationVC?.receivedate = date[indexPath.row]
        destinationVC?.receivetime = time[indexPath.row]
        destinationVC?.idsvp = idsvp[indexPath.row]
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
   
    
    

    override func viewDidLoad() {
        bgWhiteSet()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bgWhiteSet() {
        billtable.backgroundColor = UIColor.white
        BGwhiteView.layer.shadowColor = UIColor.black.cgColor
        BGwhiteView.layer.shadowOffset = CGSize.zero
        BGwhiteView.layer.shadowOpacity = 0.16
        BGwhiteView.layer.shadowRadius = 10
        BGwhiteView.layer.cornerRadius = 15
    }

   func getData() {
    
    let userDefault = UserDefaults.standard
    let id_cus = userDefault.string(forKey: "id_cus")!
    
    
    let stringData = "http://it.e-tech.ac.th/carconn/shop/billlic.php?idcus_frk=\(id_cus)"
        print(stringData)
        let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: allowData!)
        URLSession.shared.dataTask(with: url!){(data,response,error) in
//            if error != nil{
//                print("error")
            if data!.count <= 5 {
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                print(json!.count)
                for i in 0...json!.count-1{
                    let data:[String:Any] = json![i] as! [String : Any]
                    self.lic.append(data["cus_lic"] as! String)
                    self.date.append(data["receive_date"] as! String)
                    self.time.append(data["receive_time"] as! String)
                    self.idsvp.append(data["idlvd_frk"] as! String)
                }
                DispatchQueue.main.async {
                    self.billtable.reloadData()
                }
            }
        }.resume()
    }


}

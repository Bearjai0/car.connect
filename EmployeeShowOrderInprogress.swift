//
//  EmployeeShowOrderInprogress.swift
//  CARCONNECT
//
//  Created by MAC923_48 on 17/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class EmployeeShowOrderInprogress: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var id_car = ""
    var id_cus = ""
    var id_ser = ""
    
    var id:[String] = []
    var name:[String] = []
    var status:[String] = []
    var price:[String] = []
    var showtime:[String] = []
    
    var ccount = 0
    var price2 = 0.00
    var t = 0
    var n = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        bgWhiteSet()
        //getData()
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
    
    override func viewWillAppear(_ animated: Bool) {
        name.removeAll()
        price.removeAll()
        showtime.removeAll()
        getData()
        tableV.reloadData()
    }
    
    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var sumprice: UILabel!
     @IBOutlet weak var sumtime: UILabel!
    @IBOutlet weak var BGwhiteView: UIView!
    
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
        
        let cell:EmployeeShowOrderInprogressTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! EmployeeShowOrderInprogressTableViewCell
        cell.namedata.text = name[indexPath.row]
        cell.showprice.text = price[indexPath.row]
        //cell.showtime.text = showtime[indexPath.row]
        self.sumprice.text = String(price2)
        //self.sumtime.text = "\(t)"+" ชั่วโมง "+"\(n)"+" นาที"
        
        if status[indexPath.row] == "ดำเนินการเสร็จแล้ว"{
            cell.imgstatus.image = UIImage(named: "suss.png")
        }
        return cell
    }
    @IBAction func ok(_ sender: UIButton) {
        let dataurl = "http://it.e-tech.ac.th/carconn/shop/Employeeconfirmorderinprogress.php?cus_lic=\(id_car)&idcus_frk=\(id_cus)&idlvd_frk=\(id_ser)"
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
                       
                       self.navigationController?.popToRootViewController(animated: true)  //self.tabBarController!.selectedIndex = 1
                        })
                        self.present(alert,animated: true)
                        alert.addAction(ok)
                }
    }
    
    func getData(){
        let dataString =  "http://it.e-tech.ac.th/carconn/shop/Employeeshoworderinprogress.php?cus_lic=\(id_car)&idcus_frk=\(id_cus)&idlvd_frk=\(id_ser)"
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
                        self.price.append(data["sv_price"] as! String)
                        self.showtime.append(data["sv_time"] as! String)
                        self.ccount+=1
                }
                    
                DispatchQueue.main.async {
                     
                    self.tableV.reloadData()
                }
                }
                self.cal()
            }
        }.resume()
        
    }
    
    func cal() {
        var time2 = 0
        var c = 0
        print(ccount)
        while c < self.ccount {
           
            time2 = time2 + Int(self.showtime[c])!
            price2 = price2 + Double(self.price[c])!
            c+=1
            print("priceeee",price2)
        }
        
        t = time2 / 60
        n = time2 % 60
    }
    
       @IBAction func back(_ sender: UIButton) {
    //        let main = UIStoryboard(name: "Main", bundle: nil)
    //        let page = main.instantiateViewController(withIdentifier: "showselectservice")
    //        self.present(page,animated: true)
            navigationController?.popToRootViewController(animated: true)
        }
}

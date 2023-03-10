//
//  ShowService.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 18/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class ShowService: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var cus_name: UILabel!
    @IBOutlet weak var cus_lic: UILabel!
    @IBOutlet weak var cus_date: UILabel!
    @IBOutlet weak var sumtime: UILabel!
    @IBOutlet weak var sumprice: UILabel!
    
    var name:[String] = []
    var lic:[String] = []
    var date:[String] = []
    var time:[String] = []
    var price:[String] = []
    var showtime:[String] = []
    
    var ccount = 0
    var price2 = 0.00
    var t = 0
    var n = 0
    
    @IBOutlet weak var tableV: UITableView!
     @IBOutlet weak var BGwhiteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgWhiteSet()
        let userDefault = UserDefaults.standard
        let id_cus = userDefault.string(forKey: "id_cus")!
        let lic_cus = userDefault.string(forKey: "cuslic")!
        let date_cus = userDefault.string(forKey: "date_cus")!
        cus_lic.text = lic_cus
        cus_date.text = date_cus
        
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
        showtime.removeAll()
        price.removeAll()
        getData()
        tableV.reloadData()
    }
    
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return name.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ShowServiceTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! ShowServiceTableViewCell
        cell.namedata.text = name[indexPath.row]
        cell.showtime.text = showtime[indexPath.row]
        cell.price.text = price[indexPath.row]
        self.sumtime.text = "\(t)"+" ชั่วโมง "+"\(n)"+" นาที"
        self.sumprice.text = "\(String(price2))"+" บาท"
        return cell
        
    }
    
    func getData(){
        
        let userDefault = UserDefaults.standard
        let id_cus = userDefault.string(forKey: "id_cus")!
        let lic_cus = userDefault.string(forKey: "cuslic")!
        let date_cus = userDefault.string(forKey: "date_cus")!
        let time_cus = userDefault.string(forKey: "time_cus")!
        let id_svp = userDefault.string(forKey: "id_svp")!
        
        let stringData = "http://it.e-tech.ac.th/carconn/shop/showreceive.php?idcus_frk=\(id_cus)&cus_lic=\(lic_cus)&idlvd_frk=\(id_svp)&receive_date=\(date_cus)&receive_time=\(time_cus)"
        print(stringData)
        let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: allowData!)
        URLSession.shared.dataTask(with: url!){(data,response,error) in
            if error != nil{
                print("error")
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                print(json!.count)
                for i in 0...json!.count-1{
                    let data:[String:Any] = json![i] as! [String : Any]
                    self.name.append(data["sv_name"] as! String)
                    self.lic.append(data["cus_lic"] as! String)
                    self.date.append(data["receive_date"] as! String)
                    self.time.append(data["receive_time"] as! String)
                    self.price.append(data["sv_price"] as! String)
                    
                    self.showtime.append(data["sv_time"] as! String)
                    self.ccount+=1
                }
                self.cal()
                DispatchQueue.main.async {
                    self.tableV.reloadData()
                }
            }
        }.resume()
    }
    @IBAction func confirm(_ sender: UIButton) {
        let getViewController = self.storyboard?.instantiateViewController(withIdentifier: "controCus") as! UITabBarController
        getViewController.selectedIndex = 3
        present(getViewController, animated: true)
    }
    
    
    
    @IBAction func backk(_ sender: Any) {
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    func cal() {
        var time2 = 0
        var c = 0
        print(ccount)
        while c < self.ccount {
           
            time2 = time2 + Int(self.showtime[c])!
            price2 = price2 + Double(self.price[c])!
            c+=1
            print(self.showtime)
        }
        
        t = time2 / 60
        n = time2 % 60
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

}

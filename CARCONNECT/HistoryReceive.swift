//
//  HistoryReceive.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 18/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class HistoryReceive: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var BGwhiteView: UIView!
    var id_car = ""
    var receivedate = ""
    var receivetime = ""
    var idsvp = ""
    
    var name:[String] = []
    var lic:[String] = []
    var date:[String] = []
    var time:[String] = []
    var price:[String] = []
    var showtime:[String] = []
    var status:[String] = []
    
    var id_svp:String? = nil
    let userDefaults:UserDefaults = UserDefaults.standard
    
    var ccount = 0
    var price2 = 0.00
    var t = 0
    var n = 0

    @IBOutlet weak var imgstatus: UIImageView!
    @IBOutlet weak var sumprice: UILabel!
    @IBOutlet weak var sumtime: UILabel!
    @IBOutlet weak var tableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgWhiteSet()
        mapData()
        getData()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        name.removeAll()
//        showtime.removeAll()
//        price.removeAll()
//        getData()
        tableV.reloadData()
        mapData()
    }
    
    func bgWhiteSet() {
        tableV.backgroundColor = UIColor.white
        BGwhiteView.layer.shadowColor = UIColor.black.cgColor
        BGwhiteView.layer.shadowOffset = CGSize.zero
        BGwhiteView.layer.shadowOpacity = 0.16
        BGwhiteView.layer.shadowRadius = 10
        BGwhiteView.layer.cornerRadius = 15
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
        let cell:HistoryReceiveTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! HistoryReceiveTableViewCell
        cell.namedata.text = name[indexPath.row]
        cell.price.text = price[indexPath.row]
        cell.showtime.text = showtime[indexPath.row]
        self.sumtime.text = "\(t)"+" ชั่วโมง "+"\(n)"+" นาที"
        self.sumprice.text = String(price2)
        
        if status[indexPath.row] == "ดำเนินการเสร็จแล้ว"{
            imgstatus.image = UIImage(named: "sus.png")
        }
      
        
        return cell
        
    }
    
    func getData(){
        
        let userDefault = UserDefaults.standard
               let id_cus = userDefault.string(forKey: "id_cus")!
        
        let stringData = "http://it.e-tech.ac.th/carconn/shop/historyreceive.php?idcus_frk=\(id_cus)&cus_lic=\(id_car)&receive_date=\(receivedate)&receive_time=\(receivetime)"
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
                    self.id_svp = data["idlvd_frk"] as! String
                    self.status.append(data["status"] as! String)
                    self.ccount+=1
                }
                self.cal()
                DispatchQueue.main.async {
                    self.tableV.reloadData()
                }
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
                print(self.showtime)
            }
            
            t = time2 / 60
            n = time2 % 60
        }
    

    
    @IBAction func ok(_ sender: Any) {
            
        var score = 0
            let userDefault = UserDefaults.standard
            let id_cus = userDefault.string(forKey: "id_cus")!
        
            let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณาให้คะแนนศูนย์บริการ", preferredStyle: .alert)
            let five = UIAlertAction(title: "5 คะแนน", style: .default, handler: {(five:UIAlertAction) in
                updateScore(idcus: id_cus, idsvp: self.id_svp!, score: "5")
            })
            let four = UIAlertAction(title: "4 คะแนน", style: .default, handler: {(four:UIAlertAction) in
                updateScore(idcus: id_cus, idsvp: self.id_svp!, score: "4")
            })
            let three = UIAlertAction(title: "3 คะแนน", style: .default, handler: {(three:UIAlertAction) in
                updateScore(idcus: id_cus, idsvp: self.id_svp!, score: "3")
            })
            let two = UIAlertAction(title: "2 คะแนน", style: .default, handler: {(two:UIAlertAction) in
                updateScore(idcus: id_cus, idsvp: self.id_svp!, score: "2")
            })
            let one = UIAlertAction(title: "1 คะแนน", style: .default, handler: {(one:UIAlertAction) in
                updateScore(idcus: id_cus, idsvp: self.id_svp!, score: "1")
            })
             
                self.present(alert,animated: true)
                    alert.addAction(five)
                    alert.addAction(four)
                    alert.addAction(three)
                    alert.addAction(two)
                    alert.addAction(one)
                }
    
    @IBAction func back(_ sender: UIButton) {
           navigationController?.popToRootViewController(animated: true)
       }
    
    func mapData() {
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/show_svp.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error")
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                
                var id_svp:[String] = []
                var name_svp:[String] = []
                var latitude:[String] = []
                var longitude:[String] = []
                
                for i in 0...json!.count-1{
                    if json![i] is [String:Any]{
                        let data:[String:Any] = json![i] as! [String : Any]
                        
                        id_svp.append((data["id_svp"] as! String))
                        name_svp.append((data["name_svp"] as! String))
                        latitude.append((data["latitude"] as! String))
                        longitude.append((data["longitude"] as! String))
                        
                        
                    }
                }
                print("nn",id_svp)
                self.userDefaults.set(id_svp, forKey: "id_svp")
                self.userDefaults.set(name_svp, forKey: "name_svp")
                self.userDefaults.set(latitude, forKey: "latitude")
                self.userDefaults.set(longitude, forKey: "longitude")
            }
        }.resume()
    }
    
    
    
    
            }


        

func updateScore(idcus:String ,idsvp:String ,score:String){
    let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/insertreview.php?idcus_frk=\(idcus)&idsvp_frk=\(idsvp)&score=\(score)")
    let data = try? Data(contentsOf: url!)
    print(data)
}

    


//
//  homeCus.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 7/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class homeCus: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var province: UITextField!
    @IBOutlet weak var tablevi: UITableView!
    @IBOutlet weak var BGwhiteView: UIView!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    var id_svp:[String] = []
    var nameData:[String] = []
    var timeData:[String] = []
    var addressData:[String] = []
    var pro_vince:[String] = []
    var idsvp:String = ""

    var imgData:[String] = []
    var count = 0
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:svpTableViewCell = self.tablevi.dequeueReusableCell(withIdentifier: "cell") as! svpTableViewCell
//        viewSet(v: cell.bgView)
        cell.name.text = nameData[indexPath.row]
        cell.time.text = timeData[indexPath.row]
        cell.address.text = addressData[indexPath.row]
        cell.show_svp.tag = Int (id_svp[indexPath.row])!
        cell.provinceshow.text = pro_vince[indexPath.row]
        
//        cell.show_map.tag = Int (id_svp[indexPath.row])!
        
        cell.imagesvp.image = UIImage(named: imgData[count])
        if count < 9 {
            count+=1
        }else{
            count=0
        }
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:svpTableViewCell = self.tablevi.dequeueReusableCell(withIdentifier: "cell") as! svpTableViewCell
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = storyboard?.instantiateViewController(identifier: "svShow") as? svp_show
        destinationVC?.id_svp = id_svp[indexPath.row]
        userDefaults.set(id_svp[indexPath.row], forKey: "select_id")
    self.navigationController?.pushViewController(destinationVC!, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        nameData.removeAll()
        timeData.removeAll()
        addressData.removeAll()
        id_svp.removeAll()
        getData()
        tablevi.reloadData()
    }
    
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
        bgWhiteSet()
//           getData()
//        mapData()
        imgData = ["pvd1.jpg","pvd2.jpg","pvd3.jpg","pvd4.jpg","pvd5.jpg","pvd6.jpg","pvd7.jpg","pvd8.jpg","pvd9.jpg","pvd10.jpg"]
       }
    func bgWhiteSet() {
        tablevi.backgroundColor = UIColor.white
        BGwhiteView.layer.shadowColor = UIColor.black.cgColor
        BGwhiteView.layer.shadowOffset = CGSize.zero
        BGwhiteView.layer.shadowOpacity = 0.16
        BGwhiteView.layer.shadowRadius = 10
        BGwhiteView.layer.cornerRadius = 15
    }
    
//    func viewSet(v:UIView) {
//        v.layer.cornerRadius = 3
//        v.layer.shadowColor = UIColor.black.cgColor
//        v.layer.shadowOffset = CGSize.zero
//        v.layer.shadowOpacity = 0.16
//        v.layer.shadowRadius = 5
//    }
    
    

    
    @IBAction func search(_ sender: Any) {
//        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/searchprovince.php?province=\(province.text!)")
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil{
//                print("error")
        let stringData = "http://it.e-tech.ac.th/carconn/shop/searchprovince.php?province=\(province.text!)"
                    print(stringData)
        let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: allowData!)
        URLSession.shared.dataTask(with: url!){(data,response,error) in
        //                if error != nil{
        //                    print("error")
            if data!.count <= 5{
                
            }else{
                self.nameData.removeAll()
                self.timeData.removeAll()
                self.addressData.removeAll()
                self.pro_vince.removeAll()
                self.id_svp.removeAll()
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                print(json!.count)
                for i in 0...json!.count-1{
                    if json![i] is [String:Any]{
                        let data:[String:Any] = json![i] as! [String : Any]
                        self.id_svp.append(data["id_svp"] as! String)
                        self.nameData.append(data["name_svp"] as! String)
                        self.timeData.append(data["workingtime_svp"] as! String)
                        self.addressData.append(data["address_svp"] as! String)
                        self.pro_vince.append(data["province"] as! String)
                    }
                }
                DispatchQueue.main.async {
                    self.tablevi.reloadData()
                }
            }
        }.resume()
    }
    
    
    func getData(){
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/show_svp.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error")
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                print(json!.count)
                for i in 0...json!.count-1{
                    if json![i] is [String:Any]{
                        let data:[String:Any] = json![i] as! [String : Any]
                        self.id_svp.append(data["id_svp"] as! String)
                        self.nameData.append(data["name_svp"] as! String)
                        self.timeData.append(data["workingtime_svp"] as! String)
                        self.addressData.append(data["address_svp"] as! String)
                        self.pro_vince.append(data["province"] as! String)
                     
                        
                    }
                }
                DispatchQueue.main.async {
                    self.tablevi.reloadData()
                }
            }
        }.resume()
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
                var pro_vince:[String] = []
                
                for i in 0...json!.count-1{
                    if json![i] is [String:Any]{
                        let data:[String:Any] = json![i] as! [String : Any]
                        
                        id_svp.append((data["id_svp"] as! String))
                        name_svp.append((data["name_svp"] as! String))
                        latitude.append((data["latitude"] as! String))
                        longitude.append((data["longitude"] as! String))
                        pro_vince.append((data["province"] as! String))
                        
                        
                    }
                }
                self.userDefaults.set(name_svp, forKey: "id_svp")
                self.userDefaults.set(name_svp, forKey: "name_svp")
                self.userDefaults.set(latitude, forKey: "latitude")
                self.userDefaults.set(longitude, forKey: "longitude")
                self.userDefaults.set(pro_vince, forKey: "province")
            }
        }.resume()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "show"{
       let page = segue.destination as! showreview
       page.id_svp = String((sender as! UIButton).tag)
            
            if segue.identifier == "map"{
                let page2 = segue.destination as! mapshow
                page2.id_svp = String((sender as! UIButton).tag)
            }
        }
    }
}

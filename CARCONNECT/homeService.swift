//
//  homeService.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 8/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class homeService: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var BGwhiteView: UIView!
    
    var id_ser3 = ""
    
    var id_ser:[String] = []
    var nameData:[String] = []
    var priceData:[String] = []
    var timeData:[String] = []
    
    var imgData:[String] = []
    var count = 0
    
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:serviceTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! serviceTableViewCell
        cell.name.text = nameData[indexPath.row]
        cell.price.text = priceData[indexPath.row]
        cell.time.text = timeData[indexPath.row]
        cell.edit1.tag = Int(id_ser[indexPath.row])!
        cell.imageCar.image = UIImage(named: imgData[count])
        if count < 3 {
            count+=1
        }else{
            count=0
        }
        return cell
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        bgWhiteSet()
        //getData()
        imgData = ["car1.png","car2.png","car3.png","car4.png"]
        tableV.reloadData()
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
        nameData.removeAll()
        priceData.removeAll()
        timeData.removeAll()
        
        getData()
        tableV.reloadData()
    }

    
    func getData(){
        let userdefaults:UserDefaults = UserDefaults.standard
        let idsvp_frk:String = userdefaults.object(forKey: "id_svp") as! String
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/get_cust_service.php?idsvp_frk=\(idsvp_frk)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil{
//                print("error")
            if data!.count <= 5 {
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                
                print(json!.count)
                for i in 0...json!.count-1{
                    if json![i] is [String:Any]{
                        let data:[String:Any] = json![i] as! [String : Any]
                       
                        self.id_ser.append(data["id_service"] as! String)
                        self.priceData.append(data["price_service"] as! String)
                        self.nameData.append(data["name_service"] as! String)
                        self.timeData.append(data["time_service"] as! String)
                       
                }
                DispatchQueue.main.async {
                     
                    self.tableV.reloadData()
                }
                }
            }
        }.resume()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let page = segue.destination as! up_service
            page.id_ser2 = String((sender as! UIButton).tag)
        }
        
    }
    @IBAction func back(_ sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let page = main.instantiateViewController(withIdentifier: "controPro")
        self.present(page,animated: true)
    }
}

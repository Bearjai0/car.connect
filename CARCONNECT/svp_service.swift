//
//  svp_service.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 6/12/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class svp_service: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableV: UITableView!
    
    var id_svp2 = ""
    var selectRow = [Bool]()
    
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
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        selectRow.append(false)
        let cell:svp_serviceTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "listService") as! svp_serviceTableViewCell
        viewSet(v: cell.bgView)
        cell.name.text = nameData[indexPath.row]
        cell.price.text = priceData[indexPath.row]
        cell.time.text = timeData[indexPath.row]
        
        cell.imageCar.image = UIImage(named: imgData[count])
        if count < 3 {
            count+=1
        }else{
            count=0
        }
        
        if selectRow[indexPath.row]{
            cell.check.isHidden = false
            cell.accessoryType = .checkmark
        }else{
            cell.check.isHidden = true
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        if selectRow[indexPath.row]{
            cell.accessoryType = .none
            selectRow[indexPath.row] = false
        }else{
            cell.accessoryType = .checkmark
            selectRow[indexPath.row] = true
        }
    }
    
    func viewSet(v:UIView) {
           v.layer.cornerRadius = 3
           v.layer.shadowColor = UIColor.black.cgColor
           v.layer.shadowOffset = CGSize.zero
           v.layer.shadowOpacity = 0.16
           v.layer.shadowRadius = 5
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        imgData = ["car1.png","car2.png","car3.png","car4.png"]
        // Do any additional setup after loading the view.
    }
    
    func getData(){
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/get_cust_service.php?idsvp_frk=\(id_svp2)")
        print("id = \(id_svp2)")
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
    
    func selectinsert(lic:String) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        let time = Date()
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let timer = format.string(from: time)
        
        let userDefault = UserDefaults.standard
        let id_cus = userDefault.string(forKey:"id_cus")!
        userDefault.set(lic, forKey: "cuslic")
        userDefault.set(result, forKey: "date_cus")
        userDefault.set(timer, forKey: "time_cus")
        userDefault.set(id_svp2, forKey: "id_svp")
        for i in 0...selectRow.count-1{
            if selectRow[i] == true{
                let stringData = "http://it.e-tech.ac.th/carconn/shop/selectinsert.php?idcus_frk=\(id_cus)&cus_lic=\(lic)&sv_name=\(nameData[i])&sv_time=\(timeData[i])&sv_price=\(priceData[i])&idsvp=\(id_svp2)&receive_date=\(result)&receive_time=\(timer)"
                
                let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let url = URL(string: allowData!)
                let data = try? Data(contentsOf: url!)
                
            }
        }
    }
    
    
    @IBAction func ok(_ sender: Any) {
        let alert = UIAlertController(title: "กรุณากรอกทะเบียนรถ", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: {TextField in
            TextField.placeholder = "ทะเบียนรถของคุณ..."
        }
        )
        alert.addAction(UIAlertAction(title: "ตกลง", style: .default, handler: {action in
            let lic = alert.textFields?[0]
            self.selectinsert(lic: lic!.text!)
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            let page = main.instantiateViewController(withIdentifier: "receive")
            self.present(page ,animated: true)
        }))
         self.present(alert,animated: true)
    }
    
    @IBAction func back(_ sender: UIButton) {
           navigationController?.popToRootViewController(animated: true)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

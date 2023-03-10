//
//  historyprovidershow.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 4/2/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class historyprovidershow: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 120
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:historyprovidershowTableViewCell = self.tablev.dequeueReusableCell(withIdentifier: "cellhisproshow") as! historyprovidershowTableViewCell
         cell.showname.text = name[indexPath.row]
         cell.showlic.text = lic[indexPath.row]
         cell.shownamecus.text = namecus[indexPath.row]
         cell.showtime.text = time[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = storyboard?.instantiateViewController(identifier: "historyprovider") as? historyprovider
        destinationVC?.name = name[indexPath.row]
        destinationVC?.lic = lic[indexPath.row]
        destinationVC?.namecus = namecus[indexPath.row]
        destinationVC?.time = time[indexPath.row]
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    var datee = ""
    var name:[String] = []
    var lic:[String] = []
    var namecus:[String] = []
    var time:[String] = []
    

    @IBOutlet weak var BGwhiteView: UIView!
    @IBOutlet weak var tablev: UITableView!
    @IBOutlet weak var date: UILabel!
    override func viewDidLoad() {
        date.text = datee
        bgWhiteSet()
        super.viewDidLoad()
        //bgWhiteSet()
        getData()

        // Do any additional setup after loading the view.
    }
    
    func bgWhiteSet() {
           tablev.backgroundColor = UIColor.white
           BGwhiteView.layer.shadowColor = UIColor.black.cgColor
           BGwhiteView.layer.shadowOffset = CGSize.zero
           BGwhiteView.layer.shadowOpacity = 0.16
           BGwhiteView.layer.shadowRadius = 10
           BGwhiteView.layer.cornerRadius = 15
       }

    
    func getData() {
    
    let userDefault = UserDefaults.standard
    let id_svp = userDefault.string(forKey: "id_svp")!
    
    let stringData = "http://it.e-tech.ac.th/carconn/shop/historyprovidershow.php?idlvd_frk=\(id_svp)&receive_date=\(datee)"
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
                    self.namecus.append(data["name_cus"] as! String)
                    self.time.append(data["receive_time"] as! String)
                }
                DispatchQueue.main.async {
                    self.tablev.reloadData()
                }
            }
        }.resume()
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

}

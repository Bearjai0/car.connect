//
//  historyprovider.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 4/2/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class historyprovider: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    var name = ""
    var lic = ""
    var namecus = ""
    var time = ""
    
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:historyproviderTableViewCell = self.tablev.dequeueReusableCell(withIdentifier: "cellhispro") as! historyproviderTableViewCell
        cell.showdate.text = date[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = storyboard?.instantiateViewController(identifier: "historyproshow") as? historyprovidershow
        destinationVC?.datee = date[indexPath.row]
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
@IBOutlet weak var BGwhiteView: UIView!
    override func viewDidLoad() {
        bgWhiteSet()
        super.viewDidLoad()
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
    @IBOutlet weak var tablev: UITableView!
    var date:[String] = []
    
     override func viewWillAppear(_ animated: Bool) {
                   //getData()
                   tablev.reloadData()
           }
    
 func getData() {
            
            let userDefault = UserDefaults.standard
            let id_svp = userDefault.string(forKey: "id_svp")!
            
            let stringData = "http://it.e-tech.ac.th/carconn/shop/historyprovider.php?idlvd_frk=\(id_svp)"
                print(stringData)
                let allowData = stringData.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let url = URL(string: allowData!)
                URLSession.shared.dataTask(with: url!){(data,response,error) in
    //                if error != nil{
    //                    print("error")
                    if data!.count <= 5 {
                    }else{
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                        print(json!.count)
                        for i in 0...json!.count-1{
                            let data:[String:Any] = json![i] as! [String : Any]
                            self.date.append(data["receive_date"] as! String)
                        }
                        DispatchQueue.main.async {
                            self.tablev.reloadData()
                        }
                    }
                }.resume()
            }


}

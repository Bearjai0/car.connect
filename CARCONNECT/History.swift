//
//  History.swift
//  AppAuth
//
//  Created by MAC923_47 on 18/1/2563 BE.
//

import UIKit

class History: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var id_car = ""
    @IBOutlet weak var BGwhiteView: UIView!
    
     func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
           return 1
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return name.count
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
//       override func viewWillAppear(_ animated: Bool) {
//           name.removeAll()
//           lic.removeAll()
//           date.removeAll()
//        time.removeAll()
//        price.removeAll()
//           //getData()
//           tableV.reloadData()
//       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:HistoryTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! HistoryTableViewCell
            cell.name_svp.text = name[indexPath.row]
            cell.cus_lic.text = lic[indexPath.row]
            cell.receive_date.text = date[indexPath.row]
            cell.receive_time.text = time[indexPath.row]
           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = storyboard?.instantiateViewController(identifier: "show_history") as? HistoryReceive
        destinationVC?.id_car = lic[indexPath.row]
        destinationVC?.receivedate = date[indexPath.row]
        destinationVC?.receivetime = time[indexPath.row]
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    
    var name:[String] = []
    var lic:[String] = []
    var date:[String] = []
    var time:[String] = []
    var price:[String] = []
    

    
    @IBOutlet weak var tableV: UITableView!

    override func viewDidLoad() {
        bgWhiteSet()
        getData()
        //self.tableV.reloadData()
        //super.viewDidLoad()
    }
    func getData() {
        
        let userDefault = UserDefaults.standard
        let id_cus = userDefault.string(forKey: "id_cus")!
        
        let stringData = "http://it.e-tech.ac.th/carconn/shop/historyshow.php?idcus_frk=\(id_cus)&cus_lic=\(id_car)"
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
                        self.name.append(data["name_svp"] as! String)
                        self.lic.append(data["sv_name"] as! String)
                        self.date.append(data["receive_date"] as! String)
                        self.time.append(data["receive_time"] as! String)
                    }
                    DispatchQueue.main.async {
                        self.tableV.reloadData()
                    }
                }
            }.resume()
        }
    @IBAction func back(_ sender: UIButton) {
           navigationController?.popToRootViewController(animated: true)
       }
    func bgWhiteSet() {
           tableV.backgroundColor = UIColor.white
           BGwhiteView.layer.shadowColor = UIColor.black.cgColor
           BGwhiteView.layer.shadowOffset = CGSize.zero
           BGwhiteView.layer.shadowOpacity = 0.16
           BGwhiteView.layer.shadowRadius = 10
           BGwhiteView.layer.cornerRadius = 15
       }
}


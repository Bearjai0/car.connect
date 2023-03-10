//
//  indexHistory.swift
//  AppAuth
//
//  Created by Admin_DeviOS on 23/1/2563 BE.
//

import UIKit

class indexHistory: UIViewController ,UITableViewDataSource,UITableViewDelegate{

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
//               showlicc.removeAll()
//               idcus_frk.removeAll()
//               idlvd_frk.removeAll()
//               getData()
               tableV.reloadData()
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:indexHistoryTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! indexHistoryTableViewCell
        viewSet(v: cell.bgView)
            cell.cus_lic.text = lic[indexPath.row]
           return cell
       }
    
    func viewSet(v:UIView) {
        v.layer.cornerRadius = 3
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize.zero
        v.layer.shadowOpacity = 0.16
        v.layer.shadowRadius = 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destinationVC = storyboard?.instantiateViewController(identifier: "historyS") as? History
        destinationVC?.id_car = lic[indexPath.row]
    self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    
    var name:[String] = []
    var lic:[String] = []
    var date:[String] = []
    var time:[String] = []
    var price:[String] = []
    

    
    @IBOutlet weak var tableV: UITableView!
    

    override func viewDidLoad() {
        getData()
        
        super.viewDidLoad()
    }
    func getData() {
        
        let userDefault = UserDefaults.standard
        let id_cus = userDefault.string(forKey: "id_cus")!
        
        let stringData = "http://it.e-tech.ac.th/carconn/shop/history.php?idcus_frk=\(id_cus)"
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
                        self.lic.append(data["cus_lic"] as! String)
                    }
                    DispatchQueue.main.async {
                        self.tableV.reloadData()
                    }
                }
            }.resume()
        }

}

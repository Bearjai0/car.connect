//
//  showreview.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 21/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class showreview: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var id_svp = ""

    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var BGwhiteView: UIView!
       var score:[String] = []
       var name:[String] = []
       func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
            return 1
        }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return score.count
        }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
        
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:showreviewTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! showreviewTableViewCell
            cell.score.text = score[indexPath.row]
           cell.name_cus.text = name[indexPath.row]
        
        if score[indexPath.row] == "5"{
            cell.imgstar.image = UIImage(named: "star5.png")
        }else if score[indexPath.row] == "4"{
            cell.imgstar.image = UIImage(named: "star4.png")
        }else if score[indexPath.row] == "3"{
            cell.imgstar.image = UIImage(named: "star3.png")
        }else if score[indexPath.row] == "2"{
            cell.imgstar.image = UIImage(named: "star2.png")
        }else{
            cell.imgstar.image = UIImage(named: "star1.png")
        }
        

            return cell
        }
        
        override func viewDidLoad() {
            bgWhiteSet()
        super.viewDidLoad()
            getData()
        }
        
    func bgWhiteSet() {
        tableV.backgroundColor = UIColor.white
        BGwhiteView.layer.shadowColor = UIColor.black.cgColor
        BGwhiteView.layer.shadowOffset = CGSize.zero
        BGwhiteView.layer.shadowOpacity = 0.16
        BGwhiteView.layer.shadowRadius = 10
        BGwhiteView.layer.cornerRadius = 15
    }

        
        func getData(){
            print("id svp : \(id_svp)")
            let urlx = "http://it.e-tech.ac.th/carconn/shop/showreview.php?idsvp_frk=\(id_svp)"
            
            let allowData = urlx.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            var url = URL(string: allowData!)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if data!.count <= 5 {
                }else{
                    let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                    
                    for i in 0...json!.count-1{
                        if json![i] is [String:Any]{
                            let data:[String:Any] = json![i] as! [String : Any]
                            
                            self.score.append(data["score"] as! String)
                           self.name.append(data["name_cus"] as! String)
                    }
                    DispatchQueue.main.async {
                         
                        self.tableV.reloadData()
                    }
                    }
                }
            }.resume()
            
        }

     @IBAction func back(_ sender: UIButton) {
           navigationController?.popToRootViewController(animated: true)
       }
}

//
//  employee_Show.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 30/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class employee_Show: UIViewController, UITableViewDelegate,UITableViewDataSource {

   @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var BGwhiteView: UIView!
       
       var name:[String] = []
       var type:[String] = []
    var id_emp:[String] = []
    var imgData:[String] = []
    var count = 0
   
   
       
       func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
           return 1
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return name.count
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell:employee_ShowTableViewCell = self.tableV.dequeueReusableCell(withIdentifier: "cell") as! employee_ShowTableViewCell
           cell.name.text = name[indexPath.row]
           cell.type.text = type[indexPath.row]
        cell.edit1.tag = Int(id_emp[indexPath.row])!
            cell.imageE.image = UIImage(named: imgData[count])
        if count < 3 {
            count+=1
        }else{
            count=0
        }
           //cell.time.text = timeData[indexPath.row]
           //cell.edit1.tag = Int(id_ser[indexPath.row])!
           return cell
       }
//       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//           let destinationVC = storyboard?.instantiateViewController(identifier: "emp_Edit") as? employee_Edit
//           destinationVC?.id_emp = id_emp[indexPath.row]
//           self.navigationController?.pushViewController(destinationVC!, animated: true)
//           //performSegue(withIdentifier: "show_data", sender: self)
//       }
    
    
    
       override func viewDidLoad() {
       super.viewDidLoad()
//           getData()
        bgWhiteSet()
        imgData = ["user1.png","user2.png","user3.png","user4.png"]
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
         type.removeAll()
         getData()
         tableV.reloadData()
     }
       
       func getData(){
           let userdefaults:UserDefaults = UserDefaults.standard
           let id_svp:String = userdefaults.object(forKey: "id_svp") as! String
           let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/employeeshow.php?idsvp_frk=\(id_svp)")
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
//               if error != nil{
//                   print("error")
            if data!.count <= 17 {
               }else{
                   let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                   print(json!.count)
                   for i in 0...json!.count-1{
                       if json![i] is [String:Any]{
                           let data:[String:Any] = json![i] as! [String : Any]
                           
                        self.id_emp.append(data["id_emp"] as! String)
                           self.name.append(data["name_emp"] as! String)
                        
                        self.type.append(data["type_emp"] as! String)
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
            let page = segue.destination as! employee_Edit
            page.id_emp = String((sender as! UIButton).tag)
        }
    }

}

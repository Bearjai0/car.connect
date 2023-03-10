//
//  mapshow.swift
//  CARCONNECT
//
//  Created by MAC923_48 on 18/12/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapshow: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var whiteTopView: UIView!
    @IBOutlet weak var whiteBottomView: UIView!
    @IBOutlet weak var gardientView: UIView!
    @IBOutlet weak var bgButtSendView: UIView!
    @IBOutlet weak var goButt: UIButton!
    
    @IBOutlet weak var topImgButt: UIButton!
    @IBOutlet weak var BottomImgButt: UIButton!
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var timeTopLb: UILabel!
    @IBOutlet weak var timeBottomLb: UILabel!
    @IBOutlet weak var timeSelectLb: UILabel!
    
    var top:String = ""
    var bottom:String = ""
    var select:String = ""
    
    let userDefaults:UserDefaults = UserDefaults.standard
    var id_svp = ""
    var name_svp:String = ""
    var lat:String = ""
    var long:String = ""
    
    var cus_name:String = ""
    var carcare_name:String = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    let color = UIColor(red: 239/255, green: 80/255, blue: 67/255, alpha: 1.00)
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var pinAnnotationView:MKPinAnnotationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mapData()
//        getData()
        print("lati is \(lat)")
        print("long is \(long)")

        top = "bicycle.png"
        bottom = "walking.png"
        select = "car.png"
        
        setImgButt(b:goButt, n:"send.png")
        setImgButt(b:topImgButt, n:top)
        setImgButt(b:BottomImgButt, n:bottom)
        setImgImgView(i: selectImg, n: select)
        
        data()
        
        mapView.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        cus_name = userDefaults.object(forKey: "name_cus") as! String
        if lat != "" {
            let la = lat
            let lon = long
            latitude = NumberFormatter().number(from: la)!.doubleValue
            longitude = NumberFormatter().number(from: lon)!.doubleValue
            print("klklkkl")
        }else{
            carcare_name = "carcar"
            latitude = 13.4059582
            longitude = 101.0396571
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sourceLocation: CLLocationCoordinate2D = locationManager.location!.coordinate
        let destinationLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        sourceMapItem.name = cus_name
        destinationMapItem.name = carcare_name
        
        MKMapItem.openMaps(with: [sourceMapItem, destinationMapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay:MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0

        return renderer
    }
    
    @IBAction func topButt(_ sender: Any) {
        setImgButt(b: topImgButt, n: select)
        setImgImgView(i: selectImg, n: top)
        
        let a = top
        top = select
        select = a
        
        let b = timeTopLb.text
        timeTopLb.text = timeSelectLb.text
        timeSelectLb.text = b
    }
    @IBAction func bottomButt(_ sender: Any) {
        setImgButt(b: BottomImgButt, n: select)
        setImgImgView(i: selectImg, n: bottom)
        
        let a = bottom
        bottom = select
        select = a
        
        let b = timeBottomLb.text
        timeBottomLb.text = timeSelectLb.text
        timeSelectLb.text = b
    }
    
    func data() {
//        cus_name = (userDefaults.object(forKey: "cus_name") as! String?)!
        
        timeTopLb.text = "20 min"
        timeBottomLb.text = "25 min"
        timeSelectLb.text = "15 min"
    }
    
    func mapData() {
        let url = URL(string: "http://it.e-tech.ac.th/carconn/shop/show_svp.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error")
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                
                let seid = self.userDefaults.object(forKey: "select_id") as! String
                
                for i in 0...json!.count-1{
                    if json![i] is [String:Any]{
                        let data:[String:Any] = json![i] as! [String : Any]
                        
                        if seid == (data["id_svp"] as! String) {
                            self.name_svp = (data["name_svp"] as! String)
                            self.lat = (data["latitude"] as! String)
                            self.long = (data["longitude"] as! String)
                            
                        }
                    }
                }
                print("nn",self.long)
                self.userDefaults.set(self.lat, forKey: "l")
                self.userDefaults.set(self.long, forKey: "lo")
            }
        }.resume()
    }
    
    func getData(){
        print(self.id_svp)
        let seid = userDefaults.object(forKey: "select_id") as! String
        let id = userDefaults.stringArray(forKey: "id_svp")!
        let name = userDefaults.stringArray(forKey: "name_svp")!
        let laa = userDefaults.stringArray(forKey: "latitude")!
        let loo = userDefaults.stringArray(forKey: "longitude")!
        for i in 0...id.count-1 {
            if seid == id[i] {
                self.carcare_name = name[i]
                self.lat = laa[i]
                self.long = loo[i]
            }
        }
        print("ooooo",self.lat, self.long, self.carcare_name)
                        
                    
    }

    
    func setImgButt(b:UIButton, n:String){
        b.setImage(UIImage(named: n), for: .normal)
    }
    func setImgImgView(i:UIImageView, n:String) {
        i.image = UIImage(named: n)
    }
}

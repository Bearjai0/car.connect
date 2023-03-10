//
//  singInCustomer.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 6/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class singInCustomer: UIViewController, UITextFieldDelegate ,LoginButtonDelegate ,GIDSignInDelegate{
    
    var ref: DatabaseReference!
    var Handle: DatabaseHandle!
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log into Google: ", err)
            return
        }
        
        print("Successfully logged into Google", user)
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if let err = error {
                print("Failed to create a Firebase User with Google account: ", err)
                return
            }
            
            guard let uid = user?.user.uid else { return }
            print("Successfully logged into Firebase with Google", uid)
            
            guard let name = user?.user.displayName else { return }
            guard let email = user?.user.email else { return }
            guard let phone = user?.user.photoURL else { return }
            
            print("ไรไฟะ \(name) \(email) \(phone)")
        })
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil{
            print(error!)
            return
        }
        
        let accessToken = AccessToken.current
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email,gender, picture.type(large)"]).start { (connection, result, err) in
            
            
            
            
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
            
            guard let data = result as? [String:Any] else { return }
            print(data)
            let u_id = data["id"] as! String
            let u_name = data["name"] as! String
            let email = data["email"] as! String
            
            let dataURL = "http://it.e-tech.ac.th/carconn/shop/regisUser.php?name_cus=\(u_name)&email_cus=\(email)&password_cus=\(u_id)&tel_cus=0800000000"
            print(dataURL)
            let allowData = dataURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let dataurl = URL(string: allowData!)
            let data2 = try? Data(contentsOf: dataurl!)
            print("data 2 is \(data2)")
            let main = UIStoryboard(name: "Main", bundle: nil)
            let page = main.instantiateViewController(withIdentifier: "controCus")
            self.present(page,animated: true)
            let userDefault = UserDefaults.standard
            userDefault.set(u_id, forKey: "id_cus")
            userDefault.set("2", forKey: "login_status")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Did log out of facebook.")
    }
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var fbLoginKit: UIButton!
    
    @IBAction func signIn(_ sender: Any) {
        if !checkForErrors() {
            let dataurl = "http://it.e-tech.ac.th/carconn/shop/login.php?name_cus=\(user.text!)&password_cus=\(pass.text!)"
            let allowData = dataurl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let url = URL(string: dataurl)
            let data = try? Data(contentsOf: url!)
            let stringData = String.init(data: data!, encoding: String.Encoding.utf8)
            print(stringData!)
            if stringData=="Error"{
                let alert = UIAlertController(title: "แจ้งเตือน", message: "เข้าสู่ระบบไม่สำเร็จ", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
                self.present(alert,animated: true)
                alert.addAction(ok)
            }else{
                let alert = UIAlertController(title: "แจ้งเตือน", message: "เข้าสู่ระบบสำเร็จ", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "ตกลง", style: .default, handler: {(ok:UIAlertAction) in
                let main = UIStoryboard(name: "Main", bundle: nil)
                let page = main.instantiateViewController(withIdentifier: "controCus")
                    self.present(page,animated: true)
                    let userDefault = UserDefaults.standard
                    userDefault.set(stringData!, forKey: "id_cus")
                    userDefault.set(stringData!, forKey: "name_cus")
                })
                    self.present(alert,animated: true)
                    alert.addAction(ok)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.signIn()
//        
        user.tintColor = .black
        pass.tintColor = .black
        
//        let loginButton = FBLoginButton()
//        view.addSubview(loginButton)
//        loginButton.frame = CGRect(x: 56, y: 470, width: 150, height: 43)
//
//
//        let googleButton = GIDSignInButton()
//        googleButton.frame = CGRect(x: 210, y: 468, width: 150, height: 45)
//        view.addSubview(googleButton)
//
//
//
//        loginButton.delegate = self
//        loginButton.permissions = ["email","public_profile"]
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func signUp(_ sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let page = main.instantiateViewController(withIdentifier: "signUpCus")
        self.present(page,animated: true)
    }
    
    func checkForErrors() -> Bool {
        var errors = false
            if user.text!.isEmpty {
                errors = true
            let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกชื่อผู้ใช้", preferredStyle: .alert)
            self.present(alert,animated: true)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
            alert.addAction(ok)
        }else if pass.text!.isEmpty{
                errors = true
            let alert = UIAlertController(title: "แจ้งเตือน", message: "กรุณากรอกรหัสผ่าน", preferredStyle: .alert)
            self.present(alert,animated: true)
            let ok = UIAlertAction(title: "ตกลง", style: .default, handler: nil)
            alert.addAction(ok)
    
        }
        return errors
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
     @IBAction func back(_ sender: UIButton) {
           navigationController?.popToRootViewController(animated: true)
       }
    
}

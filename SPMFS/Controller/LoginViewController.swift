//
//  ViewController.swift
//  SPMFS


import UIKit
import TextFieldEffects
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    var responder = [Responder]()
    var firstName = ""

    
    //Firebase Instance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       //Delegates
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        

        //customize login button
        loginBtn.layer.cornerRadius = 0.1 * loginBtn.bounds.size.width
        loginBtn.clipsToBounds = true
 
        
      
        
        
      
    }
    
    @IBAction func tapGuestureClicked(_ sender: UITapGestureRecognizer) {
        
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }
    
    //MARK: - Login User
    @IBAction func loginPressedBtn(_ sender: UIButton) {
        
        if usernameTextField.text == "" {
            
            errorLabel.text = "Enter the username"
            
            
        }
        else if passwordTextField.text == "" {
            
            errorLabel.text = "Enter the password"
            
            
        } else {
            
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()

        
        //responder index var
        SVProgressHUD.show(withStatus: "Signing in...")
        
        //Todo: Login user here
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            // if the user is exist
            if error == nil {
    
            //Firebase ref
            let FirebaseRef = Database.database().reference(fromURL: "https://spmfs-fa76a.firebaseio.com/")
           
            //Database ref
            let DBRef = FirebaseRef.child("responders")
            //fetch data
                DBRef.observe(.childAdded, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String : AnyObject] {
                        
                        let resp = Responder()
                        resp.email = dictionary["email"] as? String
                        resp.first_name = dictionary["first_name"] as? String
                        
                        self.responder.append(resp)
                        
                        if resp.email == self.usernameTextField.text! {
                            self.firstName = resp.first_name!
                            //to tran
                            self.performSegue(withIdentifier: "goToSearchForPatient", sender: self)
                            }
                            
                        }
                        

                    
                    }, withCancel: nil)
                

                print("The second counter \(self.responder.count)")
                
                
             
                }
                
            //if it is not exist
            else { self.errorLabel.text = "Username or Password in incorrect"
            SVProgressHUD.dismiss()
            }
            
        }
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let VC = segue.destination as! SearchForPatientViewController
        VC.responderName = firstName
    }
    
    



}


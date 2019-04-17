//
//  SearchForPatientViewController.swift


import UIKit
import SVProgressHUD
import Firebase

class SearchForPatientViewController: UIViewController, UITextFieldDelegate {
    
    var responderName = ""
    let patient = Patient()
    let patientFile = PatientFile()
    var checkIfItsCorrectLength = false
    
    

    
    @IBOutlet weak var patientSearchTextField: UITextField?
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var backgroundImag: UIImageView!
    
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //To hide back in the nav bar
        self.navigationItem.setHidesBackButton(true, animated:true);
        SVProgressHUD.dismiss()
        self.title = responderName
        

        
        //customize login button
        searchBtn.layer.cornerRadius = 0.1 * searchBtn.bounds.size.width
        searchBtn.clipsToBounds = true
        
        //patient Search TextField Delegate
        patientSearchTextField?.delegate = self
        
        
        //Tap Gusture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureHandler))
        
        //config image
        backgroundImag.isUserInteractionEnabled = true
        backgroundImag.addGestureRecognizer(tapGesture)
        


    }
    
    @objc func tapGestureHandler() {
        
       patientSearchTextField?.resignFirstResponder()

    }
    
    
    @IBAction func signoutPressed(_ sender: UIBarButtonItem) {
        
       
            SVProgressHUD.show(withStatus: "Signing out...")

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
         do {
            SVProgressHUD.dismiss()
            try Auth.auth().signOut()
            //to get back to the previous VC
            _ = self.navigationController?.popViewController(animated: false)
                } catch { print(error) }
            }

        
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        
//        if checkIfItsCorrectLength {
        if patientSearchTextField?.text != "" {
        patientSearchTextField?.resignFirstResponder()
        checkIfThePatientIsExist()
        } else {
            errorLabel.text = "Enter the patient id"
        }
//        } else {
//            errorLabel.text = "Enter Complete Id"
//        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // if more than the number of charechter
        if range.length + range.location > ((patientSearchTextField?.text?.count)!) {
            return false
        }
        else {
            let newLength = (patientSearchTextField?.text?.count)! + string.count - range.length
            // to check if the textfield text length is = 10
            if newLength >= 10 {
                textField.textColor = UIColor.green
                checkIfItsCorrectLength = true
            } else {
                textField.textColor = UIColor.black
                checkIfItsCorrectLength = false

            }
            
            return newLength <= 10
        }
    }
    
    
    func searchPatientFile(index : Int) {
        
        //Firebase ref
        let FirebaseRef = Database.database().reference(fromURL: "https://spmfs-fa76a.firebaseio.com/")
        print("the index : \(index)")
        //Database ref
        let DBRef = FirebaseRef.child("patient_files").child("\(index)")
        //fetch data
        DBRef.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                self.patientFile.patientId = dictionary["patient_id"] as? Int
                self.patientFile.antibiotics = dictionary["antibiotics"] as? String
                self.patientFile.permanentDisease = dictionary["permanent_disease"] as? String
                self.patientFile.note =  dictionary["note"] as? String
                
                SVProgressHUD.dismiss()
                
            self.performSegue(withIdentifier: "goToPatientFile", sender: self)

            }
            
            
        }, withCancel: nil)
        
        
    }


    func checkIfThePatientIsExist(){
    
        SVProgressHUD.show(withStatus: "Loading")
        var index = 0
        var checkIfTheUserExict = false
        //
        var patientsArray = [Patient]()
        //Firebase ref
        let FirebaseRef = Database.database().reference(fromURL: "https://spmfs-fa76a.firebaseio.com/")
        
        //Database ref
        let DBRef = FirebaseRef.child("patients")
        //fetch data
        DBRef.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                self.patient.patientId = dictionary["id"] as? Int
                self.patient.firstName = dictionary["first_name"] as? String
                self.patient.lastName = dictionary["last_name"] as? String
                self.patient.relativePhoneNum = dictionary["relative_phone"] as? Int
                
                patientsArray.append(self.patient)
                if self.patient.patientId == Int((self.patientSearchTextField?.text!)!)  {
                    
                    checkIfTheUserExict = true
                    self.searchPatientFile(index: index)
                  

                }  else { index = index + 1 }
                
            }
           
            
            
        }, withCancel: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {

        if checkIfTheUserExict == false {
            SVProgressHUD.dismiss()
            self.errorLabel.text = "The patient is not exict"
            
            }
        }
    
    
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let VC = segue.destination as! PatientFileVC
        VC.patient = self.patient
        VC.patientFile = self.patientFile
    }

    


    
}

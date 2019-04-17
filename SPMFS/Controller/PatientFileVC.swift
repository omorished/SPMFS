//


import UIKit

class PatientFileVC: UIViewController {
    
    var patient = Patient()
    var patientFile = PatientFile()

    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientIDLabel: UILabel!
    
    @IBOutlet weak var antibioticsBtn: UIButton!
    @IBOutlet weak var permenantDiseaseBtn: UIButton!
    @IBOutlet weak var noteBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientNameLabel.text = "Patient name/ \(patient.firstName!) \(patient.lastName!)"
        //patientIDLabel.text = "Patient ID/ \(patient.patientId!)" 
        
        

    }
    
    
    @IBAction func antiBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToAnti", sender: self)
    }
    
    @IBAction func permBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToPerm", sender: self)

    }
    
    
    @IBAction func noteBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToNote", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToAnti" {
        let VC = segue.destination as! AntibioticsTV
        VC.antiArray = converteTextToArray(text: patientFile.antibiotics!)
        }
        else if segue.identifier == "goToPerm" {
        let VC = segue.destination as! PermanentTVC
        VC.permArray = converteTextToArray(text: patientFile.permanentDisease!)


        }
        else if segue.identifier == "goToNote" {
        let VC = segue.destination as! NoteTVC
        VC.noteArray = converteTextToArray(text: patientFile.note!)


        }
    }
    
    func converteTextToArray(text : String) -> [String] {
        
        let textArray : [String] = text.components(separatedBy: ", ")
        
        return textArray
    }

}

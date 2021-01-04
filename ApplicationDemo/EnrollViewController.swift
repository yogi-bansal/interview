//
//  EnrollViewController.swift
//  ApplicationDemo
//
//  Created by YOGESH BANSAL on 02/01/21.
//

import UIKit
import CoreData

class EnrollViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var dateOfBirth: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var homeTown: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var telephoneNumber: UITextField!
    @IBOutlet var imageView: UIImageView!
    var isImagePick = false
    
    var genderOption = ["Male", "Female"]
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        pickerView.delegate = self
        //pickerView.dataSource = self
        self.setBorderColor()
        self.setDelegates()
        setupTextFields()
        gender.inputView = pickerView
        pickerView.isHidden = true
    }
    
    
    func setBorderColor(){
        firstName.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        lastName.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        dateOfBirth.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        gender.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        state.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        country.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        phoneNumber.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        telephoneNumber.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
        homeTown.layer.borderColor = #colorLiteral(red: 0.2250072956, green: 0.6567959785, blue: 0.8611732125, alpha: 0.6980392157)
    }
    
    func setDelegates(){
        gender.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        state.delegate = self
        country.delegate = self
        homeTown.delegate = self
        telephoneNumber.delegate = self
        dateOfBirth.delegate = self
        phoneNumber.delegate = self
    }
   
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOption.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOption[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = genderOption[row]
        pickerView.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == gender {
            pickerView.isHidden = false
        }
        
        return !(textField == gender)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
    //                           replacementString string: String) -> Bool
    //    {
    //        if textField == gender {
    //            let maxLength = 1
    //            let currentString: NSString = gender.text! as NSString
    //            let newString: NSString =
    //                currentString.replacingCharacters(in: range, with: string) as NSString
    //            return newString.length <= maxLength
    //        }
    //        return true
    //    }
    
    func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        telephoneNumber.inputAccessoryView = toolbar
        phoneNumber.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    
    @IBAction func addBtn(_ sender: Any) {
        if firstName.text == "" {
            showAlert(message: "Please enter the first name")
            return
        } else if lastName.text == "" {
            showAlert(message: "Please enter the last name")
            return
        } else if dateOfBirth.text == "" {
            showAlert(message: "Please enter the date of birth")
            return
        } else if gender.text == "" {
            showAlert(message: "Please enter the gender")
            return
        } else if country.text == "" {
            showAlert(message: "Please enter the country")
            return
        } else if state.text == "" {
            showAlert(message: "Please enter the state")
            return
        } else if homeTown.text == "" {
            showAlert(message: "Please enter the home town")
            return
        } else if phoneNumber.text == "" {
            showAlert(message: "Please enter the phone number")
            return
        } else if telephoneNumber.text == "" {
            showAlert(message: "Please enter the telephone number")
            return
        } else if !self.search(predictName: phoneNumber.text!) {
            showAlert(message: "This number is alreasy exist")
            return
        }
        
        
        
        
        let user = UserData(firstName: firstName.text, lastName: lastName.text, gender: gender.text, homeTown: homeTown.text, state: state.text, country: country.text, phoneNumber: phoneNumber.text, telephoneNumber: telephoneNumber.text, dob: dateOfBirth.text, image: imageView.image)
        user.saveDataIn(context: self.context)
        self.showAlert(message: "User Data Saved Successfully")
        firstName.text = ""
        lastName.text = ""
        state.text = ""
        country.text = ""
        dateOfBirth.text = ""
        homeTown.text = ""
        telephoneNumber.text = ""
        phoneNumber.text = ""
        gender.text = ""
        imageView.image = UIImage(named: "image")
    }
    
    func search(predictName:String) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let predicate = NSPredicate(format: "phoneNumber = %@", predictName)
            request.predicate = predicate
            let result = try context.fetch(request)
            return (result as! [NSManagedObject]).count == 0
            
            
        } catch {
            print("Fetching data Failed")
        }
        return false
    }
    
    
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Title", message: message, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func pickImage(_ sender: UITapGestureRecognizer) {
        
        ImagePickerManager().pickImage(self){ image in
            
            self.imageView.image = image
            self.isImagePick = true
        }
        
    }
    
}





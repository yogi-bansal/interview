//
//  UserData.swift
//  ApplicationDemo
//
//  Created by YOGESH BANSAL on 03/01/21.
//

import Foundation
import UIKit
import CoreData

struct UserData {
    var firstName: String!
    var lastName: String!
    var gender: String!
    var homeTown: String!
    var state: String!
    var country: String!
    var phoneNumber: String!
    var telephoneNumber: String!
    var dob: String!
    var image: UIImage!
    private var userDBObj: NSManagedObject!
    
    init(
        firstName: String!,
        lastName: String!,
        gender: String!,
        homeTown: String!,
        state: String!,
        country: String!,
        phoneNumber: String!,
        telephoneNumber: String!,
        dob: String!,
        image: UIImage!
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.homeTown = homeTown
        self.state = state
        self.country = country
        self.phoneNumber = phoneNumber
        self.telephoneNumber = telephoneNumber
        self.dob = dob
        self.image = image
    }
    
    func saveDataIn(context:NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        
        
        let UserDBObj = NSManagedObject(entity: entity!, insertInto: context)
        UserDBObj.setValue(firstName, forKey: "firstName")
        UserDBObj.setValue(lastName, forKey: "lastName")
        UserDBObj.setValue(phoneNumber, forKey: "phoneNumber")
        UserDBObj.setValue(country, forKey: "country")
        UserDBObj.setValue(dob, forKey: "dob")
        UserDBObj.setValue(gender, forKey: "gender")
        UserDBObj.setValue(homeTown, forKey: "hometown")
        UserDBObj.setValue(state, forKey: "state")
        UserDBObj.setValue(telephoneNumber, forKey: "telephoneNumber")
        UserDBObj.setValue(image.jpegData(compressionQuality: 1.0), forKey: "image")
        do {
            try context.save()
            
        } catch {
            print("Storing data Failed")
        }
    }
    
    
    init(UserDBObj: NSManagedObject) {
        self.userDBObj = UserDBObj
        self.firstName = UserDBObj.value(forKey: "firstName") as? String
        self.lastName = UserDBObj.value(forKey: "lastName") as? String
        self.phoneNumber = UserDBObj.value(forKey: "phoneNumber") as? String
        self.country = UserDBObj.value(forKey: "country") as? String
        self.dob = UserDBObj.value(forKey: "dob") as? String
        self.gender = UserDBObj.value(forKey: "gender") as? String
        self.homeTown = UserDBObj.value(forKey: "hometown") as? String
        self.state = UserDBObj.value(forKey: "state") as? String
        self.telephoneNumber = UserDBObj.value(forKey: "telephoneNumber") as? String
        self.image = UIImage(data: (UserDBObj.value(forKey: "image") as? Data)!)
        
    }
    
    func deleteUser(context:NSManagedObjectContext, onComplete: ((_ isDone: Bool) -> Void) ){
        do {
            context.delete(self.userDBObj)
            try context.save()
            onComplete(true)
        } catch{
            onComplete(false)
            print("Delete Data failed")
        }
    }
    
    
    
}

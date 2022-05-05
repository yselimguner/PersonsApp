//
//  UpdatePersonViewController.swift
//  PersonsCoreDataProject
//
//  Created by Yavuz Güner on 1.05.2022.
//

import UIKit

class UpdatePersonViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var personNumberTextfield: UITextField!
    @IBOutlet weak var personNameTextfield: UITextField!
    
    var person:Persons?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person{
            personNameTextfield.text = p.person_name
            personNumberTextfield.text = p.person_number
        }
    }
    

    @IBAction func updateButton(_ sender: Any) {
        
        if let p = person, let name = personNameTextfield, let tel = personNumberTextfield{
            
            p.person_name = name.text
            p.person_number = tel.text
            
            appDelegate.saveContext()
    }
}

}

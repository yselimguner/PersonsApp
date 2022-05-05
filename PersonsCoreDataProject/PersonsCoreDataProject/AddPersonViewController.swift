//
//  AddPersonViewController.swift
//  PersonsCoreDataProject
//
//  Created by Yavuz Güner on 1.05.2022.
//

import UIKit

class AddPersonViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var personNumberTextfield: UITextField!
    @IBOutlet weak var personNameTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        //if let yapısını kontrol etmek için yaptık.
        if let name = personNameTextfield, let tel = personNumberTextfield{
            
            let person = Persons(context: context)
            person.person_name = name.text
            person.person_number = tel.text
            
            appDelegate.saveContext()
        }
        
        
        
    }
    
    
}

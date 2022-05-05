//
//  DetailsPersonViewController.swift
//  PersonsCoreDataProject
//
//  Created by Yavuz Güner on 1.05.2022.
//

import UIKit

class DetailsPersonViewController: UIViewController {

    @IBOutlet weak var personNumberLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!

    var person:Persons?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let p = person{
            personNameLabel.text = p.person_name
            personNumberLabel.text = p.person_number
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

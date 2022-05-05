//
//  ViewController.swift
//  PersonsCoreDataProject
//
//  Created by Yavuz Güner on 1.05.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var personsTableView: UITableView!
    
    var personsList = [Persons]()
    
    var didDoSearch = false
    
    var searchWord :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        personsTableView.delegate = self
        personsTableView.dataSource = self
        
        searchBar.delegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if didDoSearch {
            doSearch(person_name: searchWord!)
        }else {
            allPersonsTake()
        }
        
        allPersonsTake() //Kaydettikten sonra ara yüze daha tam olarak yansıtılmaz o yüzden 1 işlem daha yapacağız. reload data'yı yazmamız lazım kaydetmek için.
        personsTableView.reloadData()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Burası bildiğimiz üzere geçişleri tetikliyor. 2 geçişimiz var. Detay ve güncelle sayfası. İkisinde de indexpath.row vardır.
        
        let index = sender as? Int
        
        if segue.identifier == "toDetail" {
            let toVC = segue.destination as! DetailsPersonViewController
            toVC.person = personsList[index!]
        }
        if segue.identifier == "toUpdate" {
            let toVC = segue.destination as! UpdatePersonViewController
            toVC.person = personsList[index!]
        }
    }
    
    func allPersonsTake(){
        do {
            personsList = try context.fetch(Persons.fetchRequest())
        }catch{
            print(error)
        }
    }
    
    func doSearch(person_name:String){
        
        let fetchRequest:NSFetchRequest<Persons> = Persons.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "person_name CONTAINS %@", person_name)
        
        do {
            personsList = try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = personsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCellTableViewCell
        
        cell.personInfoLabel.text = "\(person.person_name!) - \(person.person_number!)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    //Güncelle ve silme işlemi için yazıyoruz.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delAction = UIContextualAction(style: .destructive, title: "Delete") {(contextualAction, view, boolValue) in
            
            let person = self.personsList[indexPath.row]
            self.context.delete(person)
            
            appDelegate.saveContext()//sadece bu işlemi yazarsak anlık güncelleme olmaz. O yüzden alttaki kodları da ekleriz. Tekrar listeleri çekeriz.
            if self.didDoSearch {
                self.doSearch(person_name: self.searchWord!)
            }else {
                self.allPersonsTake()
            }

            self.personsTableView.reloadData()

        }
        let updAction = UIContextualAction(style: .normal, title: "Update") {(contextualAction, view, boolValue) in
            
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [delAction,updAction])
}


}
extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String){
        
        searchWord = searchText
        
        //Bunu yapmazsak eğer boşluk arar.
        if searchText == "" {
            didDoSearch = false
            allPersonsTake()
        }else {
            didDoSearch = true
                doSearch(person_name: searchWord!)
        }
        personsTableView.reloadData()
    }
}


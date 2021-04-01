//
//  RelationshipChildCoreDataVC.swift
//  core_data
//
//  Created by somsak on 30/3/2564 BE.
//

import UIKit

class RelationshipChildCoreDataVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var relationshipCoreData = RelationshipCoreData()
    var cityRelArray: [CityRel] = []
    var countryName: CountryRel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fectData()
    }
    
    @IBAction func alertsAction(_ sender: UIButton) {
        alertsAction(index: nil, value: nil)
    }
    
    func fectData(){
        self.cityRelArray = self.relationshipCoreData.fetchCityData(country: (countryName?.name)!)
        self.tableView.reloadData()
    }

    func alertsAction(index: Int?, value: CityRel?){
        let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
            
            if value != nil {
                textField.text = value?.name
            }
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if alert.textFields![0].text != "" {
                
                if value == nil {
                    self.handlerActionInput(data: alert.textFields![0].text!)
                }else{
                    self.handlerActionUpdate(index: index!, data: alert.textFields![0].text!)
                }
            }
        }))

        self.present(alert, animated: true)
    }
    
    func handlerActionInput(data: String){
        self.relationshipCoreData.saveCityData(data: data, relation: countryName!)
        self.cityRelArray = self.relationshipCoreData.fetchCityData(country: (countryName?.name)!)
        self.tableView.reloadData()
    }
    
    func handlerActionUpdate(index: Int, data: String){
        self.relationshipCoreData.updateCityData(index: index, data: data)
        self.cityRelArray = self.relationshipCoreData.fetchCityData(country: (countryName?.name)!)
        self.tableView.reloadData()
    }
    
    func handlerEditAction(index: Int, data: CityRel){
        alertsAction(index: index, value: data)
    }
}

extension RelationshipChildCoreDataVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityRelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameCell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! RelationshipChildCoreDataTableViewCell
        
        nameCell.configView(data: self.cityRelArray[indexPath.row])
        
        return nameCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteItem = UIContextualAction(style: .destructive, title: "delete") {  (deleteAction, view, boolValue) in
            print("delete")
            
            let city = self.cityRelArray[indexPath.row]
            self.relationshipCoreData.deleteCityData(data: city)
            
            self.fectData()
        }
        
        let editItem = UIContextualAction(style: .normal, title: "edit") { [self](editAction, view, boolValue) in
            print("Edit")
            handlerEditAction(index: indexPath.row, data: self.cityRelArray[indexPath.row])
        }
        editItem.backgroundColor = .blue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, editItem])

        return swipeActions
    }
}


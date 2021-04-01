//
//  RelationshipCoreDataVC.swift
//  core_data
//
//  Created by somsak on 30/3/2564 BE.
//

import UIKit

class RelationshipCoreDataVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var relationshipCoreData = RelationshipCoreData()
    var relationshipArray: [CountryRel] = []
    var countryName: CountryRel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        fectData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let relationshipChildCoreDataVC = segue.destination as? RelationshipChildCoreDataVC {
            relationshipChildCoreDataVC.countryName = self.countryName
//            jobSiteVC.selectJobSiteVCDelegate = self
        }
    }
    
    func fectData(){
        self.relationshipArray = self.relationshipCoreData.fetchCountryData()
        self.tableView.reloadData()
    }
    
    @IBAction func alertsAction(_ sender: UIButton) {
        alertsAction()
    }
    
    func alertsAction(){
        let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if alert.textFields![0].text != "" {
                
                self.handlerActionInput(data: alert.textFields![0].text!)
            }
        }))

        self.present(alert, animated: true)
    }
    
    func handlerActionInput(data: String){
        self.relationshipCoreData.saveCountryData(data: data)
        self.relationshipArray = self.relationshipCoreData.fetchCountryData()
        self.tableView.reloadData()
    }
}

extension RelationshipCoreDataVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.relationshipArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameCell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! RelationshipCoreDataTableViewCell
        
        nameCell.configView(data: self.relationshipArray[indexPath.row])
        
        return nameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.countryName = self.relationshipArray[indexPath.row]
        performSegue(withIdentifier: "goToRelationshipChildCoreDataVC", sender: nil)
    }
}



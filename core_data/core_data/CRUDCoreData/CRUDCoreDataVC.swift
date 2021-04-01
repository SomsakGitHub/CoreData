//
//  CRUDCoreDataVC.swift
//  core_data
//
//  Created by somsak on 30/3/2564 BE.
//

import UIKit

class CRUDCoreDataVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var crudCoreData = CRUDCoreData()
    var CRUDArray: [CRUD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fectData()
    }
    
    @IBAction func alertsAction(_ sender: UIButton) {
        alertsAction(index: nil, value: nil)
    }
    
    func alertsAction(index: Int?, value: CRUD?){
        let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
            
            if value != nil {
                textField.text = value?.name
            }
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your sername here..."
            
            if value != nil {
                textField.text = value?.serName
            }
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            var data: [String] = []
            
            for i in 0...1 {
                data.append(alert.textFields![i].text!)
            }
            
            let dataIsEmpty = data.allSatisfy({ $0 == ""})
    
            if !dataIsEmpty {
                if value == nil {
                    self.handlerActionInput(data: data)
                }else{
                    self.handlerActionUpdate(index: index!, data: data)
                }
            }
        }))

        self.present(alert, animated: true)
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    func fectData(){
        self.CRUDArray = self.crudCoreData.fetchCRUDData()
        self.tableView.reloadData()
    }
    
    func handlerActionInput(data: [String]){
        self.crudCoreData.saveCRUDData(data: data)
        self.CRUDArray = self.crudCoreData.fetchCRUDData()
        self.tableView.reloadData()
    }
    
    func handlerActionUpdate(index: Int, data: [String]){
        self.crudCoreData.updateCRUDData(index: index, data: data)
        self.CRUDArray = self.crudCoreData.fetchCRUDData()
        self.tableView.reloadData()
    }
    
    func handlerEditAction(index: Int, data: CRUD){
        alertsAction(index: index, value: data)
    }
}

extension CRUDCoreDataVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.CRUDArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameCell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! CRUDCoreDataTableViewCell
        
        nameCell.configView(data: self.CRUDArray[indexPath.row])
        
        return nameCell
    }
    
    // MARK: editingStyle.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // MARK: ios < 13.
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let editBTN = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
//            print("Edit")
//        }
//
//        return [editBTN]
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteItem = UIContextualAction(style: .destructive, title: "delete") {  (deleteAction, view, boolValue) in
            print("delete")
            
            let CRUD = self.CRUDArray[indexPath.row]
            self.crudCoreData.deleteCRUDData(data: CRUD)
            
            self.fectData()
        }
        
        let editItem = UIContextualAction(style: .normal, title: "edit") { [self](editAction, view, boolValue) in
            print("Edit")
            handlerEditAction(index: indexPath.row, data: self.CRUDArray[indexPath.row])
        }
        editItem.backgroundColor = .blue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, editItem])

        return swipeActions
    }
}


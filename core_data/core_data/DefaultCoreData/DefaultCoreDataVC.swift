//
//  DefaultCoreDataVC.swift
//  core_data
//
//  Created by somsak on 29/3/2564 BE.
//

import UIKit
import CoreData

class DefaultCoreDataVC: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var defaultCoreData = DefaultCoreData()
    
    var defaultArray: [DefaultData] = []
    var testText = "test Text.."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteData()
        insertData()
        fetchData()
    }
    
    func insertData(){
        self.defaultCoreData.saveDefaultData(data: testText)
    }
    
    func fetchData() {
        self.defaultArray = self.defaultCoreData.fetchDefaultData()
        self.textLabel.text = self.defaultArray.last?.text
    }
    
    func deleteData(){
        self.defaultCoreData.deleteDefaultData()
    }
}

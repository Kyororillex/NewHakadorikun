//
//  DateSyoViewController.swift
//  Hakadorikun
//
//  Created by 奥若菜 on 2021/04/10.
//

import UIKit
import RealmSwift

class DateSyoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var SelectDate:Date? = nil
    
    
    @IBOutlet weak var eventTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        eventTable.delegate = self
        eventTable.dataSource = self
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let ModifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: SelectDate!)!
        
        let realm = try! Realm()
        let data = realm.objects(EventObj.self).filter("%@ < start_time && start_time < %@ || %@ < end_time && end_time < %@ || start_time < %@ && end_time > %@",SelectDate as Any,ModifiedDate,SelectDate as Any,ModifiedDate,SelectDate as Any,ModifiedDate)
        
        if(data.count == 0){
            return 1
        } else{
            return data.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title:[String] = ["イベント","課題"]
        return title[section]
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ModifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: SelectDate!)!
        
        let realm = try! Realm()
        
        if indexPath.section == 0{
            let data = realm.objects(EventObj.self).filter("%@ < start_time && start_time < %@ || %@ < end_time && end_time < %@ || start_time < %@ && end_time > %@",SelectDate as Any,ModifiedDate,SelectDate as Any,ModifiedDate,SelectDate as Any,ModifiedDate)
            
            if(data.count != 0){
                
                let object = data[indexPath.row]
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Eventcell",
                                                         for: indexPath)
                
                let labelTitle = cell.viewWithTag(1) as! UILabel
                labelTitle.text = object.title
                
                let labelPlace = cell.viewWithTag(2) as! UILabel
                labelPlace.text = object.place
                
                let timeformatter = DateFormatter()
                
                timeformatter.locale = Locale(identifier: "ja_JP")
                timeformatter.dateFormat = "H:mm"
                
                let labelStime = cell.viewWithTag(3) as! UILabel
                labelStime.text = timeformatter.string(from: object.start_time! )
                
                let labelEtime = cell.viewWithTag(4) as! UILabel
                labelEtime.text = timeformatter.string(from: object.end_time! )
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Eventcell",
                                                         for: indexPath)
                
                let labelTitle = cell.viewWithTag(1) as! UILabel
                labelTitle.text = "新規イベント"
                
                return cell
            }
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Eventcell",
                                                     for: indexPath)
            return cell
        }
        
        
    }
    
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    //cellをタップした時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ModifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: SelectDate!)!
        
        let realm = try! Realm()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = realm.objects(EventObj.self).filter("%@ < start_time && start_time < %@ || %@ < end_time && end_time < %@ || start_time < %@ && end_time > %@",SelectDate as Any,ModifiedDate,SelectDate as Any,ModifiedDate,SelectDate as Any,ModifiedDate)
        
        let EventViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
        
        EventViewController.ID = data[indexPath.row].ID
        
        self.navigationController?.pushViewController(EventViewController, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //テーブルを再描画
        eventTable.reloadData()
    }
    
}

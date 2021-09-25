//
//  EventViewController.swift
//  Hakadorikun
//
//  Created by 奥若菜 on 2021/05/29.
//

import UIKit
//import TTTAttributedLabel
import RealmSwift


class EventViewController: UIViewController, UITextViewDelegate {
    
    var ID:String? = nil
    
    let realm = try! Realm()
    
    var AllDay:Int? = nil
    
    
    @IBOutlet weak var Memoview: UITextView!
    @IBOutlet weak var URLView: UILabel!
    @IBOutlet weak var EventTitle: UILabel!
    
    @IBOutlet weak var LocalTitle: UILabel!
    @IBOutlet weak var LocalAdress: UILabel!
    
    @IBOutlet weak var TimeLabel1: UILabel!
    @IBOutlet weak var TimeLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Memoview.delegate =  self as UITextViewDelegate
        
        let timeformatter = DateFormatter()
        
        timeformatter.locale = Locale(identifier: "ja_JP")
        timeformatter.dateFormat = "H:mm"
        
        let dateformatter = DateFormatter()
        
        dateformatter.locale = Locale(identifier: "ja_JP")
        dateformatter.dateFormat = "yyyy年M月d日 EEE曜日"
        
        let data = realm.objects(EventObj.self).filter("%@ == ID",ID as Any)
        
        if (data.count != 0){
            
            EventTitle.text = data.last?.title
            LocalTitle.text = data.last?.place
            LocalAdress.text = data.last?.address
            URLView.text = data.last?.url
            Memoview.text = data.last?.memo
            
            let Stime = data.last?.start_time
            let Etime = data.last?.end_time
            let AllDay = data.last?.all_day
            
            if Stime == nil || Etime == nil{
                
            } else {
                
                
                if dateformatter.string(from: Stime!) == dateformatter.string(from: Etime!){
                    
                    if AllDay == 1{
                        //終日
                        TimeLabel1.text = "\(dateformatter.string(from: Stime!))"
                        TimeLabel2.text = "終日"
                        
                    } else {
                        //日付同じで、終日ではない
                        TimeLabel1.text = dateformatter.string(from: Stime!)
                        TimeLabel2.text = "\(timeformatter.string(from: Stime!))〜\(timeformatter.string(from: Etime!))"
                    }
                    
                } else {
                    if AllDay == 1{
                        //終日、日付が異なる
                        TimeLabel1.text = "\(dateformatter.string(from: Stime!))から"
                        TimeLabel2.text = "\(dateformatter.string(from: Etime!))まで"
                        
                    } else {
                        //日付が異なる、終日ではない
                        TimeLabel1.text = "\(dateformatter.string(from: Stime!)) \(timeformatter.string(from: Stime!))"
                        TimeLabel2.text = "\(dateformatter.string(from: Etime!)) \(timeformatter.string(from: Etime!))"
                    }
                }
            }
        } else {
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewDidLoad()
        
    }
    
    
    @IBAction func EditButton(_ sender: Any) {
        
        let EventEditTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventEditTableViewController") as! EventEditTableViewController
        
        EventEditTableViewController.ID = ID
        
        self.navigationController?.pushViewController(EventEditTableViewController, animated: true)
        
    }
    
    
}

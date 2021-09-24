//
//  HomeViewController.swift
//  Hakadorikun
//
//  Created by 奥若菜 on 2021/03/31.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var TodayTex: UILabel!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        

//            if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
//                try! FileManager.default.removeItem(at: fileURL)
//           }
        
        

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "hakadori1.png"), for: .default)

        self.navigationController?.navigationBar.tintColor = .black

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]


            //日付のフォーマットを指定する。
            let formatter = DateFormatter()

            formatter.locale = Locale(identifier: "ja_JP")
            formatter.dateFormat = "M月d日(EEE)"

    //        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMM", options: 0, locale: Locale(identifier: "ja"))
    //
    //        let Weekformatter = DateFormatter()
    //        Weekformatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale: Locale(identifier: "ja"))


            TodayTex.text = formatter.string(from: Date())

    //        WeekDay.text = Weekformatter.string(from: Date())


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

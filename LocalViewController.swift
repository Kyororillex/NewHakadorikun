//
//  LocalViewController.swift
//  Hakadorikun
//
//  Created by 奥若菜 on 2021/06/05.
//

import UIKit
import MapKit
//import RealmSwift



class LocalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKLocalSearchCompleterDelegate, UISearchBarDelegate {
    
    var resultHandler: ((String) -> Void)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchCompleter.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Localcell", for: indexPath)
        let completion = searchCompleter.results[indexPath.row]
        cell.textLabel?.text = completion.title
        cell.detailTextLabel?.text = completion.subtitle
        return cell
    }
    
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var searchCompleter = MKLocalSearchCompleter()
    let sample = object.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchCompleter.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchBar.text!)
        searchCompleter.queryFragment = searchBar.text!
        tableView.reloadData()
        
    }
    
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //            view.endEditing(true)
    //            if let word = searchBar.text {
    //                searchCompleter.queryFragment = word
    //                print(word)
    //                tableView.reloadData()
    //            }
    //        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            //
            //           print(cell.textLabel?.text! as Any)
            //            print(cell.detailTextLabel?.text as Any)
            //
            //            let preNC = self.presentingViewController as! UINavigationController
            //            let preVC = preNC.viewControllers[preNC.viewControllers.count - 2] as! EventEditTableViewController
            ////
            //            preVC.titleData = (cell.textLabel?.text)!
            //            preVC.detailData = (cell.detailTextLabel?.text)!
            
            sample.Localdata = (cell.textLabel?.text)!
            
            if (cell.detailTextLabel?.text)! == ""{
                sample.Localdetail = ""
            }else{
                sample.Localdetail = (cell.detailTextLabel?.text)!
            }
            print(sample.Localdata)
            print(sample.Localdetail)
            
            //            guard let text1 = cell.textLabel?.text ,
            //            let text2 = cell.detailTextLabel?.text else {return}
            
            //            if let handler = self.resultHandler {
            //                handler(text1)
            //            }
            
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func CancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    //            tableView.reloadData()
    //            //print("成功")
    //        }
    //
    //        // 検索が失敗したとき
    //    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    //            //print("失敗")
    //            // エラー処理
    //        }
    
}

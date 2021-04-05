//
//  ViewController.swift
//  GetTheWords
//
//  Created by softlipa on 2021/4/5.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.accessoryType = .disclosureIndicator
        
        let model = self.dataSource[indexPath.row]
        cell.textLabel?.text = model.content
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row]
        let vc = ContentDetailViewController.init()
        vc.text = model.content ?? ""
        self.present(vc, animated: true, completion: nil)
    }

    @IBOutlet weak var m_tableView: UITableView!
    let clipBoard = ClipBoard.init()
    let db = DBManger.shared
    var dataSource = Array<BaseModel>()
    let lock = NSLock.init()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = self.m_tableView.backgroundColor
        clipBoard.startListening()
        clipBoard.checkCurrentPasteboard()
        clipBoard.onNewCopy { (content) in
            if content.count > 0 {
                _ = self.db.addContent(content: content)
            }
            print(content)
            self.checkFromDB()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.checkFromDB()
    }
  
    func checkFromDB()  {
        lock.lock()
        dataSource.removeAll()
        for value in self.db.readHistory().reversed() { // 从数据库取出来逆序一下
            dataSource.append(value)
        }
        lock.unlock()
        
        m_tableView.reloadData()
    }
    
}


//
//  ContentDetailViewController.swift
//  GetTheWords
//
//  Created by softlipa on 2021/4/6.
//

import UIKit

class ContentDetailViewController: UIViewController {
    public var text = ""
    private var m_textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        m_textView.frame = self.view.bounds
        self.view.addSubview(m_textView)
        m_textView.text = self.text
        m_textView.font = UIFont.systemFont(ofSize: 16)
        m_textView.textAlignment = .natural
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

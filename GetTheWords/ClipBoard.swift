//
//  ClipBoard.swift
//  GetTheWords
//
//  Created by softlipa on 2021/4/5.
//

import Foundation
import UIKit

class ClipBoard {
    typealias Hook = (String) -> Void
    
    private var m_pasteboard = UIPasteboard.general // 公共剪切板
    let db = DBManger.shared
    private let m_timerInterval = 0.5
    private var m_changeCount: Int
    private var hooks: [Hook]
    private var m_timer = Timer()
    
    init() {
        m_changeCount = m_pasteboard.changeCount // changeCount是干嘛的？
        hooks = []
    }
    
    func startListening() {
        if !m_timer.isValid {
            m_timer = Timer.scheduledTimer(timeInterval: m_timerInterval,
                                           target: self,
                                           selector: #selector(checkForChangesInPasteboard),
                                           userInfo: nil,
                                           repeats: true)
        }
        
    }
    
    func onNewCopy(_ hook: @escaping Hook) {
        hooks.append(hook)
    }
    
    /// 检查当前剪切板，有值的话插入数据库
    func checkCurrentPasteboard() {
        if m_pasteboard.hasStrings {
            let string = m_pasteboard.strings?.first
            
            _ = self.db.addContent(content: string!)
        }
    }
    
    @objc
    func checkForChangesInPasteboard() {
        guard m_pasteboard.changeCount != m_changeCount else {
            return
        }
        
        m_changeCount = m_pasteboard.changeCount
        
        if m_pasteboard.hasStrings {
            let string = m_pasteboard.strings?.first
            
            for hook in hooks {
                hook(string ?? "")
            }
        }
    }
    
}

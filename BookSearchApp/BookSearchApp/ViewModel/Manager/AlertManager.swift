//
//  AlertManager.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import UIKit

class AlertManager {
    
    class func showAlert(title: String?, message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
    
    class func dismissModalAlert(title: String?, message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) { [weak vc] _ in
            vc?.dismiss(animated: true)
        }
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
    
    class func deleteEveryDataAlert(vc: LikeListViewController) {
        
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: "삭제 후 되돌릴 수 없습니다.", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: { _ in
            // 1. coreData 비우기
            CoreDataManager.shared.deleteEveryData()
            
            // 2. myBookList 배열 비우기
            vc.myBookList = []
            
            // 3. 뷰 업데이트하기
            vc.tableView.reloadData()
            
        })
        
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        vc.present(alert, animated: true)
    }
}

//
//  NotificationName.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//
import UIKit

extension Notification.Name {
    static let presentedDetailView = Notification.Name("presentedDetailView")
    /* presentedDetailView 노티피케이션을 받으면
     - TenRecentBooks 업데이트
     - SearchResultCollectionViewHeader의 collectionView.reloadData()
     
     노티피케이션은 DetailViewController의 viewWillAppear에서 post
     */
    
}

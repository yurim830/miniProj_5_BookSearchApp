//
//  NotificationName.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//
import UIKit

extension Notification.Name {
    
    static let detailViewPresented = Notification.Name("presentedDetailView")
    /* presentedDetailView 노티피케이션을 받으면
     - SearchResultCollectionViewHeader의 collectionView.reloadData()
     
     노티피케이션은 DetailViewController의 viewWillDisappear에서 post
     */
    
    static let tappedItem = Notification.Name("tappedItem")
    
    static let searchConducted = Notification.Name("searchConducted")
    
    static let fetchNextLibraryData = Notification.Name("fetchLibraryData")
    
    static let setSearchBarFirstResponder = Notification.Name("setSearchBarFirstResponder") // becomeFirstResponder 메소드
}

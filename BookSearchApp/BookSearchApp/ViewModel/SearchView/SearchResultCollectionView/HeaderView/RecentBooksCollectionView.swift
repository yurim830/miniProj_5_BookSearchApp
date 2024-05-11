//
//  RecentBooksCollectionView.swift
//  BookSearchApp
//
//  Created by 유림 on 5/12/24.
//

import UIKit

class RecentBooksCollectionView: UICollectionView {
    
    // MARK: - initialize
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        setCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSearchCollectionView), name: Notification.Name.detailViewPresented, object: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Notification으로 실행시킬 함수
    @objc func reloadSearchCollectionView() {
        print("before: \(TenRecentBooks.shared.tenRecentBooks[0]?.title)")
        self.reloadData()
        print("after: \(TenRecentBooks.shared.tenRecentBooks[0]?.title)")
    }
    
    

    
    // MARK: - properties
    
    static let shared = RecentBooksCollectionView()
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let deviceWidth = UIScreen.main.bounds.width
        let countForLine: CGFloat = 1 // 행 개수
        let itemHeight = 100.0
        // (10)[사진](10)[사진](10)...[사진](10)
        
        layout.scrollDirection = .horizontal // default: vertical
        layout.minimumLineSpacing = spacing // 행 간격
        layout.minimumInteritemSpacing = 0 // 열 간격
        layout.itemSize = .init(width: itemHeight * 0.7, height: itemHeight)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    
    // MARK: - 함수
    
    // dataSource, cell 등록
    func setCollectionView() {
        self.dataSource = self
        self.register(RecentBooksCollectionViewCell.self, forCellWithReuseIdentifier: RecentBooksCollectionViewCell.identifier)
    }
    
    
}

extension RecentBooksCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentBooksCollectionViewCell.identifier,
            for: indexPath
        ) as? RecentBooksCollectionViewCell
                
        else {
            return UICollectionViewCell()
        }
        
        cell.setConstraints()
        cell.configureUI(TenRecentBooks.shared.tenRecentBooks[indexPath.row])
        return cell
    }
    
    
}

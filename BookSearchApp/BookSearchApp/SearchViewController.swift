//
//  SearchViewController.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    let bookSearchBar = UISearchBar()
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let deviceWidth = UIScreen.main.bounds.width
        let countForLine: CGFloat = 2 // 한 줄에 넣고 싶은 아이템 개수
        let itemWidth = (deviceWidth - (spacing * (countForLine - 1)) - 1) / countForLine
        // 한 줄에 2개; [사진](10)[사진]
        // 1을 빼는 이유: 부동소수점 때문에 itemWidth가 실제보다 크게 나올 수 있기 때문
        
        layout.scrollDirection = .vertical // default: vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = .init(width: itemWidth, height: itemWidth + 40)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    lazy var resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    func setConstraints() {
        [bookSearchBar].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide)
                $0.horizontalEdges.equalToSuperview().inset(10)
            }
        }
        
        [resultCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(bookSearchBar.snp.bottom).offset(10)
                $0.horizontalEdges.equalTo(bookSearchBar)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            }
        }
    }
    
}

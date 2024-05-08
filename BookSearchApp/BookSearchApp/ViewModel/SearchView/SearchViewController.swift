//
//  SearchViewController.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - API 데이터 변수
    var library: Library?
    
    // MARK: - UI components
    let bookSearchBar = UISearchBar()
    
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let deviceWidth = UIScreen.main.bounds.width
        let countForLine: CGFloat = 2 // 한 줄에 넣고 싶은 아이템 개수
        let itemWidth = (deviceWidth - 20 - (spacing * (countForLine - 1)) - 1) / countForLine
        // 한 줄에 2개; (10)[사진](10)[사진](10)
        // 1을 빼는 이유: 부동소수점 때문에 itemWidth가 실제보다 크게 나올 수 있기 때문
        
        layout.scrollDirection = .vertical // default: vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = .init(width: itemWidth, height: itemWidth * 1.2)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    // MARK: - override 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        setCollectionView()
        fetchLibraryData(query: "과자")
    }
    
    // MARK: - custom 함수
    func setCollectionView() {
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        searchCollectionView.dataSource = self
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
        
        [searchCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(bookSearchBar.snp.bottom).offset(10)
                $0.horizontalEdges.equalTo(bookSearchBar)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            }
        }
    }
    
    func fetchLibraryData(query: String) {
        APIManager.shared.fetchLibraryData(query: query) { result in
            switch result {
            case .success(let libraryResult):
                self.library = libraryResult
                DispatchQueue.main.async {
                    self.searchCollectionView.reloadData()
                    print("Library fetched. \(self.library?.documents[0].title)")
                }
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}

// MARK: - CollectionView 세팅 함수
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return library?.documents.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.identifier,
            for: indexPath) as? SearchCollectionViewCell,
              let library = self.library
        else {
            return UICollectionViewCell()
        }
        
        cell.setConstraints()
        cell.configureUI(document: library.documents[indexPath.row])
        
        return cell
    }
    
    
}

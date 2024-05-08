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
    
    let searchButton = UIButton()
    
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
        configureUI()
        setCollectionView()
        //fetchLibraryData(query: "과자")
    }
    
    // MARK: - 기능 설정 함수
    // 검색 기능
    func conductSearch() {
        let searchKeyword = bookSearchBar.searchTextField.text ?? ""
        fetchLibraryData(query: searchKeyword)
    }
    
    // MARK: - 키보드 관련 함수
    
    
    // MARK: - 레이아웃 설정 함수
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
                $0.leading.equalToSuperview().inset(10)
            }
        }
        
        [searchButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.width.equalTo(50)
                $0.height.centerY.equalTo(bookSearchBar)
                $0.leading.equalTo(bookSearchBar.snp.trailing)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            }
            // add Action
            $0.addAction(
                UIAction { _ in
                    self.conductSearch()
                }
                , for: .touchUpInside
            )
        }
        
        [searchCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(bookSearchBar.snp.bottom).offset(10)
                $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            }
        }
    }
    
    func configureUI() {
        [searchButton].forEach {
            $0.setTitle("검색", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            $0.setTitleColor(Colors.blueColor, for: .normal)
            $0.backgroundColor = Colors.yellowColor
        }
    }
    
    // MARK: - 네트워크 함수
    func fetchLibraryData(query: String) {
        APIManager.shared.fetchLibraryData(query: query) { libraryResult in
            self.library = libraryResult
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
                print("Library fetched. \(self.library?.documents[0].title)")
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

//extension SearchViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("hhhhhhh")
//        conductSearch()
//        searchBar.resignFirstResponder()
//    }
//    
//}


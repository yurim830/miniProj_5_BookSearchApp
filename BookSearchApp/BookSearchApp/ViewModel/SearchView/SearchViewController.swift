//
//  SearchViewController.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    static let shared = SearchViewController.self
    
    
    // MARK: - UI components
    let bookSearchBar = UISearchBar()
    
    let searchButton = UIButton()
    
    
    
    // MARK: - override 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureUI()
        bookSearchBar.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetailView), name: Notification.Name.tappedItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchNextLibraryData), name: Notification.Name.fetchNextLibraryData, object: nil)
    }
    
    
    // MARK: - Notification으로 실행시킬 함수
    @objc func presentDetailView(_ notification: Notification) {
        print("🎉🎉🎉🎉🎉presentDetailView")
        guard let userInfo = notification.userInfo else { return }
        guard let document = userInfo["document"] as? Document else { return }
        print("document 변환 성공")
        let detailViewController = DetailViewController(document: document)
        self.present(detailViewController, animated: true)
    }
    
    @objc func fetchNextLibraryData(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let searchKeyword = userInfo["searchKeyword"] as? String else { return }
        fetchLibraryData(query: searchKeyword, page: APIManager.shared.page)
        print("🎉🎉🎉🎉🎉fetchNextLibraryData")
    }
    
    // MARK: - 데이터 로드 함수
    func fetchLibraryData(query: String, page: Int) {
        APIManager.shared.fetchLibraryData(query: query, page: page) { libraryResult in
            SearchResultCollectionView.shared.library = libraryResult
        }
    }
    
    // MARK: - 검색 함수
    func conductSearch() {
        SearchResultCollectionView.shared.documents = [] // 변수 초기화
        APIManager.shared.page = 1 // 페이지 초기화
        
        let searchKeyword = bookSearchBar.searchTextField.text ?? ""
        fetchLibraryData(query: searchKeyword, page: APIManager.shared.page)
        
        NotificationCenter.default.post(name: Notification.Name.searchConducted, object: nil, userInfo: ["searchKeyword" : searchKeyword])
    }
    
    
    // MARK: - 레이아웃 설정 함수
    
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
                    self.searchBarSearchButtonClicked(self.bookSearchBar)
                }
                , for: .touchUpInside
            )
        }
        
        [SearchResultCollectionView.shared].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(bookSearchBar.snp.bottom).offset(10)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            }
        }
    }
    
    func configureUI() {
        SearchResultCollectionView.shared.backgroundColor = Colors.backgroundColor
        
        [searchButton].forEach {
            $0.setTitle("검색", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            $0.setTitleColor(Colors.blueColor, for: .normal)
            $0.backgroundColor = Colors.yellowColor
        }
    }
    
    
}



extension SearchViewController: UISearchBarDelegate {
    // searchBar에서 [검색(return)] 할 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        conductSearch()
        searchBar.resignFirstResponder()
    }
}


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
    var documents: [Document] = []
    
    // MARK: - UI components
    let bookSearchBar = UISearchBar()
    
    let searchButton = UIButton()
    
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let deviceWidth = UIScreen.main.bounds.width
        let countForLine: CGFloat = 2 // 한 줄에 넣고 싶은 아이템 개수
        let itemWidth = (deviceWidth - 30 - (spacing * (countForLine - 1)) - 1) / countForLine
        // 한 줄에 2개; (20)[사진 ](10)[사진 ](10)
        // 1을 빼는 이유: 부동소수점 때문에 itemWidth가 실제보다 크게 나올 수 있기 때문
        
        layout.scrollDirection = .vertical // default: vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = .init(width: itemWidth, height: itemWidth * 1.3)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    // MARK: - override 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureUI()
        setCollectionView()
        bookSearchBar.delegate = self
    }
    
    // MARK: - 데이터 함수
    func fetchLibraryData(query: String, page: Int) {
        APIManager.shared.fetchLibraryData(query: query, page: page) { libraryResult in
            self.library = libraryResult
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        }
    }
    
//    func appendNewDocumentData(query: String, page: Int) {
//        APIManager.shared.fetchLibraryData(query: query, page: page) { libraryResult in
//            let indexPath = IndexPath(item: self.documents.count - 1, section: 0)
//            let newDocuments = libraryResult.documents
//            self.documents.append(contentsOf: newDocuments)
//            DispatchQueue.main.async {
//                self.searchCollectionView.insertItems(at: [indexPath])
//            }
//        }
//    }
    
    // MARK: - 기능 설정 함수
    // 검색 기능
    func conductSearch() {
        let searchKeyword = bookSearchBar.searchTextField.text ?? ""
        APIManager.shared.page = 1
        fetchLibraryData(query: searchKeyword, page: APIManager.shared.page)
//        appendNewDocumentData(query: searchKeyword, page: APIManager.shared.page)
    }
    
//    // 무한스크롤 - 다음 페이지 데이터 append
//    func appendNextPageData() {
//        let searchKeyword = bookSearchBar.searchTextField.text ?? ""
//        APIManager.shared.page += 1
//        fetchLibraryData(query: searchKeyword, page: APIManager.shared.page)
//    }
    
    // MARK: - 키보드 관련 함수
    
    
    // MARK: - 레이아웃 설정 함수
    func setCollectionView() {
        searchCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        searchCollectionView.register(SearchResultCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultCollectionViewHeader.identifier)
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        
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
//                    self.conductSearch()
                    self.searchBarSearchButtonClicked(self.bookSearchBar)
                }
                , for: .touchUpInside
            )
        }
        
        [searchCollectionView].forEach {
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
        searchCollectionView.backgroundColor = Colors.backgroundColor
        
        [searchButton].forEach {
            $0.setTitle("검색", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            $0.setTitleColor(Colors.blueColor, for: .normal)
            $0.backgroundColor = Colors.yellowColor
        }
    }
    
    
    
}

// MARK: - CollectionView 세팅 함수
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return library?.documents.count ?? 0
//        return documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultCollectionViewCell.identifier,
            for: indexPath) as? SearchResultCollectionViewCell,
              let library = self.library
        else {
            return UICollectionViewCell()
        }
        
        cell.setConstraints()
        cell.configureUI(document: library.documents[indexPath.row])
//        cell.configureUI(document: documents[indexPath.row])
        
        return cell
    }
    
    // 아이템 선택 시 액션 설정
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let library = self.library else { return }
        let detailViewController = DetailViewController(document: library.documents[indexPath.row])
        self.present(detailViewController, animated: true)
    }
    
    // 헤더 불러오고 사용하기
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchResultCollectionViewHeader.identifier,
                for: indexPath
              ) as? SearchResultCollectionViewHeader else {return UICollectionReusableView()}
        
        let searchBarText = bookSearchBar.text
        let headerText = (searchBarText != nil && searchBarText != "") ? "🔍 검색 결과" : ""
        
        header.configureHeaderView(header: headerText)
        return header
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        <#code#> // indexPath가 아니라 길이로 계산!
//    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 230)
    }
}



extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        conductSearch()
        searchBar.resignFirstResponder()
    }
}


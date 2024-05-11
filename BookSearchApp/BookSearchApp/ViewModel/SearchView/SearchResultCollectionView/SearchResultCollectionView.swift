//
//  SearchResultCollectionView.swift
//  BookSearchApp
//
//  Created by 유림 on 5/12/24.
//

import UIKit

class SearchResultCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        setCollectionView()
        self.dataSource = self
        self.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(setSearchKeyword), name: Notification.Name.searchConducted, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let shared = SearchResultCollectionView()
    
    let layout: UICollectionViewFlowLayout = {
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
    
    var searchKeyword: String = ""
    
    var library: Library? { // API 페이지 단위로만 저장됨
        didSet {
            if let documents = library?.documents {
                self.documents.append(contentsOf: documents)
            }
        }
    }
    var documents: [Document] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    
    // MARK: - 레이아웃 설정 함수
    func setCollectionView() {
        // 셀 등록
        self.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        // 헤더 등록
        self.register(SearchResultCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultCollectionViewHeader.identifier)
    }
    
    // MARK: - Notification으로 실행시킬 함수
    @objc func setSearchKeyword(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let searchKeyword = userInfo["searchKeyword"] as? String else { return }
        self.searchKeyword = searchKeyword
    }
}


// MARK: - CollectionView 세팅 함수
extension SearchResultCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
//        return documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchResultCollectionViewCell.identifier,
            for: indexPath) as? SearchResultCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.setConstraints()
        cell.configureUI(document: self.documents[indexPath.row])
        
        return cell
    }
    
    // 아이템 클릭 시 액션 설정
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("🥕아이템 클릭!!! indexPath.row: \(indexPath.row), self.documents.count: \(self.documents.count)")
        print("🥕self.documents[indexPath.row].title: \(self.documents[indexPath.row].title)")
        
        // DetailView 모달 띄우라는 notification Post
        NotificationCenter.default.post(name: Notification.Name.tappedItem, object: nil, userInfo: ["document" : self.documents[indexPath.row]])
        
        // TenRecentBooks에 추가
        TenRecentBooks.shared.appendNewBook(self.documents[indexPath.row])
        print("TenRecentBooks: \(TenRecentBooks.shared.tenRecentBooks)")
    }
    
    // 헤더 불러오고 사용하기
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, // 헤더일때
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchResultCollectionViewHeader.identifier,
                for: indexPath
              ) as? SearchResultCollectionViewHeader else {return UICollectionReusableView()
        }
        
        let searchBarText = self.searchKeyword
        let headerText = (searchBarText != nil && searchBarText != "") ? "🔍 검색 결과" : ""
        
        header.configureHeaderView(header: headerText)
        return header
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y             // 현재 스크롤 위치 (변동)
        let contentHeight = scrollView.contentSize.height     // 컨텐츠 높이 (고정)
        let viewHeight = scrollView.frame.size.height   // 스크롤뷰 높이 (고정)
        let blankSpaceHeigt = position + viewHeight - contentHeight // 끝까지 스크롤하여 생긴 빈 공간 높이
        
        print("------------------------")
//        print("🌈 position: \(position)")
//        print("🌈 컨텐츠 높이: \(contentHeight)")
//        print("🌈 뷰 높이: \(viewHeight)")
        print("🌈 빈 공간 높이: \(blankSpaceHeigt)")
        
        if blankSpaceHeigt > 0 {
            // 1. 현재 페이지가 마지막 페이지인지 확인
            guard !(self.library?.meta.isEnd ?? true)
                  
            else {
                print("📔 다음 페이지 없음")
                return
            }
            
            // 2. 페이지 + 1
            APIManager.shared.page += 1
            print("📔 다음 페이지: \(APIManager.shared.page)")
            
            // 3. 데이터 fetch
            NotificationCenter.default.post(name: Notification.Name.fetchNextLibraryData, object: nil, userInfo: ["searchKeyword":searchKeyword])
            
        }
        
        
    }
    
}

extension SearchResultCollectionView: UICollectionViewDelegateFlowLayout {
    // 헤더 높이 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 230)
    }
}

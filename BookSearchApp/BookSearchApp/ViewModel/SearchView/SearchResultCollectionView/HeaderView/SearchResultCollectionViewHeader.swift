//
//  SearchCollectionReusableView.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import UIKit
import SnapKit

class SearchResultCollectionViewHeader: UICollectionReusableView {
    
    
    // 헤더뷰에 최근 본 책도 들어간다!!
    // 헤더뷰 총 높이: 230
    /* | 간격: 10
       firstTitle: 최근 검색 결과 (높이: 25)
       | 간격: 10
     --------------bookShelf(간격: 20)--------------//bokShelf 높이: 130
       collectionView : 최근 본 책 10개 (높이: 100) / (책 높이: 100, 책 너비: 70)
     --------------bookShelf(간격: 10)--------------
       | 간격: 20
       secondTitle: 검색 결과 (높이: 25)
       | 간격: 10 */
    
    static let identifier = String(describing: SearchResultCollectionViewHeader.self)
    
    let firstTitleLabel = UILabel()
    let secondTitleLabel = UILabel()
    let bookShelfView = UIView()
    let bookShelfImage = UIImageView()
    
//    lazy var recentBooksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//    
//    let collectionViewLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        let spacing: CGFloat = 10
//        let deviceWidth = UIScreen.main.bounds.width
//        let countForLine: CGFloat = 1 // 행 개수
//        let itemHeight = 100.0
//        // (10)[사진](10)[사진](10)...[사진](10)
//        
//        layout.scrollDirection = .horizontal // default: vertical
//        layout.minimumLineSpacing = spacing // 행 간격
//        layout.minimumInteritemSpacing = 0 // 열 간격
//        layout.itemSize = .init(width: itemHeight * 0.7, height: itemHeight)
//        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
//        return layout
//    }()
//    
    
    // MARK: - 헤더뷰 configure 함수
    // must conoduct
    func configureHeaderView(header: String) {
        //        setCollectionView()
        setConstraints()
        configureUI(header: header)
    }
    
    // MARK: - 헤더뷰 configure 함수 상세
//    func setCollectionView() {
//        recentBooksCollectionView.dataSource = self
//        recentBooksCollectionView.delegate = self
//        recentBooksCollectionView.register(RecentBooksCollectionViewCell.self, forCellWithReuseIdentifier: RecentBooksCollectionViewCell.identifier)
//    }
    
    func setConstraints() {
        [firstTitleLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.leading.equalToSuperview().offset(10)
                $0.height.equalTo(25)
            }
        }
        
        [bookShelfView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(firstTitleLabel.snp.bottom).offset(10)
                $0.horizontalEdges.equalToSuperview().inset(10)
                $0.height.equalTo(130)
            }
        }
        
        [bookShelfImage].forEach {
            bookShelfView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        [RecentBooksCollectionView.shared].forEach {
            bookShelfView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().inset(30)
                $0.top.equalToSuperview().offset(20)
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        
        [secondTitleLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(bookShelfView.snp.bottom).offset(20)
                $0.leading.equalToSuperview().offset(10)
                $0.height.equalTo(25)
            }
        }
    }
    
    func configureUI(header: String) {
        
        [firstTitleLabel].forEach {
            $0.text = "📚 최근 본 책"
            $0.font = .systemFont(ofSize: 25, weight: .heavy)
            $0.textColor = Colors.labelColor
        }
        
        [bookShelfView].forEach {
            $0.backgroundColor = .none
        }
        
        [bookShelfImage].forEach {
            $0.image = UIImage(named: "BookShelf")
            $0.contentMode = .scaleToFill
        }
        
        [RecentBooksCollectionView.shared].forEach {
            $0.backgroundColor = Colors.bookShelfBgColor
        }
        
        [secondTitleLabel].forEach {
            $0.text = header
            $0.font = .systemFont(ofSize: 25, weight: .heavy)
            $0.textColor = Colors.labelColor
        }
    }
    
}
//
//extension SearchResultCollectionViewHeader: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: RecentBooksCollectionViewCell.identifier,
//            for: indexPath
//        ) as? RecentBooksCollectionViewCell
//                
//        else {
//            return UICollectionViewCell()
//        }
//        print("configure cell")
//        cell.setConstraints()
//        cell.configureUI(TenRecentBooks.shared.tenRecentBooks[indexPath.row])
//        return cell
//    }
//    
//    
//}

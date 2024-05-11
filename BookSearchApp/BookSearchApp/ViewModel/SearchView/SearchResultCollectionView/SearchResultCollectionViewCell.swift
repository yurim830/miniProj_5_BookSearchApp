//
//  SearchCollectionViewCell.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: SearchResultCollectionViewCell.self)
    
    // MARK: - UIComponents
    let bookImage = UIImageView()
    let infoView = UIView()
    let bookTitleLabel = UILabel()
    let bookAuthorLabel = UILabel()
    let bookPublisherLabel = UILabel()
    
    
    // MARK: - 레이아웃 설정
    func setConstraints() {
        [bookImage, infoView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 책 이미지 레이아웃
        bookImage.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.trailing.bottom.equalToSuperview().inset(10) // 그림자 들어갈 공간
        }
        
        // info뷰 레이아웃
        infoView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.bottom.equalToSuperview().inset(10)  // 그림자 들어갈 공간
        }
        
        // info뷰에 뷰 넣기
        [bookTitleLabel, bookAuthorLabel, bookPublisherLabel].forEach {
            infoView.addSubview($0)
            $0.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(10)
            }
        }
        
        // 책 제목
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
        }
        
        // 작가
        bookAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(1)
        }
        
        // 출판사
        bookPublisherLabel.snp.makeConstraints {
            $0.top.equalTo(bookAuthorLabel.snp.bottom).offset(1)
            $0.bottom.equalToSuperview().inset(5)
        }
        
    }
    
    func configureUI(document: Document) {
        
        
        // 책 사진
        [bookImage].forEach {
            $0.contentMode = .scaleToFill
//            // 테두리
//            $0.layer.borderWidth = 2
//            $0.layer.borderColor = Colors.lightGrayColor?.cgColor
            // 그림자
            $0.layer.shadowOffset = CGSize(width: 5, height: 5)
            $0.layer.shadowOpacity = 0.7
            $0.layer.shadowColor = Colors.lightGrayColor?.cgColor
        }
        Task {
            do {
                let imageURL = document.thumbnail
                let imageData = try await APIManager.shared.fetchUrlData(url: imageURL)
//                print("imageData: \(imageData)")
                bookImage.image = UIImage(data: imageData)
            } catch {
                print("image error: \(error)")
            }
        }
        
        // info뷰
        [infoView].forEach {
            $0.backgroundColor = Colors.yellowColor?.withAlphaComponent(1)
//            // 테두리
//            $0.layer.borderWidth = 2
//            $0.layer.borderColor = Colors.lightGrayColor?.cgColor
//            $0.alpha = 0.8 // 이렇게 투명도 적용하면 하위 컴포넌트 전체에 투명도 적용됨.
        }
        
        // 책 제목
        [bookTitleLabel].forEach {
            $0.text = document.title
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byCharWrapping
            $0.textColor = Colors.labelColor
        }
        
        // 작가
        [bookAuthorLabel].forEach {
            let authors = document.authors
            if authors.count >= 1 {
                let authorText = authors.count == 1 ? "\(authors[0])" : "\(authors[0]) 외"
                $0.text = "✏️: \(authorText)"
                $0.font = .systemFont(ofSize: 13, weight: .medium)
                $0.textColor = Colors.labelColor
            }
        }
        
        // 출판사
        [bookPublisherLabel].forEach {
            $0.text = "📔: \(document.publisher)"
            $0.font = .systemFont(ofSize: 13, weight: .medium)
            $0.textColor = Colors.labelColor
        }
    }
}

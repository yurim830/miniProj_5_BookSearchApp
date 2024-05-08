//
//  SearchCollectionViewCell.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: SearchCollectionViewCell.self)
    
    // UIComponents
    let bookImage = UIImageView()
    let infoView = UIView()
    let bookTitleLabel = UILabel()
    let bookAuthorLabel = UILabel()
    let bookPublisherLabel = UILabel()
    
    
    func setConstraints() {
        [bookImage, infoView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        // 책 이미지 레이아웃
        bookImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // info뷰 레이아웃
        infoView.snp.makeConstraints {
            $0.height.equalTo(77)
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10) // 잘 안 잡히고 있음
        }
        
        // info뷰에 뷰 넣기
        [bookTitleLabel, bookAuthorLabel, bookPublisherLabel].forEach {
            infoView.addSubview($0)
            $0.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(10)
            }
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
        }
        
        bookAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(1)
        }
        
        bookPublisherLabel.snp.makeConstraints {
            $0.top.equalTo(bookAuthorLabel.snp.bottom).offset(1)
        }
        
    }
    
    func configureUI(document: Document) {
        // 책 사진
        [bookImage].forEach {
            $0.contentMode = .scaleToFill
        }
        Task {
            do {
                let imageURL = document.thumbnail
                let imageData = try await APIManager.shared.fetchUrlData(url: imageURL)
                print("imageData: \(imageData)")
                bookImage.image = UIImage(data: imageData)
            } catch {
                print("image error: \(error)")
            }
        }
        
        
        // info뷰
        [infoView].forEach {
            $0.backgroundColor = Colors.backgroundColor?.withAlphaComponent(0.8)
            $0.layer.cornerRadius = 10
//            $0.alpha = 0.8 // 이렇게 투명도 적용하면 하위 컴포넌트 전체에 투명도 적용됨.
        }
        
        // 책 제목
        [bookTitleLabel].forEach {
            $0.text = document.title
            $0.font = .systemFont(ofSize: 18, weight: .bold)
            $0.textColor = Colors.labelColor
        }
        
        // 작가
        [bookAuthorLabel].forEach {
            $0.text = "✏️: \(document.authors)"
            $0.font = .systemFont(ofSize: 13, weight: .medium)
            $0.textColor = Colors.labelColor
        }
        
        // 출판사
        [bookPublisherLabel].forEach {
            $0.text = "📔: \(document.publisher)"
            $0.font = .systemFont(ofSize: 13, weight: .medium)
            $0.textColor = Colors.labelColor
        }
    }
}

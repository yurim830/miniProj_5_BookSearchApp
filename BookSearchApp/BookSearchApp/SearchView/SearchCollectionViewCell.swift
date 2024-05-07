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
            $0.height.equalTo(60)
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
            $0.top.equalToSuperview().offset(5)
        }
        
        bookAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom)
        }
        
        bookPublisherLabel.snp.makeConstraints {
            $0.top.equalTo(bookAuthorLabel.snp.bottom)
        }
        
    }
    
    func configureUI() {
        // 책 사진
        [bookImage].forEach {
            $0.image = UIImage(systemName: "book")
            $0.contentMode = .scaleToFill
        }
        
        // info뷰
        [infoView].forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.alpha = 0.8
        }
        
        // 책 제목
        [bookTitleLabel].forEach {
            $0.text = "책 제목"
            $0.font = .systemFont(ofSize: 18, weight: .bold)
        }
        
        // 작가
        [bookAuthorLabel].forEach {
            $0.text = "✏️: 작가"
            $0.font = .systemFont(ofSize: 13, weight: .medium)
        }
        
        // 출판사
        [bookPublisherLabel].forEach {
            $0.text = "📔: 출판사"
            $0.font = .systemFont(ofSize: 13, weight: .medium)
        }
    }
}

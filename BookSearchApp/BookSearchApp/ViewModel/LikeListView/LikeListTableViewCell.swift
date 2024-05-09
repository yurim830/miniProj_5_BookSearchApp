//
//  LikeListTableViewCell.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import UIKit

class LikeListTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: LikeListTableViewCell.self)
    
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let priceLabel = UILabel()
    
    func setConstraints() {
        // (20)(10)[title](20)[author](20)[price](10)(20)
        // title:author:price = 6:2:2
        let paddingX = 10
        let interval = 20
        let phoneWidth = UIScreen.main.bounds.width
        let width = phoneWidth - 40
        let labelsWidth = width - 60
        let titleWidth = labelsWidth * 0.55
        let authorWidth = labelsWidth * 0.2
        let priceWidth = labelsWidth * 0.25
        
        [titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(paddingX)
                $0.centerY.equalToSuperview()
                $0.width.equalTo(titleWidth)
            }
        }
        
        [authorLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.leading.equalTo(titleLabel.snp.trailing).offset(interval)
                $0.centerY.equalToSuperview()
                $0.width.equalTo(authorWidth)
            }
        }
        
        [priceLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.leading.equalTo(authorLabel.snp.trailing).offset(interval)
                $0.centerY.equalToSuperview()
                $0.width.equalTo(priceWidth)
            }
        }
    }
    
    func configureUI(_ book: Book) {
        [titleLabel].forEach {
            $0.text = book.title
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.textColor = Colors.labelColor
            $0.textAlignment = .center
            $0.lineBreakMode = .byTruncatingTail
            $0.numberOfLines = 2
        }
        
        [authorLabel].forEach {
            $0.text = book.authors
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = Colors.lightGrayColor
            $0.textAlignment = .center
            $0.lineBreakMode = .byTruncatingTail
            $0.numberOfLines = 2
        }
        
        [priceLabel].forEach {
            guard let price = NumberFormattingManager.shared.intIntoDecimalString(Int(book.price)) else { return }
            $0.text = "\(price) 원"
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = Colors.labelColor
            $0.textAlignment = .center
            $0.lineBreakMode = .byTruncatingTail
            $0.numberOfLines = 0
        }
    }
    
}

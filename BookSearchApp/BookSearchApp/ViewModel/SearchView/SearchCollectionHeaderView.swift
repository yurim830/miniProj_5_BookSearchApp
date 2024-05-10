//
//  SearchCollectionReusableView.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import UIKit
import SnapKit

class SearchCollectionHeaderView: UICollectionReusableView {
    
    static let identifier = String(describing: SearchCollectionHeaderView.self)
    
    let headerLabel = UILabel()
    
    func setConstraints() {
        [headerLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(10)
                $0.centerY.equalToSuperview()
            }
        }
    }
    
    func configureUI(header: String) {
        [headerLabel].forEach {
            $0.text = header
            $0.font = .systemFont(ofSize: 20, weight: .heavy)
            $0.textColor = Colors.labelColor
        }
    }
    
}

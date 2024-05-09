//
//  SearchCollectionReusableView.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import UIKit
import SnapKit

class SearchCollectionReusableView: UICollectionReusableView {
    
    let headerLabel = UILabel()
    let headerText: String
    
    init(headerText: String) {
        self.headerText = headerText
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        [headerLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.centerY.equalToSuperview()
            }
        }
    }
    
    func configureUI() {
        [headerLabel].forEach {
            $0.text = headerText
            $0.font = .systemFont(ofSize: 30, weight: .heavy)
            $0.textColor = Colors.labelColor
        }
    }
    
}

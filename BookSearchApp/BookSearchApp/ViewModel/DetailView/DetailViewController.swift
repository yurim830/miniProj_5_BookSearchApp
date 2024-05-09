//
//  DetailViewController.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let thumbnailImage = UIImageView()
    let priceLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureUI()
    }
    
    func setConstraints() {
        
        let verticalSpacing = 10
        let width = view.bounds.width
        
        [scrollView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        [titleLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(30)
                $0.width.equalTo(width - 60)
                $0.centerX.equalToSuperview()
            }
        }
        
        [authorLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
                $0.width.equalTo(width - 60)
                $0.centerX.equalToSuperview()
            }
        }
        
        [thumbnailImage].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(authorLabel.snp.bottom).offset(verticalSpacing)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(200)
                $0.height.equalTo(300)
            }
        }
        
        [priceLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(thumbnailImage.snp.bottom).offset(verticalSpacing)
                $0.width.equalTo(width - 60)
                $0.centerX.equalToSuperview()
            }
        }
        
        [descriptionLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(priceLabel.snp.bottom).offset(verticalSpacing + 10)
                $0.width.equalTo(width - 60)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(30)
            }
        }
    }
    
    func configureUI() {
        
        [scrollView].forEach {
            $0.backgroundColor = Colors.backgroundColor
        }
        
        [titleLabel].forEach {
            $0.text = "책 제목"
            $0.numberOfLines = 0
            $0.textColor = Colors.labelColor
            $0.font = .systemFont(ofSize: 25, weight: .bold)
            $0.textAlignment = .center
        }
        
        
        [authorLabel].forEach {
            $0.text = "작가"
            $0.numberOfLines = 0
            $0.textColor = Colors.lightGrayColor
            $0.font = .systemFont(ofSize: 18, weight: .medium)
            $0.textAlignment = .center
        }
        
        
        [thumbnailImage].forEach {
            $0.image = UIImage(systemName: "photo")
            // 테두리
            $0.layer.borderColor = Colors.lightGrayColor?.cgColor
            $0.layer.borderWidth = CGFloat(1)
            // 그림자
            $0.layer.shadowOffset = CGSize(width: 5, height: 5)
            $0.layer.shadowOpacity = 0.7
            $0.layer.shadowColor = Colors.lightGrayColor?.cgColor
        }
        
        [priceLabel].forEach {
            $0.text = "가격"
            $0.numberOfLines = 0
            $0.textColor = Colors.labelColor
            $0.font = .systemFont(ofSize: 25, weight: .semibold)
            $0.textAlignment = .center
        }
        
        [descriptionLabel].forEach {
            $0.text = "상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명상세설명"
            $0.numberOfLines = 0
            $0.textColor = Colors.labelColor
            $0.font = .systemFont(ofSize: 18, weight: .regular)
            $0.textAlignment = .left
        }
        
    }
}

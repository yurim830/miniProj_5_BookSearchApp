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
    let buttonView = UIView()
    let cancelButton = UIButton()
    let addButton = UIButton()
    
    let document: Document
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureUI(document)
    }
    
    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints() {
        
        let verticalSpacing = 10
        let viewWidth = view.bounds.width
        let contentWidth = viewWidth - 40
        
        let buttonsHeight = 50
        let buttonsWidth = viewWidth - 70 // (30)[cancel](10)[add](30)
        let cancelButtonWidth = buttonsWidth * 0.3
        let addButtonWidth = buttonsWidth * 0.7
        
        [scrollView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            }
        }
        
        [buttonView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(scrollView.snp.bottom)
                $0.height.equalTo(buttonsHeight + 20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
                $0.horizontalEdges.equalToSuperview()
            }
        }
        
        [titleLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(30)
                $0.width.equalTo(contentWidth)
                $0.centerX.equalToSuperview()
            }
        }
        
        [authorLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
                $0.width.equalTo(contentWidth)
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
                $0.width.equalTo(contentWidth)
                $0.centerX.equalToSuperview()
            }
        }
        
        [descriptionLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(priceLabel.snp.bottom).offset(verticalSpacing + 10)
                $0.width.equalTo(contentWidth)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(30)
            }
        }
        
        [addButton].forEach {
            buttonView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.height.equalTo(buttonsHeight)
                $0.width.equalTo(contentWidth)
                $0.center.equalTo(buttonView)
            }
        }
    }
    
    func configureUI(_ document: Document) {
        
        view.backgroundColor = Colors.backgroundColor
        
        [scrollView].forEach {
            $0.backgroundColor = Colors.backgroundColor
        }
        
        [titleLabel].forEach {
            $0.text = document.title
            $0.numberOfLines = 0
            $0.textColor = Colors.labelColor
            $0.font = .systemFont(ofSize: 25, weight: .bold)
            $0.textAlignment = .center
        }
        
        
        [authorLabel].forEach {
            var authorsText = ""
            for i in document.authors {
                if authorsText == "" {
                    authorsText.append(i)
                } else {
                    authorsText.append(", \(i)")
                }
            }
            $0.text = authorsText
            $0.numberOfLines = 0
            $0.textColor = Colors.lightGrayColor
            $0.font = .systemFont(ofSize: 18, weight: .medium)
            $0.textAlignment = .center
        }
        
        // 이미지
        Task {
            do {
                let imageURL = document.thumbnail
                let imageData = try await APIManager.shared.fetchUrlData(url: imageURL)
                print("imageData: \(imageData)")
                thumbnailImage.image = UIImage(data: imageData)
            } catch {
                print("image error: \(error)")
            }
        }
        [thumbnailImage].forEach {
            // 이미지
            $0.contentMode = .scaleAspectFit
            // 테두리
            $0.layer.borderColor = Colors.lightGrayColor?.cgColor
            $0.layer.borderWidth = CGFloat(1)
            // 그림자
            $0.layer.shadowOffset = CGSize(width: 5, height: 5)
            $0.layer.shadowOpacity = 0.7
            $0.layer.shadowColor = Colors.lightGrayColor?.cgColor
        }
        
        [priceLabel].forEach {
            $0.text = "\(document.price) 원"
            $0.numberOfLines = 0
            $0.textColor = Colors.labelColor
            $0.font = .systemFont(ofSize: 22, weight: .semibold)
            $0.textAlignment = .center
        }
        
        [descriptionLabel].forEach {
            $0.text = document.contents
            $0.numberOfLines = 0
            $0.textColor = Colors.labelColor
            $0.font = .systemFont(ofSize: 18, weight: .regular)
            $0.textAlignment = .left
        }
        
        [buttonView].forEach {
            $0.backgroundColor = Colors.backgroundColor
            $0.layer.borderWidth = 1
            $0.layer.borderColor = Colors.lightGrayColor?.cgColor
        }
        
        [addButton].forEach {
            // title text
//            $0.titleLabel?.text = "d" // 버튼 스타일에 따라 안 먹힐 수 있음. -> setTitle 사용
            
            $0.setTitle(" 찜하기", for: .normal)
            $0.setTitleColor(Colors.labelColor, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
            
            // heart icon
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = Colors.labelColor
            
            // background
            $0.backgroundColor = Colors.yellowColor
            $0.layer.cornerRadius = 10
        }
    }
}

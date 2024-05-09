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
    let exitButton = UIButton()
    
    let buttonView = UIView()
    let addButton = UIButton() // < 대체 예정
    let addButtonView = UIView()
    let addButtonTitleLabel = UILabel()
    let addButtonImage = UIImageView()
    
    let document: Document
    var isAdded: Bool {
        didSet {
            
        }
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureUI(document)
        setAddButtonViewAction()
        setExitButtonAction()
    }
    
    init(document: Document) {
        self.document = document
        self.isAdded = CoreDataManager.shared.returnTrueIfHasTarget(document.isbn)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout & Design
    func setConstraints() {
        
        let verticalSpacing = 10
        let viewWidth = view.bounds.width
        let contentWidth = viewWidth - 40
        
        let addButtonHeight = 50
        // (30)[add](30)
        
        // addSubView
        [scrollView, buttonView, exitButton].forEach {
            view.addSubview($0)
        }
        
        // MARK: - ScrollView
        [scrollView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.horizontalEdges.equalToSuperview()
            }
        }
        
        [titleLabel].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(50)
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
        
        // MARK: - AddButtonView
        [buttonView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(scrollView.snp.bottom)
                $0.height.equalTo(addButtonHeight + 20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
                $0.horizontalEdges.equalToSuperview()
            }
        }
        
        [addButtonView].forEach {
            buttonView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.height.equalTo(addButtonHeight)
                $0.width.equalTo(contentWidth)
                $0.centerX.equalTo(buttonView)
                $0.bottom.equalTo(buttonView.snp.bottom)
            }
        }
        
        [addButtonTitleLabel].forEach {
            addButtonView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview().offset(15)
                $0.centerY.equalToSuperview()
            }
        }
        
        [addButtonImage].forEach {
            addButtonView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.size.equalTo(25)
                $0.trailing.equalTo(addButtonTitleLabel.snp.leading).offset(-5)
                $0.centerY.equalToSuperview()
            }
        }
        
        
        // MARK: - ExitButton
        [exitButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.leading.equalToSuperview().inset(20)
                $0.height.width.equalTo(30)
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
//                print("imageData: \(imageData)")
                thumbnailImage.image = UIImage(data: imageData)
            } catch {
                print("image error: \(error)")
            }
        }
        
        [thumbnailImage].forEach {
            // 이미지
            $0.contentMode = .scaleAspectFit
            // 그림자
            $0.layer.shadowOffset = CGSize(width: 8, height: 8)
            $0.layer.shadowOpacity = 0.7
            $0.layer.shadowColor = Colors.lightGrayColor?.cgColor
        }
        
        [priceLabel].forEach {
            guard let price = NumberFormattingManager.shared.intIntoDecimalString(document.price) else { return }
            $0.text = "\(price) 원"
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
        }
        
        [addButtonView].forEach {
            $0.backgroundColor = Colors.yellowColor
            $0.layer.cornerRadius = 10
        }
        
        [addButtonTitleLabel].forEach {
            $0.text = "찜하기"
            $0.textColor = Colors.labelColor
            $0.font = .boldSystemFont(ofSize: 18)
        }
        
        setAddButtonImageUI(added: self.isAdded)
        
        [exitButton].forEach {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageView?.snp.makeConstraints {
                $0.size.equalTo(25)
            }
            $0.tintColor = Colors.lightGrayColor
        }
    }
    
    func setAddButtonImageUI(added: Bool) {
        print("change add button image❤️")
        switch added {
        case true:
            // 빨갛게 찬 하트
            [addButtonImage].forEach {
                // heart icon
                $0.image = UIImage(systemName: "heart.fill")
                $0.contentMode = .scaleAspectFit
                $0.tintColor = Colors.redColor
            }
        case false:
            // 빈 하트
            [addButtonImage].forEach {
                // heart icon
                $0.image = UIImage(systemName: "heart")
                $0.contentMode = .scaleAspectFit
                $0.tintColor = Colors.labelColor
            }
        }
        
    }
    
    // MARK: - 버튼 액션 추가
    // addButton뷰에 tapGesture action 등록
    func setAddButtonViewAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedAddButton(_:))) // UIImageView 클릭 제스쳐
        addButtonView.addGestureRecognizer(tapGesture)
        addButtonView.isUserInteractionEnabled = true
        
    }
    
    @objc func tappedAddButton(_ gesture: UITapGestureRecognizer) {
        print("👆Button tapped!")
        // 1. 현재 데이터가 CoreData에 있는지 확인
        guard let index = CoreDataManager.shared
            .returnIndexIfHasTarget(self.document.isbn) else {
            
        // 2-1. CoreData에 없을 경우 -> 저장
            print("저장할거다!")
            CoreDataManager.shared.saveData(self.document)
            return
        }
        // 2-2. CoreData에 있는 경우 -> 삭제
        print("삭제할거다!")
        CoreDataManager.shared.deleteData(index)
        
        // 3. isAdded 값 변경
        self.isAdded = !self.isAdded
        
        // 4. 버튼 하트 이미지 변경
        setAddButtonImageUI(added: isAdded)
    }
    
    
    // x버튼
    func setExitButtonAction() {
        exitButton.addAction(
            UIAction { _ in
                self.dismiss(animated: true)
            },
            for: .touchUpInside
        )
    }
}

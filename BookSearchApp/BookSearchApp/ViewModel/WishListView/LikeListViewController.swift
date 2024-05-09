//
//  WishListViewController.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit

class LikeListViewController: UIViewController {
    
    let pageTitle = UILabel()
    let deleteAllButton = UIButton()
    let addButton = UIButton()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureUI()
    }
    
    // MARK: - layout & Design
    func setConstraints() {
        
        let paddingX = 20
        let paddingY = 20
        
        [pageTitle].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(paddingY)
                $0.centerX.equalTo(view.safeAreaLayoutGuide)
            }
        }
        
        [deleteAllButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(paddingX)
                $0.centerY.equalTo(pageTitle)
            }
        }
        
        [addButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(paddingX)
                $0.centerY.equalTo(pageTitle)
            }
        }
        
        [tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.top.equalTo(pageTitle.snp.bottom).offset(paddingY)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
                $0.horizontalEdges.equalToSuperview().inset(paddingX)
            }
        }
        
    }
    
    
    func configureUI() {
        [pageTitle].forEach {
            $0.text = "찜 목록"
            $0.font = .systemFont(ofSize: 20, weight: .heavy)
            $0.textColor = Colors.labelColor
        }
        
        [deleteAllButton].forEach {
            $0.setTitle("전체 삭제", for: .normal)
            $0.setTitleColor(Colors.redColor, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        }
        
        [addButton].forEach {
            $0.setTitle("추가하기", for: .normal)
            $0.setTitleColor(Colors.greenColor, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        }
        
    }
}

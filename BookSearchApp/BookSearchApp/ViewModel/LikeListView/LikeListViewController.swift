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
    
    var myBookList: [Book]
    
    init() {
        myBookList = CoreDataManager.shared.readData()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        configureUI()
        setTableView()
        addActionToDeleteAllButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myBookList = CoreDataManager.shared.readData()
        tableView.reloadData()
    }
  
    // MARK: - 버튼 액션 설정
    func addActionToDeleteAllButton() {
        deleteAllButton.addAction(
            UIAction { _ in
                AlertManager.deleteEveryDataAlert(vc: self)
            },
            for: .touchUpInside
        )
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
    
    // MARK: - TableView 셋팅
    func setTableView() {
        [tableView].forEach {
            $0.dataSource = self
            $0.delegate = self
            $0.register(LikeListTableViewCell.self, forCellReuseIdentifier: LikeListTableViewCell.identifier)
        }
    }
    
}



extension LikeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikeListTableViewCell.identifier, for: indexPath) as? LikeListTableViewCell
        else { return UITableViewCell() }
        
        let bookList = CoreDataManager.shared.readData()
        
        cell.setConstraints()
        cell.configureUI(bookList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1. coreData에서 삭제
        CoreDataManager.shared.deleteData(indexPath.row)
        
        // 2. myBookList 배열에서 삭제
        myBookList.remove(at: indexPath.row)
        
        // 3. 뷰 업데이트
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

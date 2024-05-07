//
//  BottomTabBarController.swift
//  BookSearchApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit

class BottomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupViewControllers()
        UITabBar.appearance().tintColor = .green
    }
    
    private func setupViewControllers() {
        // 첫 번째 탭 - SearchViewController
        let searchVC = SearchViewController()
        let searchTabBarItem = UITabBarItem(title: "책 검색하기", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        searchVC.tabBarItem = searchTabBarItem
        
        // 두 번째 탭
        let wishListVC = WishListViewController()
        let wishListTabBarItem = UITabBarItem(title: "위시리스트", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        wishListVC.tabBarItem = wishListTabBarItem
        
        // 뷰 컨트롤러 배열 생성
        let viewControllers = [searchVC, wishListVC]
        
        // 탭바 컨트롤러의 뷰 컨트롤러 설정
        self.setViewControllers(viewControllers, animated: false)
    }
    
}
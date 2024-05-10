//
//  RecentBooksCollectionViewCell.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import UIKit

class RecentBooksCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: RecentBooksCollectionViewCell.self)
    
    let bookImage = UIImageView()
    
    func setConstraints() {
        [bookImage].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    func configureUI(_ document: Document?) {
        [bookImage].forEach {
            $0.contentMode = .scaleAspectFit

        }
        Task {
            do {
                guard let imageURL = document?.thumbnail else {
                    print("imageURL 없음")
                    bookImage.image = UIImage(named: "BookShelfItem")
                    return
                }
                let imageData = try await APIManager.shared.fetchUrlData(url: imageURL)
//                print("imageData: \(imageData)")
                bookImage.image = UIImage(data: imageData)
            } catch {
                print("image error: \(error)")
            }
        }
    }
}

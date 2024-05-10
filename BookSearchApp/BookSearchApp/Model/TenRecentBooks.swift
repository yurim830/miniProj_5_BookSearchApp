//
//  TenRecentBooks.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import Foundation

class TenRecentBooks {
    
    static let shared = TenRecentBooks()
    
    var tenRecentBooks: [Document?] = [nil, nil, nil, nil] {
        /* 규칙:
         1. insert 메소드로 0번째 인덱스에 새로운 값 추가됨
         2. 배열의 길이는 10으로 유지됨
         3. 배열의 길이가 10일 때 새로운 값이 추가된다면 맨 마지막 값을 삭제함
         */
        
        didSet {
            if tenRecentBooks.count > 10 {
                tenRecentBooks.popLast()
            }
        }
    }
}

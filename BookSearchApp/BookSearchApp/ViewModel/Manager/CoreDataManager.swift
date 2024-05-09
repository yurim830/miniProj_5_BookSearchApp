//
//  CoreDataManager.swift
//  BookSearchApp
//
//  Created by 유림 on 5/9/24.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    // MARK: - 데이터 쓰기 (Create)
    func saveData(_ document: Document) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let newBook = Book(context: context)
        
        // authors 배열을 text로 만들기
        var authorsText = ""
        for i in document.authors {
            if authorsText == "" {
                authorsText.append(i)
            } else {
                authorsText.append(", \(i)")
            }
        }
        
        // 값 입력
        newBook.title = document.title
        newBook.authors = authorsText
        newBook.price = Int16(document.price)
        newBook.publisher = document.publisher
        newBook.url = document.url
        
        try? context.save()
    }
    
    
    // MARK: - 데이터 읽기(Read)
    func setProductList() -> [Book] {
        guard let context = self.persistentContainer?.viewContext else { return [] }
        
        let request = Book.fetchRequest()    // fetchRequest: Entity에 대해 코어데이터에서 특정 조건에 맞는 데이터 요청
        let bookList = try? context.fetch(request) // 요청된 데이터 가져옴
        print(bookList)
        return bookList ?? []
    }
    
    
    
    // MARK: - 데이터 삭제(Delete)
    func deleteProduct(_ index: Int) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Book.fetchRequest()
        
        guard let bookList = try? context.fetch(request) else { return }
        
        context.delete(bookList[index])
        
        try? context.save()
    }
    
}

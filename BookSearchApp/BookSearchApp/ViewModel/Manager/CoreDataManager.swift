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
        newBook.isbn = document.isbn
        newBook.title = document.title
        newBook.authors = authorsText
        newBook.price = Int16(document.price)
        newBook.publisher = document.publisher
        newBook.url = document.url
        
        try? context.save()
    }
    
    
    // MARK: - 데이터 읽기(Read)
    func readData() -> [Book] {
        guard let context = self.persistentContainer?.viewContext else { return [] }
        
        let request = Book.fetchRequest()    // fetchRequest: Entity에 대해 코어데이터에서 특정 조건에 맞는 데이터 요청
        let bookList = try? context.fetch(request) // 요청된 데이터 가져옴
        print("[read] 개수: \(bookList?.count)")
        return bookList ?? []
    }
    
    
    
    // MARK: - 데이터 삭제(Delete)
    func deleteData(_ index: Int) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Book.fetchRequest()
        
        guard let bookList = try? context.fetch(request) else { return }
        
        context.delete(bookList[index])
        
        try? context.save()
    }
    
    func deleteEveryData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Book.fetchRequest()
        
        guard let bookList = try? context.fetch(request) else { return }
        
        for i in bookList {
            context.delete(i)
        }
        
        try? context.save()
    }
    
    
    // MARK: - 데이터 확인 함수
    // 특정 데이터가 CoreData에 있는지 확인하고, 해당 데이터의 index 번호를 반환한다. 없으면 nil 반환.
    func returnIndexIfHasTarget(_ targetIsbn: String) -> Int? {
        let savedBooks = readData() // coreData에 저장된 [Book]
        
        for (index, book) in savedBooks.enumerated() {
            if book.isbn == targetIsbn {
                return index
            }
        }
        return nil
    }
    
    func returnTrueIfHasTarget(_ targetIsbn: String) -> Bool {
        let savedBooks = readData() // coreData에 저장된 [Book]
        
        for (index, book) in savedBooks.enumerated() {
            if book.isbn == targetIsbn {
                return true
            }
        }
        return false
    }
}

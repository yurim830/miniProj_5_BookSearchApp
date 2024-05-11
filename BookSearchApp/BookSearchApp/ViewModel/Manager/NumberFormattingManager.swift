//
//  NumberFormatter.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import Foundation

class NumberFormattingManager {
    
    static let shared = NumberFormattingManager()
    
    private var decimalFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }
    
    // 천자리 콤마 numberFormatter 생성
    func intIntoDecimalString(_ num: Int) -> String? {
        let result = decimalFormatter.string(from: NSNumber(value: num))
        return result
    }
}

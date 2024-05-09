//
//  NumberFormatter.swift
//  BookSearchApp
//
//  Created by 유림 on 5/10/24.
//

import Foundation

class Number {
    
    let formatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.
    }
    
    // 천자리 콤마 numberFormatter 생성
    func intIntoDecimalString(_ num: Int) {
       
        
        
        self.factoryPriceLabel.text = "$\(numberFormatter.string(from: NSNumber(value: product.factoryPrice)) ?? "")"
        self.discountPercentageLabel.text = "\(product.discountPercentage)%"
        self.sellingPriceLabel.text = "$\(numberFormatter.string(from: NSNumber(value: Int(Float(product.factoryPrice) * (1 - product.discountPercentage * 0.01)))) ?? "")"
        loadProductImage(product.thumbnail)
    }
}

//
//  CoinModel.swift
//  BitCoinPrices
//
//  Created by Bansri Rawal on 10/27/20.
//

import Foundation

struct CoinModel{
    let currency: String
    let value: Double    
    var truncatedValue: String{
        return String(format: "%.2f", value)
    }
}

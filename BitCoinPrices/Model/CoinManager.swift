//
//  CoinManager.swift
//  BitCoinPrices
//
//  Created by Bansri Rawal on 10/27/20.
//

import Foundation
import UIKit

protocol CoinManagerDelegate{
    
    func didUpdateValue(model: CoinModel)
    
    func didFailWithError()
    
}

struct CoinManager{
    
    var baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    var apiKey = "C318C2D6-5D20-4789-9D8F-ACF3C7F328D1"
    var delegate: CoinManagerDelegate?
    
    func fetchBitCoinValue(currency: String){
        let urlString = "\(baseURL)/\(currency)/?apiKey=\(apiKey)"
        
        performRequest(url: urlString)
        
    }
    
    func performRequest(url: String){
        //Create URL String -> Create URL Session -> Assign DataTask to Session -> get data
        
        if let urlString = URL(string: url){
            
            let session  = URLSession(configuration: .default)
            let sessionTask = session.dataTask(with: urlString) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError()
                    return
                }
                if let urldata = data{
                    if let coinModelEntry = self.parseJson(data: urldata){
                        self.delegate?.didUpdateValue(model: coinModelEntry)
                    }
                }
            }
            
            sessionTask.resume()
        }
        
    }
    
    func parseJson(data: Data) -> CoinModel?{
        
        let decoder = JSONDecoder()
        do{
            let decodedBitCoinValue = try decoder.decode(CoinData.self, from: data)
            let coinModelEntry = CoinModel(currency: decodedBitCoinValue.asset_id_quote, value: decodedBitCoinValue.rate)
            return coinModelEntry
        }
        catch{
            print(error)
            return nil
        }
        
        
    }
    

}

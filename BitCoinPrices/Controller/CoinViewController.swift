//
//  CoinViewController.swift
//  BitCoinPrices
//
//  Created by Bansri Rawal on 10/27/20.
//

import UIKit

class CoinViewController: UIViewController{
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitCoinImage: UIImageView!
    
    
    
    var bitCoinManage = CoinManager()
    let pickerData = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        bitCoinManage.delegate = self

        
        let url = URL(string: "https://cdn.cocoacasts.com/cc00ceb0c6bff0d536f25454d50223875d5c79f1/above-the-clouds.jpg")!

            // Create Data Task
            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        self?.bitCoinImage.image = UIImage(data: data)
                    }
                }
            }

            // Start Data Task
            dataTask.resume()
            

    }


}

//MARK: -PickerViewDelegate
extension CoinViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bitCoinManage.fetchBitCoinValue(currency: pickerData[row])
    }
    
    
}

//MARK: -CoinManagerDelegate
extension CoinViewController: CoinManagerDelegate{
    
    func didUpdateValue(model: CoinModel) {
        DispatchQueue.main.async{
            self.priceLabel.text = model.truncatedValue
            self.currencyLabel.text = model.currency
    }
    }
    
    func didFailWithError() {
        print("Failure in CoinManagerDelegate")
    }
    
}


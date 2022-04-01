//
//  APIManager.swift
//  BTCConverter
//
//  Created by Stanislav Rassolenko on 4/1/22.
//

import Foundation

class APIManager: ObservableObject {

    @Published var stringPrice: String?

    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY"

    let currencies = ["AFN", "ALL", "ARS", "AWG", "AUD", "AZN", "BSD", "BBD", "BYN", "BZD", "BMD", "BOB", "BAM", "BWP", "BRL", "BND", "BGN", "KHR", "CAD", "KYD", "CLP", "CNY", "COP", "CRC", "HRK", "CUP", "CZK", "DKK", "DOP", "XCD", "EGP", "SVC", "EUR", "FKP", "FJD", "GHS", "GIP", "GTQ", "GGP", "GYD", "HNL", "HKD", "HUF", "ISK", "INR", "IDR", "IRR", "IMP", "ILS", "JMD", "JPY", "JEP", "KZT", "KPW", "KGS", "LAK", "LBP", "LRD", "MKD", "MYR", "MUR", "MXN", "MNT", "MZN", "NAD", "NPR", "ANG", "NZD", "NIO", "NGN", "NOK", "OMR", "PKR", "PAB", "PYG", "PEN", "PHP", "PLN", "QAR", "RON", "RUB", "SHP", "SAR", "RSD", "SCR", "SGD", "SBD", "SOS", "ZAR", "KRW", "LKR", "SRD", "SEK", "CHF", "SYP", "TWD", "THB", "TTD", "TRY", "TVD", "AED", "UAH", "GBP", "USD", "UYU", "UZS", "VEF", "VND", "YER", "ZWD"]

    func getCoinValue(for currency: String) {

        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"

        if let url = URL(string: urlString) {

            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    if let safeData = data {
                        if let parsedData = self?.parseJSON(safeData) {
                            self?.stringPrice = String(format: "%.2f", parsedData)
                        }
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ data: Data) -> Double? {

        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData.rate
        } catch {
            return nil
        }
    }
}

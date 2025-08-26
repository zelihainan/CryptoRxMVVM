//
//  WebService.swift
//  CryptoRxMVVM
//
//  Created by Zeliha İnan on 26.08.2025.
//

import Foundation

enum CryptoError: Error {
    case serverError
    case parsingError
}

class WebService {
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> () ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError))
            
            }else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }else {
                    completion(.failure(.parsingError))
                }
                
            }
            
        }.resume()
    }
}

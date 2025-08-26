//
//  ViewController.swift
//  CryptoRxMVVM
//
//  Created by Zeliha İnan on 26.08.2025.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    var cryptoList = [Crypto]()
    
    private var filteredList = [Crypto]()
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.placeholder = "Search"
        
        setUpBindings()
        bindSearchBar()
        cryptoVM.requestData()
    }
    
    private func setUpBindings() {
        
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
            
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptoArray in
                self.cryptoList = cryptoArray
                
                if !self.isSearching {
                    self.filteredList = self.cryptoList
                }
                
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindSearchBar() {
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }

                let q = query
                    .folding(options: .diacriticInsensitive, locale: .current)
                    .lowercased()

                if q.isEmpty {
                    self.isSearching = false
                    self.filteredList = self.cryptoList
                } else {
                    self.isSearching = true
                    self.filteredList = self.cryptoList.filter {
                        // currency’de veya price string’inde arama
                        $0.currency.folding(options: .diacriticInsensitive, locale: .current)
                            .lowercased().contains(q)
                        ||
                        $0.price.lowercased().contains(q)
                    }
                }

                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let item = filteredList[indexPath.row]
        content.text = item.currency
        content.secondaryText = item.price
        cell.contentConfiguration = content
        return cell
    }
}

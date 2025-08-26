# CryptoRxMVVM  

iOS application — A simple example project that displays a cryptocurrency list using **RxSwift** & **MVVM**.  
The app fetches data in JSON format, displays it in a table, and allows filtering with a search bar.  

## Features
- Built with **MVVM architecture**  
- **Reactive bindings** with RxSwift & RxCocoa  
- Display cryptocurrency names & prices in a `UITableView`  
- **Search & filter** by currency or price with `UISearchBar`  
- Loading indicator with `UIActivityIndicatorView`  
- JSON data fetched via **URLSession + Decodable**  

## Screenshots
<p align="left">
<img width="190" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-27 at 00 20 23" src="https://github.com/user-attachments/assets/a2b86efb-14d5-4cf9-af27-be0a613765be" />
<img width="190" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-27 at 00 20 34" src="https://github.com/user-attachments/assets/878ba1bd-d5a4-4820-a187-67759a53c4cd" />
</p>

## Tech Stack
- **Swift 6**  
- **UIKit**  
- **RxSwift / RxCocoa**  
- **MVVM**  
- **URLSession**  


## Installation
1.Clone the repository:
   ```bash
   git clone https://github.com/zelihainan/CryptoRxMVVM.git
   ```
2.Install dependencies via Swift Package Manager (SPM):

- In Xcode, go to:
     ```bash
      File > Add Package Dependencies...
     ```
- Search for the package URL: 
 [https://github.com/ReactiveX/RxSwift.git](https://github.com/ReactiveX/RxSwift.git)
- Select the latest stable version.
- Add both RxSwift and RxCocoa packages to the project target.

3. Open with Xcode:
   ```bash
    open CryptoRxMVVM.xcodeproj
    ``` 
4. Build & Run → Run on Simulator or real device.

## API Source

Data is fetched from [Atil Samancıoğlu’s JSON dataset](https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json).




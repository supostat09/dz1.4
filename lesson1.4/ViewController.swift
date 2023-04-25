//
//  ViewController.swift
//  lesson1.4
//
//  Created by Абдулла-Бек on 8/4/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var productAmount = 0
    
    private var products: [Product] = [Product(name: "Pepperoni", price: "400", image: "1"),
                                       Product(name: "Pizza with Mashrooms", price: "450", image: "2"),
                                       Product(name: "Burger", price: "250", image: "3")]
    
    private var basketProducts: [Product] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = . systemGray5
        view.showsVerticalScrollIndicator = false
        view.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseId)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var basketButton: UIButton = {
        let view = UIButton (type: .system)
        view.setImage (UIImage (systemName: "basket.fill"), for: .normal)
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 16
        view.setTitleColor(.white, for: .normal)
        view.tintColor = .white
        view.setTitle("\(productAmount)", for: .normal)
        view.addTarget(self, action: #selector(showBasket), for: .touchUpInside)
        return view
    }()
    
    lazy var basketViewController: BasketViewController = {
        let viewController = BasketViewController()
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }
    
    @objc private func showBasket() {
        basketViewController.basketProducts = basketProducts
        navigationController?.pushViewController(basketViewController, animated: true)
    }

    private func setupSubviews () {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(basketButton)
        basketButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseId, for: indexPath)
        as! CustomCell
        cell.fill(product: products[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width - 30, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(), animated: false)
    }
}

extension ViewController: CellActions {
    func didProductChose(index: Int) {
        productAmount += 1
        basketButton.setTitle("\(productAmount)", for: . normal)
        basketProducts.append (products [index])
    }
}

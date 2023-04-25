//
//  BasketViewController.swift
//  lesson1.4
//
//  Created by Абдулла-Бек on 15/4/23.
//

import Foundation
import UIKit
import SnapKit

class BasketViewController: UIViewController {
    
    var basketProducts: [Product] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemGray5
        view.showsVerticalScrollIndicator = false
        view.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseId)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension BasketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basketProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseId, for: indexPath) as! CustomCell
        cell.fill(product: basketProducts[indexPath.row])
        return cell
    }
}

extension BasketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width - 30, height: 200)
    }
}

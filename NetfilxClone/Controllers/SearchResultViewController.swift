//
//  SearchResultViewController.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 6.12.2022.
//

import UIKit

class SearchResultViewController: UIViewController {
  
    

    public var titles : [Title] = []
    
    public let searchResultCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumLineSpacing = 10
        let searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        searchResultCollectionView.register(TileCollectionViewCell.self, forCellWithReuseIdentifier: TileCollectionViewCell.identifier)
        
        return searchResultCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        view.addSubview(searchResultCollectionView)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }

}

extension SearchResultViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: TileCollectionViewCell.identifier, for: indexPath) as! TileCollectionViewCell
        cell.configure(with: titles[indexPath.row].poster_path ?? "")
        return cell
    }
    
    
    
}

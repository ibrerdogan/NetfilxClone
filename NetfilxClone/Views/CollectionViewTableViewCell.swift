//
//  CollectionViewTableViewCell.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 2.12.2022.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

   static let identifier = "CollectionViewTableViewCell"
    var tiles : [Title] = []
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TileCollectionViewCell.self, forCellWithReuseIdentifier: TileCollectionViewCell.identifier)
        return collection
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .purple
        addSubview(collectionView) // bunu unutma lann

        
        collectionView.dataSource =  self
        collectionView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: bunu eklemezsen colleciton view görünmez... bound vermen lazım....
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with model : [Title])
    {
        self.tiles = model
        DispatchQueue.main.async {[weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension CollectionViewTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
       // cell.backgroundColor = .green
       // return cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TileCollectionViewCell.identifier, for: indexPath) as? TileCollectionViewCell
        else {return UICollectionViewCell()}
        cell.configure(with: tiles[indexPath.row].poster_path!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tiles.count
    }
    
    
}

//
//  TileCollectionViewCell.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 4.12.2022.
//

import UIKit
import SDWebImage
class TileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TileCollectionViewCell"
    let ImageUrlBase = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/"
    let ImageUrlBase2 = "https://image.tmdb.org/t/p/w500/"
    
    let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model : String)
    {
        guard let url = URL(string: ImageUrlBase2 + model) else {return}
        posterImageView.sd_setImage(with: url)
        
        //print(model)
    }
    
}

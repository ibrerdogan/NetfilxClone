//
//  UpcomingTableViewCell.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 6.12.2022.
//

import UIKit
import SDWebImage

class UpcomingTableViewCell: UITableViewCell {

    let ImageUrlBase2 = "https://image.tmdb.org/t/p/w500/"
    static let identifier = "UpcomingTableViewCell"
    
   private let posterImage : UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        return posterImage
    }()
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let playButton : UIButton = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        let playImage = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        playButton.setImage(playImage, for: .normal)
        playButton.tintColor = .white
        return playButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(playButton)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImage.frame = contentView.bounds
        nameLabel.frame = contentView.bounds
        playButton.frame = contentView.bounds
        
    }
    
    public func configure(with model : Title)
    {
        guard let url = URL(string: ImageUrlBase2 + (model.poster_path ?? "") ) else {return}
        posterImage.sd_setImage(with: url)
        nameLabel.text = model.original_title ?? model.original_name ?? "unknown"
        
        //print(model)
    }
    
    func layout()
    {
        NSLayoutConstraint.activate([
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: posterImage.trailingAnchor, multiplier: 2),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
          
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }

}

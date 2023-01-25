//
//  HeroHeaderView.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 2.12.2022.
//

import UIKit

class HeroHeaderView: UIView {

    let playButton : UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        return button
        
    }()
    
    var downloadButton : UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        return button
    }()
    
    let headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "hero")
        return imageView
    }()

    private func style()
    {
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100),
            
            
            
           
        ])
    }
    
    private func addGradient()
    {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    override init(frame: CGRect) {

        super.init(frame: frame) // buna frame ver buna frame ver buna frame ver......
        addSubview(headerImageView)
        addGradient()
        addSubview(downloadButton)
        addSubview(playButton)
        style()
    }
    
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerImageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension HeroHeaderView
{
    func createButton(title : String) -> UIButton
    {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        return button
    }
}

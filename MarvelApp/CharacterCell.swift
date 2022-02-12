//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 09/02/22.
//

import UIKit

class CharacterCell: UITableViewCell {
    var character: CharacterUIModel? {
        didSet {
            self.titleLabelView.text = character?.name
            self.customImageView.image = character?.image?.withRenderingMode(.alwaysOriginal)
        }
    }
        
    let customImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabelView: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    func layout() {
        addSubview(customImageView)
        customImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        customImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        customImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        
        addSubview(titleLabelView)
        titleLabelView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10).isActive = true
        titleLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        titleLabelView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabelView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

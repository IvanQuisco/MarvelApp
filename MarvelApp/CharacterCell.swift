//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Ivan Quintana on 09/02/22.
//

import UIKit

class CharacterCell: UITableViewCell {
    var character: Character? {
        didSet {
            self.titleLabelView.text = character?.name
            self.customImageView.image = .init(named: character?.imageName ?? "")?.withRenderingMode(.alwaysOriginal)
            self.subtitleLabelView.text = character?.team
        }
    }
        
    let customImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabelView: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subtitleLabelView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .medium)
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
        titleLabelView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        titleLabelView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        addSubview(subtitleLabelView)
        subtitleLabelView.topAnchor.constraint(equalTo: titleLabelView.bottomAnchor, constant: 0).isActive = true
        subtitleLabelView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        subtitleLabelView.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10).isActive = true
        subtitleLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ContactListTableViewCell.swift
//  Lesson 3
//
//  Created by Karina Kovaleva on 20.12.22.
//

import UIKit

class ContactListTableViewCell: UITableViewCell {
    
    static let identifier = "ContactListTableViewCell"
    
    var favoriteContacts: [Contact] = []
    
    lazy var avatar: CircleImageView = {
        var avatar = CircleImageView()
        return avatar
    }()
    
    private lazy var stackViewForLabels: UIStackView = {
        var stackViewForLabels = UIStackView()
        stackViewForLabels.axis = .vertical
        stackViewForLabels.distribution = .fillProportionally
        stackViewForLabels.alignment = .leading
        stackViewForLabels.spacing = 2
        [self.fullNameLabel, self.phoneNumberLabel].forEach { stackViewForLabels.addArrangedSubview($0) }
        return stackViewForLabels
    }()
    
    lazy var fullNameLabel: UILabel = {
        var fullNameLabel = UILabel()
        fullNameLabel.textColor = .darkGray
        return fullNameLabel
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        var phoneNumberLabel = UILabel()
        phoneNumberLabel.textColor = .lightGray
        return phoneNumberLabel
    }()
    
    private lazy var buttonConfiguration: UIButton.Configuration = {
        var buttonConfiguration = UIButton.Configuration.tinted()
        buttonConfiguration.buttonSize = .mini
        buttonConfiguration.imagePlacement = .all
        return buttonConfiguration
    }()
    
    lazy var favoriteButton: UIButton = {
        var configuration = buttonConfiguration
        var favoriteButton = UIButton(type: .custom)
        favoriteButton.configuration = configuration
        favoriteButton.configurationUpdateHandler = { [weak self] button in
            switch button.state {
            case .selected:
                button.configuration?.image = UIImage(systemName: "heart.fill")
            default:
                button.configuration?.image = UIImage(systemName: "heart")
            }
        }
        favoriteButton.addTarget(self, action: #selector(touch), for: .touchUpInside)
        return favoriteButton
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    private func setupCell() {
        self.contentView.addSubview(avatar)
        self.contentView.addSubview(stackViewForLabels)
        self.contentView.addSubview(favoriteButton)

        avatar.translatesAutoresizingMaskIntoConstraints = false
        stackViewForLabels.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = stackViewForLabels.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        // MARK: Программно задаю приоритет нижнему констрейнту для stackView, чтобы не возникало конфликта при удалении ячейки
        bottomConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            avatar.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            avatar.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            avatar.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10),
            stackViewForLabels.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10),
            stackViewForLabels.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -5),
            bottomConstraint,
            stackViewForLabels.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            favoriteButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
        ])
    }
    
    @objc func touch(sender: UIButton) -> Void {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true

        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  UserCollectionViewCell.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 25/09/2022.
//

import UIKit

final class UserCollectionViewCell: UICollectionViewCell {
    private let fullNameLabel = UILabel().prepareForAutoLayout()
    private let emailLabel = UILabel().prepareForAutoLayout()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCell()
    }

    func configure(with user: User) {
        fullNameLabel.text = user.name.fullName
        emailLabel.text = user.email
    }

    private func setupCell() {
        addSubview(fullNameLabel)
        fullNameLabel.font = .boldSystemFont(ofSize: 16)
        fullNameLabel.textColor = .black
        fullNameLabel.autoSetTopSpace(4)
        fullNameLabel.autoFitHorizontally(withMargins: 20)

        addSubview(emailLabel)
        emailLabel.font = .systemFont(ofSize: 12)
        emailLabel.textColor = .black.withAlphaComponent(0.75)
        emailLabel.autoSetTopSpace(4, toView: fullNameLabel)
        emailLabel.autoFitHorizontally(withMargins: 20)
        emailLabel.autoSetBottomSpace(4)
    }
}

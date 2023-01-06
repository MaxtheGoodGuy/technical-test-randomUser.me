//
//  HeaderView.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

import UIKit

final class HeaderView: UIView {
    private let titleLabel = UILabel().prepareForAutoLayout()
    private let subtitleLabel = UILabel().prepareForAutoLayout()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    func setup(title: String) {
        titleLabel.text = title
    }

    func configure(subtitle: String) {
        subtitleLabel.text = subtitle
    }

    private func setupView() {
        addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.autoFitVertically(withMargins: 4)
        titleLabel.autoSetLeftSpace(20)
        titleLabel.autoSetHeight(20)

        addSubview(subtitleLabel)
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = .black
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.autoCenterVertically()
        subtitleLabel.autoSetLeftSpace(8, toView: titleLabel, relation: .greaterThanOrEqual)
        subtitleLabel.autoSetRightSpace(20)
        subtitleLabel.autoSetHeight(20)
    }
}

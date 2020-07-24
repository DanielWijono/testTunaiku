//
//  SnackbarView.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import UIKit

public class SnackbarView: UIView {
    let backgroundView = UIView()
    let label = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        setupBackgroundView()
        setupLabel()
    }

    func setupBackgroundView() {
        self.addSubview(backgroundView)
        backgroundView.isHidden = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 3
        backgroundView.backgroundColor = .gray

        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }

    func setupLabel() {
        backgroundView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 20).isActive = true
        label.textColor = .black
        label.numberOfLines = 2
    }

    public func showSnackbar(message: String) {
        backgroundView.isHidden = false
        label.text = message

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.hideSnackbar()
        }
    }

    public func hideSnackbar() {
        backgroundView.isHidden = true
        self.removeFromSuperview()
    }
}

//
//  FirstViewController.swift
//  TransitionEx
//
//  Created by 김종권 on 2021/09/07.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func dismissSecondViewController()
}

class FirstViewController: UIViewController {

    var viewWillAppearEventCount = 0

    let label: UILabel = {
        let label = UILabel()
        label.text = "첫 번째 뷰"

        return label
    }()

    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "viewWillAppear 카운트 = \(0)"
        label.textColor = .black

        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("present", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.7)
        button.layer.cornerRadius = 14.0
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        return button
    }()

    let navButton: UIButton = {
        let button = UIButton()
        button.setTitle("push", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray.withAlphaComponent(0.7)
        button.layer.cornerRadius = 14.0
        button.addTarget(self, action: #selector(didTapNavButton(_:)), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        navButton.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        view.addSubview(countLabel)
        view.addSubview(button)
        view.addSubview(navButton)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),

            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 52),

            navButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            navButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            navButton.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24),
            navButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewWillAppearEventCount += 1
        countLabel.text = "viewWillAppear 카운트 = \(viewWillAppearEventCount)"
    }

    @objc
    private func didTapButton(_ sender: Any) {
        let secondViewController = SecondViewController()
        secondViewController.delegate = self
        secondViewController.modalPresentationStyle = .pageSheet

        present(secondViewController, animated: true, completion: nil)
    }

    @objc
    private func didTapNavButton(_ sender: Any) {
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension FirstViewController: SecondViewControllerDelegate {
    func dismissSecondViewController() {
        viewWillAppearEventCount += 1
        countLabel.text = "pageSheet인 두 번째 뷰의 dismiss 카운트 = (\(viewWillAppearEventCount))"
    }
}

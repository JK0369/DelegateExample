//
//  SecondViewController.swift
//  TransitionEx
//
//  Created by 김종권 on 2021/09/07.
//

import UIKit

class SecondViewController: UIViewController {

    weak var delegate: SecondViewControllerDelegate?

    var viewWillAppearEventCount = 0

    let label: UILabel = {
        let label = UILabel()
        label.text = "두 번째 뷰"

        return label
    }()

    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "viewWillAppear 카운트 = \(0)"

        return label
    }()

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("dismiss me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.7)
        button.layer.cornerRadius = 14.0
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        view.addSubview(countLabel)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewWillAppearEventCount += 1
        countLabel.text = "viewWillAppear 카운트 = \(viewWillAppearEventCount)"
    }

    @objc func didTapButton(_ sender: Any) {
        delegate?.dismissSecondViewController()
        dismiss(animated: true, completion: nil)
    }

}

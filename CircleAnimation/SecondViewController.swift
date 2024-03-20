//
//  SecondViewController.swift
//  CircleAnimation
//
//  Created by Abdusamad Mamasoliyev on 20/03/24.
//

import UIKit

class SecondViewController: UIViewController {

    let disButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar()
        style()
        layout()
    }
    func navBar() {
        title = "IOS Developer"
        view.backgroundColor = .purple
    }
    override func viewDidLayoutSubviews() {
        disButton.layer.cornerRadius = disButton.frame.width / 2
    }
    
    func style() {
        disButton.backgroundColor = .white
        disButton.setTitle("Cancel", for: .normal)
        disButton.tintColor = .red
        disButton.addTarget(self, action: #selector(tapDisButton), for: .touchUpInside)
        disButton.translatesAutoresizingMaskIntoConstraints = false
    
    }
    func layout() {
        view.addSubview(disButton)
        NSLayoutConstraint.activate([
            disButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            disButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            disButton.widthAnchor.constraint(equalToConstant: 60),
            disButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    @objc func tapDisButton() {
        navigationController?.popViewController(animated: true)
    }
}

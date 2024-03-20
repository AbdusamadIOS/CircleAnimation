//
//  MainVC.swift
//  CircleAnimation
//
//  Created by Abdusamad Mamasoliyev on 20/03/24.
//

import UIKit

class MainVC: UIViewController {

    let presentButton = UIButton(type: .system)
    private var transition = CircularTransition()
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar()
        style()
        layout()
        navigationController?.delegate = self
    }
    func navBar() {
        title = "iDevFan"
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        presentButton.layer.cornerRadius = presentButton.frame.width / 2
    }
    func style() {
        presentButton.backgroundColor = .orange
        presentButton.setTitle("Next", for: .normal)
        presentButton.tintColor = .white
        presentButton.addTarget(self, action: #selector(tapPresentButton), for: .touchUpInside)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.layer.cornerRadius = presentButton.frame.width / 2
       
    }
    
    func layout() {
        view.addSubview(presentButton)
        NSLayoutConstraint.activate([
            presentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.widthAnchor.constraint(equalToConstant: 60),
            presentButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    @objc func tapPresentButton() {
        let secondViewConroller = SecondViewController()
        secondViewConroller.modalPresentationStyle = .custom
        secondViewConroller.transitioningDelegate = self
        navigationController?.pushViewController(secondViewConroller, animated: true)
    }
}

extension MainVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        transition.transitionMode = .present
        transition.startingPoint = presentButton.center
        transition.circleColor = presentButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        transition.transitionMode = .dismiss
        transition.startingPoint = presentButton.center
        transition.circleColor = presentButton.backgroundColor!
        return transition
    }
}

extension MainVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        transition.transitionMode = operation == .push ? .present : .dismiss
        transition.startingPoint = presentButton.center
        transition.circleColor = operation == .pop ? .white : .orange
        
        return transition
    }
}

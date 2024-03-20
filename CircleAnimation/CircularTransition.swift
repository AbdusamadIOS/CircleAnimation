//
//  CircularTransition.swift
//  CircleAnimation
//
//  Created by Abdusamad Mamasoliyev on 20/03/24.
//

import UIKit

enum CircularTransitionMode {
    case present, dismiss
}

final class CircularTransition: NSObject {
    
    private var circle = UIView()
    public var circleColor: UIColor = .white
    public var duration = 0.3
    public var transitionMode: CircularTransitionMode = .present
    public var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    private func frameCircle(size: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, size.width - startPoint.x)
        let yLength = fmax(startPoint.y, size.height - startPoint.y)
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: .zero, size: size)
    }
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: .to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                circle.frame = frameCircle(size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.width / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration) {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                } completion: { success in
                    transitionContext.completeTransition(success)
                }
            }
        } else {
            if let returnedView = transitionContext.view(forKey: .from) {
                let viewSize = returnedView.frame.size
                
                circle.frame = frameCircle(size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.width / 2
                circle.center = startingPoint
                
                if let initialView = transitionContext.view(forKey: .to) {
                    containerView.insertSubview(initialView, belowSubview: circle)
                }
                
                UIView.animate(withDuration: duration) {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returnedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returnedView.center = self.startingPoint
                    returnedView.alpha = 0
                } completion: { success in
                    returnedView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                }
            }
        }
    }
}

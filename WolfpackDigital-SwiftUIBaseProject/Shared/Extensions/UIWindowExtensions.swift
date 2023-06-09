//
//  UIWindowExtensions.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Vica Cotoarba on 30.06.2022.
//

import Foundation
import UIKit

extension UIWindow {
    
    /// Transition Options
    struct TransitionOptions {
        
        /// Curve of animation
        ///
        /// - linear: linear
        /// - easeIn: ease in
        /// - easeOut: ease out
        /// - easeInOut: ease in - ease out
        enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                let name: CAMediaTimingFunctionName
                switch self {
                case .linear: name = .linear
                case .easeIn: name = .easeIn
                case .easeOut: name = .easeOut
                case .easeInOut: name = .easeInEaseOut
                }
                return CAMediaTimingFunction(name: name)
            }
        }
        
        /// Direction of the animation
        ///
        /// - fade: fade to new controller
        /// - toTop: slide from bottom to top
        /// - toBottom: slide from top to bottom
        /// - toLeft: pop to left
        /// - toRight: push to right
        enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            
            /// Return the associated transition
            ///
            /// - Returns: transition
            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = .push
                switch self {
                case .fade:
                    transition.type = .fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = .fromLeft
                case .toRight:
                    transition.subtype = .fromRight
                case .toTop:
                    transition.subtype = .fromTop
                case .toBottom:
                    transition.subtype = .fromBottom
                }
                return transition
            }
        }
        
        /// Background of the transition
        ///
        /// - solidColor: solid color
        /// - customView: custom view
        enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        
        /// Duration of the animation (default is 0.30s)
        var duration: TimeInterval = 0.30
        
        /// Direction of the transition (default is `toRight`)
        var direction: TransitionOptions.Direction = .toRight
        
        /// Style of the transition (default is `linear`)
        var style: TransitionOptions.Curve = .linear
        
        /// Background of the transition (default is `nil`)
        var background: TransitionOptions.Background?
        
        /// Initialize a new options object with given direction and curve
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        
        init() { }
        
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }
    
    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        
        var transitionWnd: UIWindow?
        if let background = options.background {
            transitionWnd = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWnd?.rootViewController = UIViewController.newController(withView: view, frame: transitionWnd!.bounds)
            case .solidColor(let color):
                transitionWnd?.backgroundColor = color
            }
            transitionWnd?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        self.makeKeyAndVisible()
        
        if let wnd = transitionWnd {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.duration), execute: {
                wnd.removeFromSuperview()
            })
        }
    }
}

internal extension UIViewController {
    
    /// Create a new empty controller instance with given view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - frame: frame
    /// - Returns: instance
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
}

//
//  BlurView.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-23.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    
    // MARK: - Variable
    
     private lazy var blurView: UIVisualEffectView = {
            let view = UIVisualEffectView()
            view.effect = UIBlurEffect(style: .light)
            view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            return view
        }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
           let indicator = UIActivityIndicatorView()
           indicator.style = .large
           indicator.color = #colorLiteral(red: 0.02282341453, green: 0.06283995077, blue: 0.1708630181, alpha: 1)
           indicator.translatesAutoresizingMaskIntoConstraints = false
        
           return indicator
       }()
    
    // MARK: - didMoveToSuperview
    
    override func didMoveToSuperview() {
        isUserInteractionEnabled = false
        addSubview(blurView)
        addSubview(activityIndicator)
        addConstraints()
    }
    
    // MARK: - Create constraints for activity indicator
    
       func addConstraints() {
           NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 48),
            activityIndicator.heightAnchor.constraint(equalTo: activityIndicator.widthAnchor)
           ])
       }
    
    func show() {
        activityIndicator.startAnimating()
        blurView.isHidden = false
        activityIndicator.hidesWhenStopped = false
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        blurView.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }
}

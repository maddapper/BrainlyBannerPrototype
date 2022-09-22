//
//  ViewController.swift
//  BrainlyBanner_M10_548
//
//  Created by Dean Chang on 9/22/22.
//

import UIKit

class ViewController: UIViewController {
    let banner = BannerAdView()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = UIColor.cyan
        view.addSubview(banner)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        banner.frame = CGRect(x: 0, y: 0, width: 300, height: 250)
        setAnchorConstraints(banner)
        banner.loadAd()
    }
    
    func setAnchorConstraints(_ banner: UIView) {
        guard let container = banner.superview else {
            return
        }
                
        banner.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        banner.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        banner.widthAnchor.constraint(equalToConstant: banner.frame.width).isActive = true
        banner.heightAnchor.constraint(equalToConstant: banner.frame.height).isActive = true
    }


}


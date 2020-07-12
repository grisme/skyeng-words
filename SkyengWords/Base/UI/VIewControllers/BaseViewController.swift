//
//  BaseViewController.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 12.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var indicatorBlurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(indicatorBlurView)
        self.indicatorBlurView.contentView.addSubview(indicator)
    }
    
    private func makeConstraints() {
        indicatorBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    func showLoader(with text: String = "") {
        self.indicatorBlurView.isHidden = false
        self.view.bringSubviewToFront(self.indicatorBlurView)
        self.indicator.startAnimating()
    }
    
    func hideLoader() {
        self.indicatorBlurView.isHidden = true
        self.indicator.stopAnimating()
    }
    
}

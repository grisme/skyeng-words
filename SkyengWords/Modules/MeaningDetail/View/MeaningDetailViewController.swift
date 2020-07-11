//
//  MeaningDetailViewController.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

final class MeaningDetailViewController: UIViewController {
    
    // MARK: - Appearance
    
    struct Appearance {
        
    }
    let appearance = Appearance()
    
    // MARK: - Properties
    
    let presenter: MeaningDetailViewOutput
    
    // MARK: - Lifecycle
    
    init(presenter: MeaningDetailViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        
    }
    
    private func makeConstraints() {
        
    }

}

// MARK: - MeaningDetailViewInput interface implementation

extension MeaningDetailViewController: MeaningDetailViewInput {
    func setLoadingEnabled(enabled: Bool) {
        
    }
}

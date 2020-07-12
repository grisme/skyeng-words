//
//  MeaningDetailPresenter.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

final class MeaningDetailPresenter {
    
    // MARK: - Properties
    
    weak var view: MeaningDetailViewInput?
    let interactor: MeaningDetailInteractorInput
    let router: MeaningDetailRouterInput
    
    /// Meaning identifier
    let meaningId: Int
    
    // MARK: - Lifecycle
    
    init(meaningId: Int, interactor: MeaningDetailInteractorInput, router: MeaningDetailRouterInput) {
        self.meaningId = meaningId
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Private methods
    
    /// Fetch meaning with identifier
    /// - Parameters:
    ///   - meaningId: Meaning identifier
    ///   - success: Success closure
    ///   - failure: Failure closure
    func fetchMeaning(meaningId: Int, success: @escaping (MeaningDetailViewModel) -> Void, failure: @escaping (Error) -> Void) {
        interactor.obtainMeaningDetail(
            meaningId: meaningId,
            completion: { result in
                switch result {
                case .success(let meaning):
                    let viewModel = MeaningDetailViewModel(meaning: meaning)
                    DispatchQueue.main.async { success(viewModel) }
                case .failure(let error):
                    DispatchQueue.main.async { failure(error) }
                }
            }
        )
    }

}

// MARK: - MeaningDetailViewOutput inteface implementation

extension MeaningDetailPresenter: MeaningDetailViewOutput {
    
    func viewDidLoad() {
        view?.setLoadingEnabled(enabled: true)
        fetchMeaning(
            meaningId: meaningId,
            success: { [weak self] viewModel in
                self?.view?.setLoadingEnabled(enabled: false)
                self?.view?.showMeaning(meaningViewModel: viewModel)
            }, failure: { [weak self] error in
                self?.view?.setLoadingEnabled(enabled: false)
                self?.router.routeBack()
            }
        )
    }
    
    func shouldRefresh() {
        fetchMeaning(
            meaningId: meaningId,
            success: { [weak self] viewModel in
                self?.view?.endRefreshing()
                self?.view?.showMeaning(meaningViewModel: viewModel)
            }, failure: { [weak self] error in
                self?.view?.endRefreshing()
            }
        )
    }
    
}

// MARK: - MeaningDetailInteractorOutput interface implementation

extension MeaningDetailPresenter: MeaningDetailInteractorOutput {
    
}

//
//  LoaderHelper.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/13/23.
//

import Foundation
import Factory
import UIKit
import Combine
import SwiftUI

protocol ModalHelper {
    func show(_ modal: ModalHelperImp.Modal)
    func dismiss()
}

class ModalHelperImp: ModalHelper {
    enum Modal {
        case loader(title: String?, description: String?),
             error(title: String?, description: String?)
    }
    
    @Injected(\.navigationController) private var navigationController: UINavigationController
    
    private var modalSubject: ModalSubject = .init()
    @Published private var modalToShow: Modal? = .none
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $modalToShow
            .compactMap { $0 }
            .flatMap(maxPublishers: .max(1), { [unowned self] modal -> Future<Void, Never> in
                Future<Void, Never> {[unowned self] promise in
                    self.present(modal: modal)
                        .flatMap { _ in
                            self.modalSubject
                                .filter { $0 == .presentNew }
                                .first()
                        }
                        .flatMap { _ in
                            self.dismissModal()
                        }
                        .sink { _ in
                            promise(.success(()))
                        }
                        .store(in: &subscriptions)
                }
            })
            .sink { _ in
                print("It got removed")
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        dismiss()
    }
    
    func show(_ modal: Modal) {
        dismiss()
        modalToShow = modal
    }
    
    func dismiss() {
        modalSubject.send(.close)
    }
    
    private func present(modal: Modal) -> Future<Void, Never> {
        Future {[unowned self] promise in
            self.navigationController.present(self.get(for: modal), animated: true) {
                promise(.success(()))
            }
        }
    }
    
    private func dismissModal() -> Future<Void, Never> {
        Future {[unowned self] promise in
            self.navigationController.viewControllers.last?.dismiss(animated: true) {
                promise(.success(()))
            }
        }
    }
    
    private func get(for modal: Modal) -> UIViewController {
        switch modal {
        case .loader(let title, let description):
            return getLoader(with: title, description: description, modalSubject: modalSubject)
        case .error(let title, let description):
            return getError(with: title, description: description, modalSubject: modalSubject)
        }
    }
    
    private func getLoader(with title: String?, description: String?, modalSubject: ModalSubject) -> UIViewController {
        let loaderView = UIHostingController(
            rootView: BottomSheetModalView(
                c: C.color,
                viewModel: BottomSheetModalView.ViewModel(modalSubject: modalSubject)
            ) {
            LoaderView(c: C.color, f: C.font, title: title ?? "Loading", description: description ?? "")
        })
        loaderView.view.backgroundColor = .clear
        loaderView.modalPresentationStyle = .overCurrentContext
        loaderView.modalTransitionStyle = .crossDissolve
        return loaderView
    }
    
    private func getError(with title: String?, description: String?, modalSubject: ModalSubject) -> UIViewController {
        let loaderView = UIHostingController(
            rootView: BottomSheetModalView(
                c: C.color,
                viewModel: BottomSheetModalView.ViewModel(modalSubject: modalSubject)
            ) {
                ErrorModalView(c: C.color, f: C.font, title: title ?? "Error", description: description ?? "", continueButtonTapped: {[weak self] in self?.dismiss() })
        })
        loaderView.view.backgroundColor = .clear
        loaderView.modalPresentationStyle = .overCurrentContext
        loaderView.modalTransitionStyle = .crossDissolve
        return loaderView
    }
}


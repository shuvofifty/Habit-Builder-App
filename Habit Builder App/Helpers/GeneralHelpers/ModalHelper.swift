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

typealias ModalID = String

enum CommonModalID: String {
    case LOADING, ERROR
}

protocol ModalHelper {
    func show(_ modal: ModalHelperImp.Modal, with id: ModalID)
    func dismiss(id: ModalID)
}

class ModalHelperImp: ModalHelper {
    enum Modal {
        case loader(title: String?, description: String?),
             error(title: String?, description: String?)
    }
    
    private var modalSubject: ModalSubject = .init()
    private var modalCollections: [String: UIView?] = [:]
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        modalSubject
            .filter { $0.action == .closeAnimationCompleted }
            .map { $0.id }
            .sink {[weak self] id in
                self?.modalCollections[id]??.removeFromSuperview()
                self?.modalCollections.removeValue(forKey: id)
            }
            .store(in: &subscriptions)
    }
    
    func show(_ modal: Modal, with id: ModalID) {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        guard modalCollections[id] == nil else {
            print("Unable to present modal \(id) because it already exist")
            return
        }
        let overlay = get(for: modal, id: id).view
        modalCollections[id] = overlay
        window.addSubview(overlay!)
        overlay?.hook(to: window, with: 0)
    }
    
    func dismiss(id: ModalID) {
        modalSubject.send((id: id, action: .close))
    }
    
    private func get(for modal: Modal, id: String) -> UIViewController {
        switch modal {
        case .loader(let title, let description):
            return getLoader(with: title, description: description, modalSubject: modalSubject, id: id)
        case .error(let title, let description):
            return getError(with: title, description: description, modalSubject: modalSubject, id: id)
        }
    }
    
    private func getLoader(with title: String?, description: String?, modalSubject: ModalSubject, id: ModalID) -> UIViewController {
        let loaderView = UIHostingController(
            rootView: BottomSheetModalView(
                c: C.color,
                viewModel: BottomSheetModalView.ViewModel(modalSubject: modalSubject, id: id)
            ) {
            LoaderView(c: C.color, f: C.font, title: title ?? "Loading", description: description ?? "")
        })
        loaderView.view.backgroundColor = .clear
        return loaderView
    }
    
    private func getError(with title: String?, description: String?, modalSubject: ModalSubject, id: ModalID) -> UIViewController {
        let loaderView = UIHostingController(
            rootView: BottomSheetModalView(
                c: C.color,
                viewModel: BottomSheetModalView.ViewModel(modalSubject: modalSubject, id: id)
            ) {
                ErrorModalView(c: C.color, f: C.font, title: title ?? "Error", description: description ?? "", continueButtonTapped: {[weak self] in self?.dismiss(id: id) })
        })
        loaderView.view.backgroundColor = .clear
        return loaderView
    }
}

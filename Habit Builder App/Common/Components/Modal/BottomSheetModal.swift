//
//  BottomSheetModal.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 6/8/23.
//

import Foundation
import SwiftUI
import Combine

public struct NewBottomSheetModalView<Content: View>: View {
    let c: ColorSystem
    var content: () -> Content
    @ObservedObject private var viewModel: ViewModel
    @State var showContent: Bool = false
    
    init(c: ColorSystem, viewModel: ViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.c = c
        self.content = content
        self.viewModel = viewModel
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                content()
                    .offset(y: showContent ? 0 : geometry.size.height)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .add(mod: .fullWidth())
        .background(c.get(for: .black, .main).opacity(showContent ? 0.6 : 0))
        .onAppear {
            withAnimation(.spring()) {
                showContent = true
            }
        }
        .onChange(of: viewModel.dismissModal) { _ in
            withAnimation(.spring()) {
                showContent = false
            }
            viewModel.dismissLoader()
        }
    }
}

extension NewBottomSheetModalView {
    class ViewModel: ObservableObject {
        private weak var modalSubject: NewModalSubject?
        private let id: String
        
        @Published var dismissModal: Bool = false
        
        private var subscriptions = Set<AnyCancellable>()
        
        
        init(modalSubject: NewModalSubject, id: String) {
            self.modalSubject = modalSubject
            self.id = id
            bind()
        }
        
        func bind() {
            modalSubject?
                .filter {[unowned self] in $0.id == self.id }
                .filter { $0.action == .close }
                .receive(on: RunLoop.main)
                .sink {[weak self] _ in
                    self?.dismissModal = true
                }
                .store(in: &subscriptions)
        }
        
        func dismissLoader() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[unowned self] in
                self.modalSubject?.send((id: self.id, action: .closeAnimationCompleted))
            }
        }
    }
}










public struct BottomSheetModalView<Content: View>: View {
    let c: ColorSystem
    var content: () -> Content
    @ObservedObject private var viewModel: ViewModel
    @State var showContent: Bool = false
    
    init(c: ColorSystem, viewModel: ViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.c = c
        self.content = content
        self.viewModel = viewModel
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                content()
                    .offset(y: showContent ? 0 : geometry.size.height)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .add(mod: .fullWidth())
        .background(c.get(for: .black, .main).opacity(showContent ? 0.6 : 0))
        .onAppear {
            withAnimation(.spring()) {
                showContent = true
            }
        }
        .onChange(of: viewModel.dismissModal) { _ in
            withAnimation(.spring()) {
                showContent = false
            }
            viewModel.dismissLoader()
        }
    }
}

struct BottomSheetModal_PreviewProvider: PreviewProvider {
    static var previews: some View {
        BottomSheetModalView(c: C.color, viewModel: BottomSheetModalView<LoaderView>.ViewModel(modalSubject: .init())) {
            LoaderView(c: C.color, f: C.font, title: "Something", description: "Something Fishy Something Fishy Something Fishy Something Fishy Something Fishy Something Fishy Something Fishy")
        }
    }
}

extension BottomSheetModalView {
    class ViewModel: ObservableObject {
        private let modalSubject: ModalSubject
        
        @Published var dismissModal: Bool = false
        
        private var subscriptions = Set<AnyCancellable>()
        
        
        init(modalSubject: ModalSubject) {
            self.modalSubject = modalSubject
            bind()
        }
        
        func bind() {
            modalSubject
                .filter { $0 == .close }
                .receive(on: RunLoop.main)
                .sink {[weak self] _ in
                    self?.dismissModal = true
                }
                .store(in: &subscriptions)
        }
        
        func dismissLoader() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {[weak self] in
                self?.modalSubject.send(.presentNew)
            }
        }
    }
}

enum ModalAction {
    case close, presentNew, closeAnimationCompleted
}

typealias ModalSubject = PassthroughSubject<ModalAction, Never>
typealias NewModalSubject = PassthroughSubject<(id: String, action: ModalAction), Never>

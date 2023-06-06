//
//  OnboardingViewModel.swift
//  Habit Builder App
//
//  Created by Shubroto Shuvo on 5/24/23.
//

import Foundation
import Factory
import Combine

extension OnboardingView {
    class ViewModel: ObservableObject {
        @Injected(\.onboardingCordinator) var cordinator: OnboardingCordinator
        
        @Published var activeStep: Step = .intro
        
        @Published var name: String = ""
        private var nameStepCancellable: AnyCancellable?
        
        private lazy var steps: [(step: Step, completion: () -> Future<Void, Never>)] = [
            (step: .intro, completion: {[unowned self] in self.introStep() }),
            (step: .name, completion: {[unowned self] in self.nameStep() }),
            (step: .welcome, completion: {[unowned self] in self.introStep() }),
            (step: .firstHabit, completion: {[unowned self] in self.introStep() }),
            (step: .why, completion: {[unowned self] in self.introStep() }),
            (step: .reason, completion: {[unowned self] in self.introStep() }),
            (step: .checkIn, completion: {[unowned self] in self.introStep() }),
            (step: .checkInSuccess, completion: {[unowned self] in self.introStep() })
        ]
        private var subscriptions = Set<AnyCancellable>()
        
        
        func startOnboardingProcess() {
            steps.publisher
                .flatMap(maxPublishers: .max(1)) {[weak self] stepAction -> Future<Void, Never> in
                    self?.activeStep = stepAction.step
                    return stepAction.completion()
                }
                .sink(receiveValue: {
                    print("This is waiting for meeee")
                })
                .store(in: &subscriptions)
        }
        
        private func introStep() -> Future<Void, Never> {
            Future { promise in
                let delay = 3.0
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    promise(.success(()))
                }
            }
        }
        
        private func nameStep() -> Future<Void, Never> {
            Future {[unowned self] promise in
                self.nameStepCancellable = self.$name
                    .sink(receiveValue: { value in
                        guard !value.isEmpty else {
                            return
                        }
                        promise(.success(()))
                        self.nameStepCancellable?.cancel()
                        self.nameStepCancellable = nil
                    })
            }
        }
    }
}

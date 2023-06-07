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
        
        @Published var firstHabit: String = ""
        private var firstHabitStepCancellable: AnyCancellable?
        
        @Published var whyDescription: String = ""
        private var whyStepCancellable: AnyCancellable?
        
        @Published var continueTapped: Bool = false
        private var continueCancellable: AnyCancellable?
        
        
        private lazy var steps: [(step: Step, completion: () -> Future<Void, Never>)] = [
            (step: .intro, completion: {[unowned self] in self.delayStep(by: 2.0) }),
            (step: .name, completion: {[unowned self] in self.nameStep() }),
            (step: .welcome, completion: {[unowned self] in self.delayStep(by: 3.0) }),
            (step: .firstHabit, completion: {[unowned self] in self.firstHabitInputStep() }),
            (step: .why, completion: {[unowned self] in self.whyStep() }),
            (step: .reason, completion: {[unowned self] in self.continueStepActions() }),
            (step: .checkIn, completion: {[unowned self] in self.continueStepActions() }),
            (step: .checkInSuccess, completion: {[unowned self] in self.continueStepActions() })
        ]
        
        private var subscriptions = Set<AnyCancellable>()
        
        
        func startOnboardingProcess() {
            steps.publisher
                .flatMap(maxPublishers: .max(1)) {[weak self] stepAction -> Future<Void, Never> in
                    self?.activeStep = stepAction.step
                    return stepAction.completion()
                }
                .sink(receiveValue: {[weak self] in
                    self?.continueTapped = false
                })
                .store(in: &subscriptions)
        }
        
        private func delayStep(by time: CGFloat) -> Future<Void, Never> {
            Future { promise in
                let delay = time
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
        
        private func firstHabitInputStep() -> Future<Void, Never> {
            Future {[unowned self] promise in
                self.firstHabitStepCancellable = self.$firstHabit
                    .sink(receiveValue: { value in
                        guard !value.isEmpty else {
                            return
                        }
                        promise(.success(()))
                        self.firstHabitStepCancellable?.cancel()
                        self.firstHabitStepCancellable = nil
                    })
            }
        }
        
        private func whyStep() -> Future<Void, Never> {
            Future {[unowned self] promise in
                self.whyStepCancellable = self.$whyDescription
                    .sink(receiveValue: { value in
                        guard !value.isEmpty else {
                            return
                        }
                        promise(.success(()))
                        self.whyStepCancellable?.cancel()
                        self.whyStepCancellable = nil
                    })
            }
        }
        
        private func continueStepActions() -> Future<Void, Never> {
            Future {[unowned self] promise in
                self.continueCancellable = self.$continueTapped
                    .sink(receiveValue: { value in
                        guard value else {
                            return
                        }
                        promise(.success(()))
                    })
            }
        }
    }
}

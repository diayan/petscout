//
//  AppMain.swift
//  PetScout
//
//  Created by diayan siat on 04/06/2022.
//

import SwiftUI
import PetScoutOnboarding

@main
struct AppMain: App {
    ///@AppStorage is a SwiftUI property wrapper that works hand-in-hand with UserDefaults.
    ///It saves the value of shouldPresentOnboarding in UserDefaults.
    @AppStorage(AppUserDefaultsKeys.onboarding) var shouldPresentOnboarding = true
    ///model data to show first time user
    var onboardingModels: [OnboardingModel] {
        [
            OnboardingModel(
                title: "Welcome to\n PetScout",
                description:
                    "Looking for a Pet?\n Then you're at the right place",
                image: .bird
            ),
            OnboardingModel(
                title: "Search...",
                description:
                    "Search from a list of our huge database of animals.",
                image: .dogBoneStand
            ),
            OnboardingModel(
                title: "Nearby",
                description:
                    "Find pets to adopt from nearby your place...",
                image: .chameleon
            )
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            ///show fullscreen cover if shouldPresentOnboarding is true
                .fullScreenCover(isPresented: $shouldPresentOnboarding, onDismiss: nil) {
                    PetScoutOnboardingView(items: onboardingModels)
                        .onSkip {
                            shouldPresentOnboarding = false //to avoid showing onboarding again
                        }
                }
        }
    }
}

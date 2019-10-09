//
//  AppDelegate.swift
//  TargetsCheck
//
//  Created by Александр Чаусов on 08/10/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - Private Properties

    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    // MARK: - ApplicationService

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        initializeRootView()
        applicationCoordinator.start()
        return true
    }

}

// MARK: - Private Methods

private extension AppDelegate {

    func makeCoordinator() -> Coordinator {
        let router = MainRouter()
        return MainCoordinator(router: router)
    }

    func initializeRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }

}

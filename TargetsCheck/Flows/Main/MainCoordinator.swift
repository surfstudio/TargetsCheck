//
//  MainCoordinator.swift
//  TargetsCheck
//
//  Created by Александр Чаусов on 09/10/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {

    // MARK: - MainCoordinatorOutput

    // MARK: - Private Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Coordinator

    override func start(with deepLinkOption: DeepLinkOption?) {
        showModule()
    }

}

// MARK: - Private Methods

private extension MainCoordinator {

    func showModule() {
        let (view, _) = MainModuleConfigurator().configure()
        router.setRootModule(view)
    }

}

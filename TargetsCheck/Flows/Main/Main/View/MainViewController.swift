//
//  MainViewController.swift
//  TargetsCheck
//
//  Created by Александр Чаусов on 09/10/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Properties

    var output: MainViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {

    func setupInitialState() {
    }

}

//
//  MainModuleConfiguratorTests.swift
//  TargetsCheck
//
//  Created by Александр Чаусов on 09/10/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import XCTest
@testable import TargetsCheck

final class MainModuleConfiguratorTests: XCTestCase {

    // MARK: - Main tests

    func testDeallocation() {
        assertDeallocation(of: {
            let (view, output) = MainModuleConfigurator().configure()
            return (view, [output])
        })
    }

}

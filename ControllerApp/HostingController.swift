//
//  HostingController.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/16/25.
//

import SwiftUI

class HostingController: UIHostingController<ContentView> {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return true
    }
}

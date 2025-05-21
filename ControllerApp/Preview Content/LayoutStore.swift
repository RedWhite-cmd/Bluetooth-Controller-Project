//
//  LayoutStore.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 5/21/25.
//

import SwiftUI

class LayoutStore: ObservableObject {
    @Published var savedLayouts: [SavedLayout] = []
}

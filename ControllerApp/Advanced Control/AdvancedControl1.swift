//
//  AdvancedControl1.swift
//  ControllerApp
//
//  Created by Paul O'Connell on 4/23/25.
//

import SwiftUI

struct AdvancedControl: View {
    var body: some View {
        Grid {
            ForEach(0..<4) {_ in
                GridRow {
                    ForEach(0..<2) { _ in
                        Color.red
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedControl()
}

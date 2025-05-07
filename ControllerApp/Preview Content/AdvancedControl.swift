//
//  AdvancedControl.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 4/30/25.
//

import SwiftUI

struct DraggableControl: Identifiable {
    let id = UUID()
    var type: ControlType
    var position: CGPoint
}

enum ControlType: String, CaseIterable, Identifiable {
    case joystick, slider
    var id: String { rawValue }
}

struct AdvancedControl: View {
    @State private var controls: [DraggableControl] = []
    @State private var placementMode: ControlType? = nil
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            // Top Bar with controls (no Bluetooth)
            HStack {
                Button("← Back to Welcome") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.blue)

                Spacer()

                Button("Add Joystick") {
                    placementMode = .joystick
                }
                .buttonStyle(.bordered)

                Button("Add Slider") {
                    placementMode = .slider
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background(Color.white.shadow(radius: 2))

            Divider()

            // Canvas space for draggable controls
            GeometryReader { geo in
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .onTapGesture { location in
                            if let type = placementMode {
                                controls.append(
                                    DraggableControl(type: type, position: location)
                                )
                                placementMode = nil
                            }
                        }

                    ForEach($controls) { $control in
                        ZStack(alignment: .topTrailing) {
                            controlView(for: control.type)
                                .frame(width: control.type == .joystick ? 120 : 60,
                                       height: control.type == .joystick ? 120 : 200)
                                .position(control.position)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            control.position = value.location
                                        }
                                )

                            Button(action: {
                                if let index = controls.firstIndex(where: { $0.id == control.id }) {
                                    controls.remove(at: index)
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .offset(x: 60, y: -10)
                            .position(x: control.position.x + 40, y: control.position.y - 60)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    @ViewBuilder
    func controlView(for type: ControlType) -> some View {
        switch type {
        case .joystick:
            JoystickView(xDataport: Int.random(in: 10...19), yDataport: Int.random(in: 20...29))
        case .slider:
            VerticalSlider(Dataport: Int.random(in: 30...40))
        }
    }
}

#Preview {
    AdvancedControl()
}


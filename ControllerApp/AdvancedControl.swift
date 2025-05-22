//
//  AdvancedControl.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 4/30/25.
//

import SwiftUI

// MARK: - Models

struct DraggableControl: Identifiable, Codable {
    let id: UUID
    var type: ControlType
    var position: CGPoint

    init(id: UUID = UUID(), type: ControlType, position: CGPoint) {
        self.id = id
        self.type = type
        self.position = position
    }
}

enum ControlType: String, CaseIterable, Identifiable, Codable {
    case joystick, slider
    var id: String { rawValue }
}

struct SavedLayout: Identifiable, Codable {
    let id: UUID
    let name: String
    let controls: [DraggableControl]
    
    init(id: UUID = UUID(), name: String, controls: [DraggableControl]) {
        self.id = id
        self.name = name
        self.controls = controls
    }
}


// MARK: - Main View

struct AdvancedControl: View {
    @ObservedObject var layoutStore: LayoutStore
    @State private var controls: [DraggableControl] = []
    @State private var placementMode: ControlType? = nil
    @Environment(\.presentationMode) private var presentationMode

    @State private var savedLayouts: [SavedLayout] = []
    @State private var showSaveAlert = false
    @State private var newLayoutName = ""
    @State private var showRestoreSheet = false

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

                Button("💾 Save Layout") {
                    showSaveAlert = true
                }
                .buttonStyle(.bordered)

                Button("📂 Restore Layout") {
                    showRestoreSheet = true
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
        .alert("Name this layout", isPresented: $showSaveAlert, actions: {
            TextField("Layout name", text: $newLayoutName)
            Button("Save") {
                let layout = SavedLayout(name: newLayoutName, controls: controls)
                layoutStore.savedLayouts.append(layout)
                newLayoutName = ""
            }
            Button("Cancel", role: .cancel) {
                newLayoutName = ""
            }
        }, message: {
            Text("You can restore this layout later.")
        })
        .sheet(isPresented: $showRestoreSheet) {
            NavigationView {
                List {
                    ForEach(layoutStore.savedLayouts) { layout in
                        Button(action: {
                            controls = layout.controls
                            showRestoreSheet = false
                        }) {
                            Text(layout.name)
                                .padding()
                        }
                    }
                    .onDelete { indices in
                        layoutStore.savedLayouts.remove(atOffsets: indices)
                    }
                }
                .navigationTitle("Saved Layouts")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Done") {
                            showRestoreSheet = false
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
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

// MARK: - Previews

#Preview {
    AdvancedControl(layoutStore: LayoutStore())
}


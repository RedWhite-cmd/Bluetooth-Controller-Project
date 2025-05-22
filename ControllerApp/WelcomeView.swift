import SwiftUI

struct WelcomeView: View {
    @State private var path = NavigationPath()
    @State private var showingInfo = false
    @StateObject private var layoutStore = LayoutStore()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ZStack(alignment: .topTrailing) {
                    VStack(spacing: 40) {
                        Text("Welcome to BlueSync")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .shadow(radius: 2)

                        VStack(spacing: 20) {
                            NavigationButton(title: "Basic Control", systemImage: "slider.horizontal.3") {
                                path.append("ContentView")
                            }

                            NavigationButton(title: "Advanced Control", systemImage: "rectangle.3.offgrid") {
                                path.append("AdvancedControl")
                            }

                            NavigationButton(title: "Bluetooth Control", systemImage: "dot.radiowaves.left.and.right") {
                                path.append("BluetoothControlView")
                            }
                        }
                    }

                    // Info Button
                    Button(action: {
                        showingInfo = true
                    }) {
                        Image(systemName: "questionmark.circle")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "ContentView":
                    ContentView()
                case "AdvancedControl":
                    AdvancedControl(layoutStore: layoutStore)
                case "BluetoothControlView":
                    BluetoothView()
                default:
                    EmptyView()
                }
            }
            .sheet(isPresented: $showingInfo) {
                InfoView()
            }
        }
    }
}

struct NavigationButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemImage)
                    .font(.title2)
                Text(title)
                    .fontWeight(.semibold)
                    .font(.title3)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.9))
            .foregroundColor(.blue)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 4)
        }
        .padding(.horizontal)
    }
}

struct InfoView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("About BlueSync")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("BlueSync allows seamless connection to your microcontroller via Bluetooth. Use the control interfaces to send commands or read sensor data.")

                    Divider()

                    Text("Button Guide")
                        .font(.headline)

                    Label("Basic Control", systemImage: "slider.horizontal.3")
                    Text("Use simple sliders and toggles to interact with your microcontroller.")

                    Label("Advanced Control", systemImage: "rectangle.3.offgrid")
                    Text("Customize the layout of joysticks and sliders for more complex interactions.")

                    Label("Bluetooth Control", systemImage: "dot.radiowaves.left.and.right")
                    Text("Manage your Bluetooth connection. Scan, connect, and monitor devices.")

                    Divider()

                    Text("Connecting via Bluetooth")
                        .font(.headline)

                    Text("""
                    1. Go to 'Bluetooth Control'.
                    2. Tap 'Scan' to search for nearby devices.
                    3. Select your microcontroller from the list.
                    4. Once connected, return to any control screen to start interacting.
                    """)
                }
                .padding()
            }
            .navigationTitle("App Info")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}

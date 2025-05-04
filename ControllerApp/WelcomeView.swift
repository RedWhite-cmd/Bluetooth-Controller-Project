import SwiftUI

struct NavButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 250)
            .padding()
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(12)
    }
}

struct WelcomeView: View {
    @State private var path = NavigationPath()
    @ObservedObject var btInterface = BTInterface.bluetooth

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(.systemBlue).ignoresSafeArea()

                VStack(spacing: 40) {
                    Text("Welcome to BlueSync")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Button("Basic Control") {
                        path.append("ContentView")
                    }
                    .modifier(NavButtonStyle())

                    Button("Advanced Control") {
                        path.append("AdvancedControl")
                    }
                    .modifier(NavButtonStyle())
                    
                    // Bluetooth Button
                    Button("Bluetooth Control") {
                        btInterface.service.toggleScan()  // Starts Bluetooth scan
                        path.append("BluetoothControlView")
                    }
                    .modifier(NavButtonStyle())
                }
                .navigationDestination(for: String.self) { value in
                    switch value {
                    case "ContentView":
                        ContentView()
                    case "AdvancedControl":
                        AdvancedControl()
                    case "BluetoothControlView":
                        BluetoothView()
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}

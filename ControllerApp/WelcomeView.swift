import SwiftUI

struct WelcomeView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

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
                .padding()
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

#Preview {
    WelcomeView()
}

import SwiftUI

struct WelcomeView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(.systemBlue).ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Text("Welcome to BlueSync")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        path.append("goToController")
                    }) {
                        Text("Continue")
                            .font(.title2)
                            .padding()
                            .frame(width: 200)
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                    }
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "goToController" {
                    ContentView()
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}

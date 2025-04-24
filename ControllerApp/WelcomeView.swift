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
                        Text("Basic Control")
                            .font(.title2)
                            .padding()
                            .frame(width: 200)
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                    }
                    
                    
                    Button(action: {
                        path.append("goToAdvanced")
                    }) {
                        Text("Advanced Control")
                            .font(.title2)
                            .padding()
                            .frame(width: 250)
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                    }
                    
                    /*
                    Button(action: {
                        path.append("goToHelp")
                    }){
                    Text("Help")
                        .font(.title2)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                }
                    */
                    
                    .navigationDestination(for: String.self) { value in
                        if value == "goToController" {
                            ContentView()
                        } else if value == "goToAdvanced" {
                            AdvancedControl()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showSplash = true

    var body: some View {
        if showSplash {
            SplashView()
                .task {
                    try? await Task.sleep(for: .seconds(2))
                    withAnimation {
                        showSplash = false
                    }
                }
        } else {
            MainView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Journal.self, inMemory: true)
}

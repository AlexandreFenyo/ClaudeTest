import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AnimationDemo()
                .tabItem { Label("Animations", systemImage: "sparkles") }
            ShapesDemo()
                .tabItem { Label("Formes", systemImage: "square.on.circle") }
            InteractiveDemo()
                .tabItem { Label("Interactif", systemImage: "hand.tap") }
            ToolsView()
                .tabItem { Label("Tools", systemImage: "wrench.and.screwdriver") }
        }
    }
}

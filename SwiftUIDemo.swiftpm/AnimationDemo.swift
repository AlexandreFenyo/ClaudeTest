import SwiftUI

struct AnimationDemo: View {
    @State private var isAnimating = false
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var colorIndex = 0

    let colors: [Color] = [.purple, .blue, .cyan, .green, .yellow, .orange, .red]

    var body: some View {
        ZStack {
            AnimatedBackground()

            VStack(spacing: 40) {
                Text("Animations SwiftUI")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                ZStack {
                    ForEach(0..<8) { i in
                        Circle()
                            .fill(colors[i % colors.count].opacity(0.7))
                            .frame(width: 20, height: 20)
                            .offset(y: -80)
                            .rotationEffect(.degrees(Double(i) * 45 + rotation))
                            .animation(
                                .linear(duration: 2).repeatForever(autoreverses: false),
                                value: rotation
                            )
                    }

                    Image(systemName: "star.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.yellow)
                        .scaleEffect(scale)
                        .animation(
                            .easeInOut(duration: 1).repeatForever(autoreverses: true),
                            value: scale
                        )
                }
                .frame(height: 200)

                VStack(spacing: 16) {
                    PulsingBall(color: .cyan, delay: 0)
                    HStack(spacing: 20) {
                        PulsingBall(color: .orange, delay: 0.2)
                        PulsingBall(color: .pink, delay: 0.4)
                        PulsingBall(color: .green, delay: 0.6)
                    }
                }

                Button(isAnimating ? "Arrêter" : "Démarrer") {
                    isAnimating.toggle()
                    if isAnimating {
                        rotation = 360
                        scale = 1.4
                    } else {
                        rotation = 0
                        scale = 1.0
                    }
                }
                .buttonStyle(DemoButtonStyle(color: .white))
            }
            .padding()
        }
        .onAppear {
            rotation = 360
            scale = 1.4
            isAnimating = true
        }
    }
}

struct PulsingBall: View {
    let color: Color
    let delay: Double
    @State private var pulse = false

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 30, height: 30)
            .scaleEffect(pulse ? 1.5 : 0.8)
            .opacity(pulse ? 1.0 : 0.4)
            .animation(
                .easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(delay),
                value: pulse
            )
            .onAppear { pulse = true }
    }
}

struct AnimatedBackground: View {
    @State private var animate = false

    var body: some View {
        LinearGradient(
            colors: animate
                ? [Color(red: 0.1, green: 0.1, blue: 0.4), Color(red: 0.5, green: 0.1, blue: 0.5)]
                : [Color(red: 0.2, green: 0.0, blue: 0.5), Color(red: 0.0, green: 0.2, blue: 0.6)],
            startPoint: animate ? .topLeading : .bottomLeading,
            endPoint: animate ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: animate)
        .onAppear { animate = true }
    }
}

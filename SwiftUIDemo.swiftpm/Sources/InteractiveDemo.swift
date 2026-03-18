import SwiftUI

struct InteractiveDemo: View {
    @State private var hue: Double = 0.6
    @State private var brightness: Double = 0.8
    @State private var saturation: Double = 0.8
    @State private var ballPosition: CGPoint = CGPoint(x: 150, y: 200)
    @State private var ballVelocity: CGSize = CGSize(width: 3, height: 3)
    @State private var ballColor: Color = .cyan
    @State private var isBouncingActive = false
    @State private var timer: Timer? = nil
    @State private var tapCount = 0

    var selectedColor: Color {
        Color(hue: hue, saturation: saturation, brightness: brightness)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Interactif")
                    .font(.largeTitle.bold())
                    .padding(.top)

                // Sélecteur de couleur
                VStack(alignment: .leading, spacing: 12) {
                    Text("Mélangeur de couleur")
                        .font(.headline)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(selectedColor)
                        .frame(height: 80)
                        .shadow(color: selectedColor.opacity(0.6), radius: 10)
                        .animation(.easeInOut(duration: 0.2), value: hue)

                    LabeledSlider(label: "Teinte", value: $hue, range: 0...1, color: .rainbow)
                    LabeledSlider(label: "Saturation", value: $saturation, range: 0...1, color: selectedColor)
                    LabeledSlider(label: "Luminosité", value: $brightness, range: 0...1, color: .yellow)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)

                // Balle rebondissante
                VStack {
                    Text("Balle rebondissante")
                        .font(.headline)
                    GeometryReader { geo in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black.opacity(0.15))
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [ballColor.opacity(0.9), ballColor.opacity(0.4)],
                                        center: .topLeading,
                                        startRadius: 0,
                                        endRadius: 30
                                    )
                                )
                                .frame(width: 40, height: 40)
                                .shadow(color: ballColor, radius: 8)
                                .position(ballPosition)
                                .onAppear {
                                    ballPosition = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
                                }
                        }
                        .onChange(of: geo.size) { newSize in
                            ballPosition = CGPoint(x: newSize.width / 2, y: newSize.height / 2)
                        }
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Button(isBouncingActive ? "Arrêter" : "Lancer la balle") {
                        isBouncingActive.toggle()
                        if isBouncingActive { startBouncing() } else { stopBouncing() }
                    }
                    .buttonStyle(DemoButtonStyle(color: ballColor))
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)

                // Compteur de taps
                VStack(spacing: 16) {
                    Text("Compteur de taps")
                        .font(.headline)
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: tapColor(for: tapCount),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 140, height: 140)
                            .shadow(color: tapColor(for: tapCount).first!.opacity(0.5), radius: 12)
                            .scaleEffect(1.0)
                        VStack {
                            Text("\(tapCount)")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            Text("taps")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                            tapCount += 1
                        }
                    }
                    Button("Réinitialiser") {
                        withAnimation { tapCount = 0 }
                    }
                    .buttonStyle(DemoButtonStyle(color: .gray))
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .onDisappear { stopBouncing() }
    }

    func tapColor(for count: Int) -> [Color] {
        switch count {
        case 0...5: return [.blue, .cyan]
        case 6...15: return [.green, .mint]
        case 16...30: return [.orange, .yellow]
        default: return [.red, .pink]
        }
    }

    func startBouncing() {
        ballVelocity = CGSize(width: Double.random(in: 2...5), height: Double.random(in: 2...5))
        ballColor = [Color.cyan, .pink, .orange, .green, .purple].randomElement()!
        timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            updateBall()
        }
    }

    func stopBouncing() {
        timer?.invalidate()
        timer = nil
    }

    func updateBall() {
        let bounds = CGRect(x: 20, y: 20, width: 260, height: 160)
        var newX = ballPosition.x + ballVelocity.width
        var newY = ballPosition.y + ballVelocity.height
        var vx = ballVelocity.width
        var vy = ballVelocity.height

        if newX <= bounds.minX || newX >= bounds.maxX {
            vx = -vx
            newX = newX <= bounds.minX ? bounds.minX : bounds.maxX
            ballColor = [Color.cyan, .pink, .orange, .green, .purple].randomElement()!
        }
        if newY <= bounds.minY || newY >= bounds.maxY {
            vy = -vy
            newY = newY <= bounds.minY ? bounds.minY : bounds.maxY
            ballColor = [Color.cyan, .pink, .orange, .green, .purple].randomElement()!
        }

        ballPosition = CGPoint(x: newX, y: newY)
        ballVelocity = CGSize(width: vx, height: vy)
    }
}

struct LabeledSlider: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let color: Color

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .frame(width: 80, alignment: .leading)
            Slider(value: $value, in: range)
                .tint(color)
        }
    }
}

struct DemoButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(color == .white ? .black : .white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(color == .white ? Color.white : color, in: Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.2), value: configuration.isPressed)
    }
}

extension Color {
    static let rainbow = Color(hue: 0.5, saturation: 1, brightness: 1)
}

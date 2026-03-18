import SwiftUI

struct ShapesDemo: View {
    @State private var progress: CGFloat = 0.7
    @State private var sides: Double = 6
    @State private var animateWave = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Formes & Dessins")
                    .font(.largeTitle.bold())
                    .padding(.top)

                // Polygone personnalisé
                VStack {
                    Text("Polygone — \(Int(sides)) côtés")
                        .font(.headline)
                    Polygon(sides: Int(sides))
                        .fill(
                            LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 150, height: 150)
                    Slider(value: $sides, in: 3...12, step: 1)
                        .padding(.horizontal, 40)
                        .tint(.purple)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)

                // Arc de progression
                VStack {
                    Text("Arc de progression")
                        .font(.headline)
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 12)
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                AngularGradient(colors: [.blue, .purple, .pink], center: .center),
                                style: StrokeStyle(lineWidth: 12, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.spring(), value: progress)
                        Text("\(Int(progress * 100))%")
                            .font(.title.bold())
                    }
                    .frame(width: 150, height: 150)
                    Slider(value: $progress, in: 0...1)
                        .padding(.horizontal, 40)
                        .tint(.purple)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)

                // Onde sinusoïdale
                VStack {
                    Text("Onde sinusoïdale")
                        .font(.headline)
                    WaveShape(offset: animateWave ? 1 : 0)
                        .fill(
                            LinearGradient(colors: [.cyan.opacity(0.8), .blue.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                        )
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: animateWave)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .onAppear { animateWave = true }
    }
}

struct Polygon: Shape {
    let sides: Int

    func path(in rect: CGRect) -> Path {
        guard sides >= 3 else { return Path() }
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let angle = (2 * .pi) / Double(sides)

        for i in 0..<sides {
            let x = center.x + radius * cos(Double(i) * angle - .pi / 2)
            let y = center.y + radius * sin(Double(i) * angle - .pi / 2)
            if i == 0 { path.move(to: CGPoint(x: x, y: y)) }
            else { path.addLine(to: CGPoint(x: x, y: y)) }
        }
        path.closeSubpath()
        return path
    }
}

struct WaveShape: Shape {
    var offset: CGFloat

    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height * 0.5
        let wavelength = width / 2

        path.move(to: CGPoint(x: 0, y: midHeight))
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            let y = midHeight + sin((relativeX + offset) * 2 * .pi) * (height * 0.3)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        return path
    }
}

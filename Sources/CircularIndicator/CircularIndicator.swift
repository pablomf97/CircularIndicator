import SwiftUI

@available(iOS 13, *)
struct CircularIndicator: View {
    
    let title: String
    let textColor: Color
    let backgroundColor: Color
    let foregroundColor: Color
    let duration: Double
    
    init(
        title: String = "",
        textColor: Color = .black,
        backgroundColor: Color = .blue.opacity(0.3),
        foregroundColor: Color = .blue,
        duration: Double = 0.75
    ) {
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.duration = duration
    }
    
    @State private var rotation = Angle(degrees: 0)
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.3)
                    .foregroundColor(backgroundColor)
                
                Circle()
                    .trim(from: 0, to: 0.1)
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 10.0,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .foregroundColor(foregroundColor)
                    .rotationEffect(Angle(degrees: 270.0))
                    .rotationEffect(rotation)
                    .animateForever(
                        using: .easeInOut(duration: duration),
                        autoreverses: false
                    )
                {
                    rotation.degrees = 360
                }
            }
            .frame(maxWidth: 50, maxHeight: 50)

            if !title.isEmpty {
                Text(title)
                    .foregroundColor(textColor)
                    .bold()
                    .padding(6.0)
            }
        }
    }
}

@available(iOS 13, *)
extension View {
    func animateForever(
        using animation: Animation = .easeInOut(duration: 1),
        autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}

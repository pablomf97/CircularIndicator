import SwiftUI

@available(iOS 13, *)
public struct DefaultCircularIndicator: View {
    
    public var title: String
    public var textColor: Color
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var duration: Double
    
    public init(
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
    
    public var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.3)
                    .foregroundColor(backgroundColor)
                
                Circle()
                    .trim(from: 0, to: 0.3)
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
public struct SlowCircularIndicator: View {
    
    public var title: String
    public var textColor: Color
    public var backgroundColor: Color
    public var foregroundColor: Color
    public var duration: Double
    
    public init(
        title: String = "",
        textColor: Color = .black,
        backgroundColor: Color = .blue.opacity(0.3),
        foregroundColor: Color = .blue,
        duration: Double = 3
    ) {
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.duration = duration
    }
    
    @State private var rotation = Angle(degrees: 0)
    
    @State private var endAmount: CGFloat = 0

    public var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.3)
                    .foregroundColor(backgroundColor)
                
                Circle()
                    .trim(from: 0, to: endAmount)
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
                        autoreverses: true
                    ) {
                        endAmount = 0.999
                    }
                    .animateForever(
                        using: .easeInOut(duration: duration),
                        autoreverses: false
                    ) {
                        rotation.degrees = 720
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

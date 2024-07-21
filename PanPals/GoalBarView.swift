import SwiftUI

struct GoalBarView: View {
    var goalRange: ClosedRange<Int>
    var currentProgress: Int

    private var progress: Double {
        let adjustedProgress = Double(currentProgress)
        return max(0, min(1, adjustedProgress / Double(goalRange.upperBound)))
    }

    private var lowerMarkerPosition: Double {
        return Double(goalRange.lowerBound) / Double(goalRange.upperBound)
    }

    private var upperMarkerPosition: Double {
        return Double(goalRange.upperBound - 1) / Double(goalRange.upperBound)
    }

    private var barColor: Color {
        if currentProgress > goalRange.upperBound {
            return .red
        } else if currentProgress >= goalRange.lowerBound {
            return .orange
        } else {
            return .blue
        }
    }

    private var goalMessage: String {
        if currentProgress > goalRange.upperBound {
            return "You have exceeded your goal!"
        } else if currentProgress >= goalRange.lowerBound {
            return "You are doing well!"
        } else {
            let remaining = goalRange.lowerBound - currentProgress
            return "\(remaining) more meals to go."
        }
    }

    var body: some View {
        VStack {
            HStack {
                Text("0")
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 20)
                            .foregroundColor(Color.gray.opacity(0.3))

                        Rectangle()
                            .frame(width: geometry.size.width * CGFloat(progress), height: 20)
                            .foregroundColor(barColor)

                        // Lower goal marker
                        Rectangle()
                            .frame(width: 2, height: 20)
                            .foregroundColor(.black)
                            .offset(x: geometry.size.width * CGFloat(lowerMarkerPosition) - 1)

                        // Upper goal marker
                        Rectangle()
                            .frame(width: 2, height: 20)
                            .foregroundColor(.black)
                            .offset(x: geometry.size.width * CGFloat(upperMarkerPosition) - 1)
                    }
                    .cornerRadius(10)
                }
                Text("∞")
            }
            .padding(.horizontal)

            Text(goalMessage)
                .font(.subheadline)
                .foregroundColor(barColor)
                .padding(.top, 5)
        }
        .padding()
    }
}

struct GoalBarView_Previews: PreviewProvider {
    static var previews: some View {
        GoalBarView(goalRange: 1...7, currentProgress: 3)
            .previewLayout(.sizeThatFits)
    }
}

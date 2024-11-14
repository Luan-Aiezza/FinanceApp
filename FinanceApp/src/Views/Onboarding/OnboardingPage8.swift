import SwiftUI
import SwiftData

struct OnboardingPage8: View {
    var body: some View {
        VStack(spacing: 36){
            Text("Welcome!")
                .font(
                    Font.custom("Pally-Bold", size: 64)
                        .weight(.medium)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Image("HistoryOnboarding")
                .resizable()
                .scaledToFit()
            
        }
    }
}

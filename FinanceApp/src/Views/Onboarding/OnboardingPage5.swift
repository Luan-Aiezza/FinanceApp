import SwiftUI
import SwiftData

struct OnboardingPage5: View {
    var body: some View {
        VStack(spacing: 36){
            Text("This is your child's monthly history page! here he will be able to see his development")
                .font(
                    Font.custom("Pally-Bold", size: 30)
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

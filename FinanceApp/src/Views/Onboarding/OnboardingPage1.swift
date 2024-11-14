import SwiftUI
import SwiftData

struct OnboardingPage1: View {
    var body: some View {
        VStack(spacing: 36){
            Spacer()
            Text("By creating tasks from your account, your child completes these tasks and can earn coins, exchanging them with you for real value if they wish!")
                .font(
                    Font.custom("Pally-Bold", size: 36)
                        .weight(.medium)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
            Image("TrueCoinIcon")
                .resizable()
                .scaledToFit()
            Spacer()
        }
    }
}

import SwiftUI
import SwiftData

struct OnboardingPage0: View {
    var body: some View {
        VStack(spacing: 36){
            Spacer()
            Text("Welcome to Coinc, your app to help your child learn the value of money!")
                .font(
                    Font.custom("Pally-Bold", size: 36)
                        .weight(.medium)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
            Image("porco")
                .resizable()
                .scaledToFit()
            Spacer()
            
        }
    }
}

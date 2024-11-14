import SwiftUI
import SwiftData

struct OnboardingPage4: View {
    var body: some View {
        VStack(spacing: 36){
            Spacer()
            Text("Now, let's get started!")
                .font(
                    Font.custom("Pally-Bold", size: 36)
                        .weight(.medium)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
            
            Image("Low eff 2")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
        }
    }
}

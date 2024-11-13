import SwiftUI
import SwiftData

struct OnboardingPage6: View {
    var body: some View {
        VStack(spacing: 36){
            Text("Now let's create your guardian profile!")
                .font(
                    Font.custom("Pally-Bold", size: 30)
                        .weight(.medium)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Image("Add Profile")
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fill)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 4)
                )
                .shadow(radius: 5)
            Spacer()
        }
    }
}

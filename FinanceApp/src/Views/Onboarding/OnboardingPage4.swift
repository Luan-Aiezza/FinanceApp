import SwiftUI
import SwiftData

struct OnboardingPage4: View {
    var body: some View {
        VStack(spacing: 36){
            Spacer()
            ZStack{
                Image("Rectangle 3")
                    .resizable()
                    .frame(width: 694, height: 180)
                    .scaledToFit()
                
                Text("Now let's get started!")
                    .font(
                        Font.custom("Pally-Bold", size: 28)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .multilineTextAlignment(.center)
            }
            Image("PiggyPurple 1")
                .resizable()
                .scaledToFit()
                .frame(width: 386, height: 472)
            Spacer()
            
        }
    }
}

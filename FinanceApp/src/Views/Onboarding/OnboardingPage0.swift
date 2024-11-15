import SwiftUI
import SwiftData

struct OnboardingPage0: View {
    var body: some View {
        VStack(spacing: 36){
            Spacer()
            ZStack{
                Image("Rectangle 3")
                    .resizable()
                    .frame(width: 694, height: 180)
                    .scaledToFit()
                
                Text("Welcome to Coinc, your app to help your child learn\n the value of money!")
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

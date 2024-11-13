import SwiftUI
import SwiftData

struct OnboardingPage8: View {
    
    @State var valueCoinc: String = ""
    
    var body: some View {
        VStack(spacing: 36){
            VStack(alignment: .leading) {
                Text("Create guardian profile")
                .font(
                Font.custom("Pally-Bold", size: 30)
                .weight(.medium)
                )
                .foregroundColor(.white)
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
            .background(Color(red: 0.36, green: 0, blue: 0.55))
            .cornerRadius(24)
            
            Text("Now define how much a Coinc coin will be worth to your child, according to your preference.")
                .font(
                    Font.custom("Pally-Regular", size: 24)
                        .weight(.medium)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Reward settings")
                .font(
                Font.custom("Pally-Bold", size: 22)
                .weight(.bold)
                )
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text("How much is an in-app coinc worth in real life?")
                .font(Font.custom("Pally-Regular", size: 17))
                .foregroundColor(Color.black)
                
                HStack() {
                    
                    Text("$")
                    
                    TextField(" 1,00", text: $valueCoinc)
                        .frame(minHeight: 44)
                        .background(Color(red: 1, green: 1, blue: 1))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                    
                }
                .padding(.vertical, 0)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.94, green: 0.9, blue: 0.95))
            .cornerRadius(24)
            Spacer()
        }
    }
}

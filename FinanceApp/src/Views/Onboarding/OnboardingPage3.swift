import SwiftUI
import SwiftData

struct OnboardingPage3: View {
    
    @State var valueCoinc: String = "1,00"
    
    var body: some View {
        VStack(spacing: 36){
            VStack(alignment: .leading) {
                Text("Create guardian profile")
                    .font(
                        Font.custom("Pally-Bold", size: 24)
                            .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
            .background(Color(red: 0.36, green: 0, blue: 0.55))
            .cornerRadius(24)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Allowance settings")
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
                        .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                    
                    TextField(" 1,00", text: $valueCoinc)
                        .padding(.leading)
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
            .clipShape(.rect(cornerRadius: 24.0))
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.85, green: 0.76, blue: 0.89))
                    .offset(x:0, y: 6)
                    )
            
            Spacer()
            ZStack{
                Image("Rectangle 3")
                    .resizable()
                    .frame(minWidth: 775, minHeight: 220)
                    .scaledToFit()
                
                Text("Now define how much a Coinc coin will be worth\n to your child, according to your preference.")
                    .font(
                        Font.custom("Pally-Bold", size: 28)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .multilineTextAlignment(.center)
                    .frame(width: 634, alignment: .center) // Defina os limites
                    .lineLimit(nil) // Permite várias linhas (ou ajuste o limite, se necessário)
                    .padding(.horizontal, 20) // Adiciona espaçamento interno
            }
            Image("PiggyPurple 1")
                .resizable()
                .scaledToFit()
                .frame(width: 216, height: 264)
            
            Spacer()
        }
    }
}

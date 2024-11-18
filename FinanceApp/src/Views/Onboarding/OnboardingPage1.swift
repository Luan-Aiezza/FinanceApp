import SwiftUI
import SwiftData

struct OnboardingPage1: View {
    var body: some View {
        VStack(spacing: 36){
            Spacer()
            ZStack{
                Image("Rectangle 3")
                    .resizable()
                    .frame(minWidth: 775, minHeight: 240)
                    .scaledToFit()
                
                Text("By creating tasks from your account, your child\n completes these tasks and can earn coins, exchanging\n them with you for real value if they wish!")
                    .font(
                        Font.custom("Pally-Bold", size: 28)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
                    .multilineTextAlignment(.center)
                    .frame(width: 734, alignment: .center) // Defina os limites
                    .lineLimit(nil) // Permite várias linhas (ou ajuste o limite, se necessário)
                    .padding(.horizontal, 20) // Adiciona espaçamento interno
            }
            Image("PiggyPurple 1")
                .resizable()
                .scaledToFit()
                .frame(width: 386, height: 472)
            Spacer()
        }
    }
}

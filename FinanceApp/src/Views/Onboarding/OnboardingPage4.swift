import SwiftUI
import SwiftData

struct OnboardingPage4: View {
    var body: some View {
        VStack(spacing: 36){
            Text("Essa é a página de histórico do seu filho! aqui ele poderá ver como se saiu em cada mês.")
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

import SwiftUI

struct CButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        VStack{
            Button(action: {action()}) {
                HStack(alignment: .center, spacing: 8) { Text(text)
                        .font(
                          Font.custom("Pally-Regular", size: 17)
                            .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("CardTextTP"))
                        .frame(maxWidth: .infinity, alignment: .center) }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, minHeight: 44, alignment: .center)
                .background(Color("ButtonBG"))
                .cornerRadius(24)
                .offset(y: -4)
                .overlay(
                  RoundedRectangle(cornerRadius: 24)
                    .inset(by: 0.5)
                    .stroke(Color("CardShadowBG"), lineWidth: 1)
                )
                .background(Color("CardShadowBG")) // Cor principal do botão
                    .cornerRadius(24)
            }
            .frame(maxWidth: .infinity)
            .shadow(color: Color("CardShadowBG").opacity(0.5), radius: 5, x: 0, y: 4) // Adiciona um efeito de sombra sutil
        }

    }
}

#Preview {
    CButton(text: "Teste", action: {print("Teste")})
}

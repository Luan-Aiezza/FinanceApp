import SwiftUI
import SwiftData

struct OnboardingPage2: View {
    
    @State private var showIconSelection = false
    @AppStorage("selectedGuardianIcon") private var selectedGuardianIcon: String = ""
    @AppStorage("guardianName") private var guardianName: String = ""
    @AppStorage("password") private var password: String = "" // Armazenando o hash
    @Binding var isDisabled: Bool
    
    var body: some View {
        
        VStack(spacing: 36) {
            VStack(alignment: .leading) {
                Text("Create guardian profile")
                    .font(Font.custom("Pally-Bold", size: 24).weight(.medium))
                    .foregroundColor(.white)
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
            .background(Color(red: 0.36, green: 0, blue: 0.55))
            .cornerRadius(24)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Guardian")
                    .font(Font.custom("Pally-Bold", size: 17).weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                HStack(alignment: .center, spacing: 40) {
                    VStack{
                        Image(selectedGuardianIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 148)
                            .background(
                                Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                    .offset(x: 0, y: 6)
                            )
                            .scaledToFit()
                            .onTapGesture {
                                showIconSelection = true
                            }
                            .gesture(
                                LongPressGesture().onEnded { _ in
                                    showIconSelection = true
                                }
                            ).popover(isPresented: $showIconSelection) {
                                VStack(spacing: 20) {
                                    Text("Choose an Icon")
                                        .font(Font.custom("Pally-Bold", size: 22))
                                        .padding()
                                    
                                    HStack(spacing: 20) {
                                        ForEach(["Cat", "Dog", "Tiger", "Bird"], id: \.self) { iconName in
                                            Button(action: {
                                                selectedGuardianIcon = iconName
                                                showIconSelection = false
                                            }) {
                                                Image(iconName)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 80, height: 80)
                                            }
                                        }
                                    }
                                    .padding()
                                }
                                .cornerRadius(20)
                                .padding()
                            }
                        Image("CanetaOnboarding")
                            .background(
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(Color(red: 0.36, green: 0, blue: 0.55))
                                    .stroke(Color(red: 0.36, green: 0, blue: 0.55), lineWidth: 10)
                                    )
                            .offset(x: 45, y: -25) // Ajuste o valor de x e y para posicionar a coroa
                    }
                    
                    VStack(spacing: 10) {
                        TextField(" Enter your name", text: $guardianName)
                            .padding(.leading)
                            .frame(minHeight: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                            .onChange(of: guardianName){
                                if !guardianName.isEmpty && !password.isEmpty{
                                    isDisabled = false
                                }
                            }
                        
                        SecureField(" Create 4-digit PIN", text: $password)
                            .padding(.leading)
                            .keyboardType(.numberPad) // Limita a entrada para números
                            .frame(minHeight: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                            .onChange (of: password){ // Usando o novo onChange sem parâmetro explícito
                                // Limita a senha para 4 dígitos
                                if password.count > 4 {
                                    password = String(password.prefix(4))
                                }
                                if !guardianName.isEmpty && (!password.isEmpty && password.count >= 4){
                                    isDisabled = false
                                } else {
                                    isDisabled = true
                                }
                            }
                    }
                }
                .padding(.horizontal, 85)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(20)
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
                
                Text("Now let's create your guardian profile! Fill in the fields,\n if you want you can also change the profile icon.")
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
                .frame(width: 216, height: 264)
            Spacer()
        }
    }
    
}

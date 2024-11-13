import SwiftUI
import SwiftData

struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var hasCompletedOnboarding: Bool
    
    var body: some View {
        ZStack {
            Color.init(red: 0.11, green: 0, blue: 0.16)
                .ignoresSafeArea()
            
            VStack {
                if currentPage == 0 {
                    OnboardingPage1()
                } else if currentPage == 1 {
                    OnboardingPage2()
                } else if currentPage == 2 {
                    OnboardingPage3()
                } else if currentPage == 3 {
                    OnboardingPage4()
                } else if currentPage == 4 {
                    OnboardingPage5()
                } else if currentPage == 5 {
                    OnboardingPage6()
                } else if currentPage == 6 {
                    OnboardingPage7()
                } else {
                    OnboardingPage8()
                }
                
                HStack {
                    // Botão "Back", aparece apenas quando não está na primeira página
                    if currentPage > 0 {
                        Button(action: {
                            currentPage -= 1
                        }) {
                            ZStack {
                                Color(red: 0.99, green: 0.99, blue: 0.99)
                                    .cornerRadius(24)
                                Text("Back")
                                    .font(.headline)
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 16.0)
                                    .padding(.vertical, 12.0)
                            }
                            .frame(width: 150, height: 46)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                    .offset(x: 0, y: 6)
                            )
                        }
                    }
                    
                    Spacer()
                    
                    // Botão "Continue" / "Finish"
                    Button(action: {
                        if currentPage < 7 {
                            currentPage += 1
                        } else {
                            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                            hasCompletedOnboarding = true
                        }
                    }) {
                        ZStack {
                            Color(red: 0.99, green: 0.99, blue: 0.99)
                                .cornerRadius(24)
                            Text(currentPage < 7 ? "Continue" : "Finish")
                                .font(.headline)
                                .foregroundColor(Color.black)
                                .padding(.horizontal, 16.0)
                                .padding(.vertical, 12.0)
                        }
                        .frame(width: 150, height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                .offset(x: 0, y: 6)
                        )
                    }
                }
            }                .padding(.horizontal, 85)
                .padding(.vertical, 85)
        }
    }
}

struct ContentView: View {
    @State var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var body: some View {
        if !hasCompletedOnboarding {
            OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
        } else {
            ProfilesView()
        }
    }
}

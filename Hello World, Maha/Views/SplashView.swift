import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // الخلفية: تدرّج من الأسود لرمادي الكروت
            LinearGradient(
                colors: [.appBackground, .surfaceCard],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // المحتوى
            VStack(spacing: 16) {
                Image("SplashIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)

                Text("Journali")
                    .font(.display)
                    .foregroundStyle(Color.textPrimary)

                Text("Your thoughts, your story")
                    .font(.bodySupporting)
                    .foregroundStyle(Color.textPrimary)
            }
        }
    }
}

#Preview {
    SplashView()
}

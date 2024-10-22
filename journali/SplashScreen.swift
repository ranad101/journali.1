//
//  SplashScreen.swift
//  journali
//
//  Created by Ranad aldawood on 18/04/1446 AH.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive { ContentView()}
        else{
            ZStack {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.splash, location: 0.2),
                        .init(color: Color.black, location: 0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                VStack{
                    VStack {
                        Image("url")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 77.7, height: 101.0)
                            .padding(.bottom, 5)
                        
                        Text("Journali")
                            .foregroundColor(Color.white)
                            .font(.system(size: 42, weight: .black))
                            .padding(.bottom, 1)
                        
                        Text("Your thoughts, your story")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18, weight: .light))
                            .padding(.top, 1)
                            .kerning(1)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{ withAnimation(.easeIn(duration: 1.5))
                        {self.size=0.9
                            self.opacity=1.0}}
                }
                .onAppear {DispatchQueue.main.asyncAfter(deadline:.now()+2.0) { withAnimation {self.isActive = true}} }
            }
        }
    }
}

#Preview {
    SplashScreen()
}

//
//  ContentView.swift
//  journali
//
//  Created by Ranad aldawood on 17/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack { LinearGradient(stops: ([.init(color:.splash, location:0.2), .init(color: .black, location: 0.8)]),
                                startPoint: .top,
                                endPoint: .bottom)
        .ignoresSafeArea()
            Text("Journali")
                .fontWeight(.black)
                .foregroundColor(Color.white)
                .font(.system(size: 42.0))
                .frame(width: 174.0, height: 50.0)
                .position(x:201.15, y:400)
            
            Text("Your thoughts, your story")
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .padding(.top, 51.0)
                .font(.system(size: 18.0))
                .frame(width: 225.0, height: 21.0)
                .position(x:201.15, y:411)
            
            Image("url")
                .renderingMode(.original)
                .padding()
                .frame(width: 77.7, height: 101.0)
                .position(x:201.15, y:304.77)
                
        }
        
        
    }
}

#Preview {
    ContentView()
}

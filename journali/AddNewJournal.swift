//
//  AddNewJournal.swift
//  journali
//
//  Created by Ranad aldawood on 20/04/1446 AH.
//

import SwiftUI

struct AddNewJournal: View {
    var body: some View {
        ZStack{ Color.black
                .ignoresSafeArea()
            
            Button("Save") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .foregroundColor(Color.lilac)
            .offset(x:-150, y:-350)
            .font(.system(size: 16, weight: .regular))
            
            Button("Close") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .foregroundColor(Color.lilac)
            .offset(x:150, y:-350)
            .font(.system(size: 16, weight: .regular))
        }}
}

#Preview {
    AddNewJournal()
}

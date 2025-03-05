//
//  HistoryView.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 27.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("History: Soon...")
                .font(.title)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            
            Button {
                viewModel.logout {
                    dismiss()
                }
            } label: {
                Text("Log Out")
                  .foregroundColor(.white)
                  .bold()
                  .frame(width: 200, height: 50)
                  .background(Color.red)
                  .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}

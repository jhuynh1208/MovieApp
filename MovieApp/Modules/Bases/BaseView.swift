//
//  BaseView.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 4/6/25.
//

import Foundation
import SwiftUI

struct BaseView<VM: BaseViewModel, Content: View>: View {
    let title: String?
    @ObservedObject var viewModel: VM
    @ViewBuilder let content: (VM) -> Content
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                content(viewModel)
            }
        }
        .navigationTitle(title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                NetworkStatusIndicator(isConnected: viewModel.isConnected)
            }
        })
        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")) {
                // Clear error on dismiss
                viewModel.errorMessage = ""
            })
        }

    }
}

//
//  BaseViewModel.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 4/6/25.
//

import Foundation
import Combine

@MainActor
class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isConnected: Bool = true
    
    @Published var errorMessage: String = "" {
        didSet {
            isShowAlert = !errorMessage.isEmpty
        }
    }

    @Published var isShowAlert: Bool = false
    
    
    var cancellables = Set<AnyCancellable>()
}

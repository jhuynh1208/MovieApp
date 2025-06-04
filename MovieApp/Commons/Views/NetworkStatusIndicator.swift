//
//  NetworkStatusIndicator.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 4/6/25.
//


import SwiftUI

struct NetworkStatusIndicator: View {
    let isConnected: Bool
    var body: some View {
        Image(systemName: isConnected ? "wifi" : "wifi.slash")
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.white)
            .frame(width: 12, height: 12)
            .padding(8)
            .background(isConnected ? Color.green : Color.red)
            .clipShape(Circle())
            .shadow(radius: 2)
    }
}

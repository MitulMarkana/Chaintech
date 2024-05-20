//
//  ContentView.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var accounts: [AccountData] = []
    @State private var isAuthenticated = false
    
    var body: some View {
        NavigationView {
            if isAuthenticated {
                PasswordListView(accounts: $accounts)
                    .navigationBarHidden(true)
                    .onAppear{
                        fetchAccountsFromCoreData()
                    }
            } else {
                AuthenticationView(isAuthenticated: $isAuthenticated)
            }
        }
    }
    
    // MARK: - Private Methods
    private func fetchAccountsFromCoreData() {
        let accountDataFromCoreData = AccountManager.shared.getAccountData()
        accounts = accountDataFromCoreData
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

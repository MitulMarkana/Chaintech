//
//  AuthenticationView.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @Binding var isAuthenticated: Bool
    @State private var isBiometricAuthenticationAvailable = false
    
    var body: some View {
        VStack {
            if isBiometricAuthenticationAvailable {
                Button("Authenticate with Biometric") {
                    authenticateWithBiometric()
                }
            } else {
                PINEntryView(isAuthenticated: $isAuthenticated)
            }
        }
        .onAppear {
            checkBiometricAuthentication()
        }
    }
    
    func checkBiometricAuthentication() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            isBiometricAuthenticationAvailable = true
        } else {
            isBiometricAuthenticationAvailable = false
        }
    }
    
    func authenticateWithBiometric() {
        let context = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access your password manager") { success, error in
            DispatchQueue.main.async {
                if success {
                    isAuthenticated = true
                } else {
                    isAuthenticated = false
                }
            }
        }
    }
}

//
//  PINEntryView.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import SwiftUI
import Combine

struct PINEntryView: View {
    @State private var isWrongPin: Bool = false
    @Binding var isAuthenticated: Bool
    @State private var pin: String = ""
    @State private var isAlert: Bool = false
    
    let correctPIN = "1234" 
    let pinLength = 4
    
    var body: some View {
        VStack {
            Text("Enter your PIN")
                .font(.title)
                .padding()
            
            HStack(spacing: 10) {
                ForEach(0..<pinLength, id: \.self) { index in
                    PinDigitView(digit: pin.count > index ? String(pin[pin.index(pin.startIndex, offsetBy: index)]) : "")
                }
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 20) {
                ForEach(1..<4) { row in
                    HStack(spacing: 20) {
                        ForEach(1..<4) { column in
                            PinButtonView(value: row * 3 + column - 3, onTap: { self.enterDigit(row * 3 + column - 3) })
                        }
                    }
                }
                
                HStack(spacing: 20) {
                    Spacer()
                    PinButtonView(value: 0, onTap: { self.enterDigit(0) })
                    Spacer()
                }
            }
            .padding(.bottom, 20)
            Button(action: {
                if !pin.isEmpty {
                    pin.removeLast()
                }
            }) {
                Image(systemName: "delete.left")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 26)
            }
            .disabled(pin.isEmpty)
            .offset(x: 105, y: -75)
        }
        .alert(isPresented: $isAlert) {
            Alert(title: Text("Incorrect Password"), message: Text("Hint: Enter 1234"), dismissButton: .default(Text("OK")))
        }
    }
    
    func enterDigit(_ digit: Int) {
        if pin.count < pinLength {
            pin.append(String(digit))
            
            if pin.count == pinLength {
                if pin == correctPIN {
                    isWrongPin = false
                    print("Correct PIN entered")
                    isAuthenticated = true
                } else {
                    isWrongPin = true
                    isAlert = true
                    print("Incorrect PIN entered")
                   
                }
            }
        }
    }
}

struct PinDigitView: View {
    var digit: String
    
    var body: some View {
        Circle()
            .stroke(Color.blue, lineWidth: 2)
            .frame(width: 40, height: 40)
            .overlay(
                Text(digit)
                    .font(.headline)
                    .foregroundColor(.blue)
            )
    }
}

struct PinButtonView: View {
    var value: Int
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            self.onTap()
        }) {
            Text("\(value)")
                .font(.title)
                .frame(width: 70, height: 70)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(35)
        }
    }
}

//
//  AddPasswordView.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import SwiftUI

struct AddPasswordView: View {
    
    @State private var accountName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isAlert: Bool = false
    @Binding var accounts: [AccountData]
    @Binding var isPresentingAddPasswordView: Bool
    
    var onButtonClick: () -> Void
    
    var body: some View {
        ZStack{
            VStack{
                Color(#colorLiteral(red: 0.02906898223, green: 0.1053005382, blue: 0.1235411242, alpha: 0.4559877997))
                    .onTapGesture {
                        isPresentingAddPasswordView = false
                    }
                ZStack {
                    RoundedRectangle(cornerRadius: 17)
                        .foregroundColor(Color(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)))
                        .frame(width: UIScreen.main.bounds.width, height: 370)
                    VStack{
                        
                        RoundedRectangle(cornerRadius: 1)
                            .frame(width: 40, height: 3)
                            .foregroundColor(Color(#colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)))
                            .offset(y: -25)
                        
                        TextField("Account Name", text: $accountName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300,height: 50)
                            .padding(.bottom, 20)
                        TextField("Username/ Email", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300,height: 50)
                            .padding(.bottom, 20)
                        TextField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300,height: 50)
                            .padding(.bottom, 30)
                            .onTapGesture {
                               password = AutoPasswordManager.shared.generateRandomPassword(length: 12)
                            }
                        Button(action: {
                            if accountName.isEmpty || password.isEmpty || username.isEmpty{
                                isAlert = true
                                return
                            }
                            let newAccount = AccountData(accountName: accountName, username: username, password: password)
                            AccountManager.shared.addAccount(accountData: newAccount)
                            accountName = ""
                            username = ""
                            password = ""
                            onButtonClick()
                            isPresentingAddPasswordView = false
                            
                        }) {
                            Text("Add New Account")
                                .font(Font.custom("SF Pro Display", size: 18).weight(.bold))                            .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 22)
                                        .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                        .frame(width: 300, height: 44)
                                    
                                )
                        }
                        .padding(.bottom, 20)
                    }
                    
                }
                .padding(.bottom, 30)
                .padding([.leading,.trailing], 24)
                .frame(height: 333)
                .background(Color(#colorLiteral(red: 0.9529411765, green: 0.9607843137, blue: 0.9803921569, alpha: 1)))
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
            .navigationTitle("Add Password")
        }
        .alert(isPresented: $isAlert) {
            Alert(title: Text(""), message: Text("Please fill all the details"), dismissButton: .default(Text("OK")))
        }
    }

}

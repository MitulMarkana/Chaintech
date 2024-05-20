//
//  PasswordListView.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import SwiftUI

struct PasswordListView: View {
    @Binding var accounts: [AccountData]
    @State private var isPresentingPasswordDetailView = false
    @State private var selectedAccount: AccountData?
    @State private var isPresentingAddPasswordView = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9529411765, green: 0.9607843137, blue: 0.9803921569, alpha: 1))
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Password Manager")
                        .font(.custom("SF Pro Display", size: 21))
                        .fontWeight(.semibold)
                        .lineSpacing(21.48)
                        .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                    Spacer()
                }
                
                .padding([.leading, .top ,.trailing], 16)
                .padding(.bottom, 8)
                
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)))
                    .frame(width: UIScreen.main.bounds.width + 2,height: 0.7)
                
                ScrollView {
                    LazyVStack {
                        ForEach(accounts.indices, id: \.self) { index in
                            Button(action: {
                                isPresentingPasswordDetailView = true
                                selectedAccount = accounts[index]
                            }) {
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(.white)
                                    .overlay(
                                        HStack{
                                            Text(accounts[index].accountName)
                                                .font(Font.custom("SF Pro Display", size: 20).weight(.semibold))
                                                .padding(.trailing, 6)
                                            Text(String(repeating: "*", count: accounts[index].accountName.count))
                                                .font(Font.custom("SF Pro Display", size: 32).weight(.semibold))
                                                .foregroundColor(Color(#colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)))
                                                .padding(.top, 16)
                                            Spacer()
                                            Image("ic_vector")
                                        }
                                        .padding([.leading,.trailing], 26)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color(#colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)), lineWidth: 1)
                                    )
                                    .frame(width: 345, height: 66.19)
                            }
                            .padding(.horizontal)
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.black)
                            .padding(.vertical, 4)
                        }
                    }
                }.overlay(
                    Button(action: {
                        isPresentingPasswordDetailView = false
                        isPresentingAddPasswordView.toggle()
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.white)
                                    .frame(width: 26, height: 26)
                            )
                            .shadow(color: .gray, radius: 10, x: 0, y: 1)
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
                    .offset(x: 140, y: 300)
                )
                
                
                
                
            }
            if isPresentingAddPasswordView{
                AddPasswordView(accounts: $accounts, isPresentingAddPasswordView: $isPresentingAddPasswordView, onButtonClick: fetchAccountsFromCoreData)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            }
            if isPresentingPasswordDetailView{
                PasswordDetailView(account: selectedAccount ?? AccountData(accountName: "", username: "", password: ""), isPresentingPasswordDetailView: $isPresentingPasswordDetailView, strPass: selectedAccount?.password ?? "", isSecureEntry: false, onButtonClick: fetchAccountsFromCoreData)
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Private Methods
    private func fetchAccountsFromCoreData() {
        let accountDataFromCoreData = AccountManager.shared.getAccountData()
        accounts = accountDataFromCoreData
    }
}

//
//  PasswordDetailView.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import SwiftUI

struct PasswordDetailView: View {
    let account: AccountData
    @Binding var isPresentingPasswordDetailView: Bool
    @State private var isPresentingEditPassword: Bool = false
    @State var strPass: String
    @State var isSecureEntry: Bool
    var onButtonClick: () -> Void

    var body: some View {
        ZStack{
            VStack{
                Color(#colorLiteral(red: 0.02906898223, green: 0.1053005382, blue: 0.1235411242, alpha: 0.4559877997))
                    .onTapGesture {
                        isPresentingPasswordDetailView = false
                    }
                ZStack{
                    RoundedRectangle(cornerRadius: 17)
                        .foregroundColor(Color(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)))
                        .frame(width: UIScreen.main.bounds.width, height: 390)
                    VStack {
                    RoundedRectangle(cornerRadius: 1)
                        .frame(width: 40, height: 3)
                        .foregroundColor(Color(#colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)))
                        .offset(y: -16)
                    VStack(alignment: .leading){
                        Text("Account Details")
                            .foregroundColor(Color(#colorLiteral(red: 0.2470588235, green: 0.4901960784, blue: 0.8901960784, alpha: 1)))
                            .font(.system(size: 19, weight: .bold))
                            .padding(.bottom, 20)
                        Text("Account Type")
                            .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)))
                            .font(Font.custom("SF Pro Display", size: 12).weight(.bold))
                            .padding(.bottom, 1)
                        Text(account.accountName)
                            .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                            .font(.system(size: 16, weight: .bold))
                            .padding(.bottom, 20)
                        Text("Username")
                            .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)))
                            .font(Font.custom("SF Pro Display", size: 12).weight(.bold))
                            .padding(.bottom, 1)
                        Text(account.username)
                            .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                            .font(.system(size: 16, weight: .bold))
                            .padding(.bottom, 20)
                        HStack {
                            VStack(alignment: .leading){
                                Text("Password")
                                    .foregroundColor(Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)))
                                    .font(Font.custom("SF Pro Display", size: 12).weight(.bold))
                                    .padding(.bottom, 1)
                                if !isSecureEntry{ SecureField(account.password, text: $strPass)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                    .font(.system(size: 16, weight: .bold))
                                    .padding(.bottom, 20)
                                }else{
                                    Text(account.password)
                                        .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                        .font(.system(size: 16, weight: .bold))
                                        .padding(.bottom, 20)
                                }
                            }
                            Spacer()
                            Button(action: {
                                isSecureEntry.toggle()
                            }) {
                                Image("ic_eye")
                                    .foregroundColor(.gray)
                                    .frame(width: 30, height: 30)
                                    .shadow(color: .gray, radius: 10, x: 0, y: 1)
                            }
                            
                        }
                        HStack{
                            Button(action: {
                                isPresentingEditPassword = true
                            
                            }) {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)))
                                    .frame(width: 140, height: 40)
                                    .overlay(
                                        Text("Edit")
                                            .foregroundColor(Color.white)
                                    )
                                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 10, x: 0, y: 1)
                            }
                            Spacer()
                            Button(action: {
                                print("Delete pressed")
                                AccountManager.shared.deleteAccount(accountData: account)
                                onButtonClick()
                                isPresentingPasswordDetailView = false
                            }) {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9411764706, green: 0.2745098039, blue: 0.2745098039, alpha: 1)))
                                    .frame(width: 140, height: 40)
                                    .overlay(
                                        Text("Delete")
                                            .foregroundColor(Color.white)
                                    )
                                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 10, x: 0, y: 1)
                            }
                            
                        }
                        .padding(.bottom, 14)
                    }
                }
                    .padding(.bottom, 20)
                    .padding([.leading,.trailing], 24)
                    .frame(width: UIScreen.main.bounds.width ,height: 350, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)))
                }
                .padding(.bottom, 30)
                .padding([.leading,.trailing], 24)
                .frame(height: 333)
                .background(Color(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)))
                .ignoresSafeArea()
            }
            if isPresentingEditPassword{
                EditPasswordView(isPresentingEditPassword: $isPresentingEditPassword, account: account, onEditDone: onEditDoneAction)
            }
        }
        .navigationBarTitle("Password Detail")
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    // MARK: - Private Methods
    func onEditDoneAction(){
        onButtonClick()
        isPresentingPasswordDetailView = false
    }
}

//
//  EditPasswordView.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import SwiftUI

struct EditPasswordView: View {
    
    
    @Binding var isPresentingEditPassword: Bool
    let account: AccountData
    var onEditDone: () -> Void
    @State private var newPassword = ""
    @State private var newUserName = ""
    @State private var newAccountName = ""
    @State private var isAlert: Bool = false
    
    init(isPresentingEditPassword: Binding<Bool>, account: AccountData, onEditDone: @escaping () -> Void) {
        self._isPresentingEditPassword = isPresentingEditPassword
        self.account = account
        self.onEditDone = onEditDone
        self._newAccountName = State(initialValue: account.accountName)
        self._newUserName = State(wrappedValue: account.username)
        self._newPassword = State(initialValue: "")
    }
       
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.02906898223, green: 0.1053005382, blue: 0.1235411242, alpha: 0.7813035103))
                .onTapGesture {
                    isPresentingEditPassword = false
                }
            VStack{
                TextField("Enter new account name", text: $newAccountName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter new user name", text: $newUserName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack{
                    Text("New Password*")
                    Spacer()
                }.padding([.leading, .top, .trailing], 20)
                TextField("Enter new password for \(account.accountName)", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onTapGesture {
                       newPassword = AutoPasswordManager.shared.generateRandomPassword(length: 12)
                    }
                HStack{
                    Button(action: {
                        //                        onEditDone()
                        isPresentingEditPassword = false
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(#colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)))
                            .frame(width: 120, height: 40)
                            .overlay(
                                Text("Cancel")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                            )
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 10, x: 0, y: 1)
                    }
                    Spacer()
                    Button(action: {
                        if newPassword.isEmpty || newUserName.isEmpty || newAccountName.isEmpty{
                            isAlert = true
                            return
                        }
                        AccountManager.shared.updatePassword(account: account, newPassword: newPassword, accounName: newAccountName, username: newUserName)
                        onEditDone()
                        isPresentingEditPassword = false
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(#colorLiteral(red: 0.2470588235, green: 0.4901960784, blue: 0.8901960784, alpha: 1)))
                            .frame(width: 120, height: 40)
                            .overlay(
                                Text("Save")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                            )
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 10, x: 0, y: 1)
                    }
                }.padding()
            }
            .background(Color(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)))
            .cornerRadius(10)
            .frame(width: 300)
            .padding()
            
        }
        .alert(isPresented: $isAlert) {
        Alert(title: Text(""), message: Text("Please fill all the details"), dismissButton: .default(Text("OK")))
        }
    }
}

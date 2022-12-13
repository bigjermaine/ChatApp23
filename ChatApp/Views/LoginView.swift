//
//  LoginView.swift
//  ChatApp
//
//  Created by Apple on 25/09/2022.
//

import SwiftUI
import AudioToolbox
import FirebaseAuth
struct LoginView: View {
    @State var email  = ""
    @State var password  = ""
    @State var   editingEmailTextfield:Bool = false
    @State var  editingPasswordTextfield:Bool = false
    private let generator =
    UISelectionFeedbackGenerator()
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    @State private var showProfileView: Bool = false
    @State private var signupToggle: Bool = true
    @State private var rotationAngle = 0.0
    @State private var showAlertView: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue,.white,.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing:20){
                VStack(alignment:.leading,spacing: 16){
                    Text(signupToggle ?  "Sign in": "Sign up")
                        .font(.largeTitle)
                    HStack{
                        Image(systemName: "mail")
                            .foregroundColor(.blue)
                        TextField("email", text: $email)
                            .scaleEffect(emailIconBounce ? 1.2 : 1.0)
                        
                        
                    }
                    
                    
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                    .onTapGesture {
                        editingPasswordTextfield = false
                        editingEmailTextfield = true
                        if editingPasswordTextfield {
                            generator.selectionChanged()
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                passwordIconBounce.toggle()
                            }
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5).delay(0.15)) {
                                passwordIconBounce.toggle()
                            }
                        }
                    }
                    HStack  {
                        Image(systemName: "key.viewfinder")
                            .foregroundColor(.red)
                        TextField("password", text: $password)
                            .scaleEffect(passwordIconBounce ? 1.2 : 1.0)
                        
                        
                    }
                    
                    .autocapitalization(.none)
                    .textContentType(.password)
                    .onTapGesture {
                        editingPasswordTextfield = true
                        editingEmailTextfield = false
                        if editingPasswordTextfield {
                            generator.selectionChanged()
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                passwordIconBounce.toggle()
                            }
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5).delay(0.15)) {
                                passwordIconBounce.toggle()
                            }
                        }
                        
                        
                        
                    }
                }
                .frame(alignment: .leading)
                .padding(.leading,10)
                
                Button {
                    generator.selectionChanged()
                    signup()
                }
            label:{
                Text(signupToggle ?  "Sign in": "CreateAccount")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .padding(8)
                
                    .overlay (
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(LinearGradient(colors: [.blue,.red,.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        
                        
                    )
                
                
            }
                
            .frame(alignment:.center)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        showProfileView.toggle()
                    }
                }
            }
                
                VStack(alignment: .leading,spacing: 10){
                    Button {
                        withAnimation(.easeInOut(duration: 0.7)){
                            signupToggle.toggle()
                            self.rotationAngle += 180
                        }
                    }
                label:{
                    
                    Text(signupToggle ? "create account?...." : "if you have an account signin.....?")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .padding(.leading,8)
                    
                    
                    
                }
                    if signupToggle {
                        Button{
                            forgotpassword()
                        }label:{
                            Text("forgotpassword....")
                                .font(.footnote)
                                .foregroundColor(.black)
                                .opacity(0.5)
                                .padding(.leading,8)
                        }
                        
                    }
                }
                .frame(maxWidth:.infinity,alignment:.leading)
                .padding(.leading,10)
                
            }
            .background(.ultraThinMaterial)
            .overlay (
                RoundedRectangle(cornerRadius: 25)
                    .stroke(LinearGradient(colors: [.blue,.red,.red], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                
                
            )
            .mask(
                LinearGradient(colors: [.blue,.red,.red], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            .background(.gray.opacity(0.1))
            
            
            .cornerRadius(25)
            .padding()
            .shadow(radius: 5)
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
        }
        .fullScreenCover(isPresented: $showProfileView) {
            ContentView()
        }
        .alert(isPresented: $showAlertView) {
            Alert(title: Text(alertTitle),message:Text (alertMessage), dismissButton: .cancel()).
            Angle(degrees: self.rotationAngle),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        
    }
    func signup() {
        if !signupToggle {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    self.alertTitle = "Uh-oh!"
                    self.alertMessage = (error!.localizedDescription)
                    self.showAlertView.toggle()
                    return
                    
                }
                print("User signed up!")
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    alertTitle = "Uh-oh!"
                    alertMessage = (error!.localizedDescription)
                    showAlertView.toggle()
                    return
                }
                print("User is signed in")
            }
        }
    }
//    func Singout() {
//
//        Auth.auth.signput()
//
//    }
    func forgotpassword() {
        
        Auth.auth().sendPasswordReset(withEmail:email) { error in
        guard error == nil else {
            alertTitle = "Uh-oh!"
            alertMessage = (error!.localizedDescription)
            showAlertView.toggle()
            return
        }
        alertTitle = "passwordsent"
        alertMessage =  "check your email box"
        showAlertView.toggle()
    }
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

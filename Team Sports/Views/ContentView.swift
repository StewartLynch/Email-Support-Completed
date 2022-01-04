//
//  ContentView.swift
//  Team Sports
//
//  Created by Stewart Lynch on 2022-01-03.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    @State private var askForAttachment = false
    @State private var showEmail = false
    @State private var email = SupportEmail(toAddress: "slynch@createchsol.com",
                                     subject: "Support Email",
                                     messageHeader: "Please describe your issue below")
    var body: some View {
        NavigationView {
            List(ExampleData.examples) { example in
                HStack {
                    Text(example.image)
                        .font(.largeTitle)
                    Text(example.name)
                }
            }
            .navigationTitle("Team Sports")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        askForAttachment.toggle()
                    } label: {
                        HStack {
                            Text("Email Support")
                            Image(systemName: "envelope.circle.fill")
                                .font(.title2)
                        }
                    }
                }
            }
            .sheet(isPresented: $showEmail) {
                MailView(supportEmail: $email) { result in
                    switch result {
                    case .success:
                        print("Email sent")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            .confirmationDialog("", isPresented: $askForAttachment) {
                Button("Yes") {
                    email.data = ExampleData.data
                    if email.data == nil {
                        email.send(openURL: openURL)
                    } else {
                        if MailView.canSendMail {
                            showEmail.toggle()
                        } else {
                            print("""
                            This device does not support email
                            \(email.body)
                            """
                            )
                        }
                    }
                }
                Button("No") {
                    email.send(openURL: openURL)
                }
            } message: {
                Text("""
                SUPPORT EMAIL
                Include data as an attachment?
                """)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

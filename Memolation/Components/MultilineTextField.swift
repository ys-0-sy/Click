//
//  MultilineTextField.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import Combine

struct MultilineTextFieldView: View {
  @ObservedObject private var myData = UserData()
    var body: some View {
      VStack {
          MultilineTextField(text: $myData.text)
             .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
             .overlay(
                 RoundedRectangle(cornerRadius: 10)
                     .stroke(Color.blue, lineWidth: 5)
             )
          Text("↓")
              .font(.title)
          Text(myData.text)
              .lineLimit(nil)
              .frame(width: UIScreen.main.bounds.width * 0.8, height: 200, alignment: .topLeading)
              .overlay(
                  RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.green, lineWidth: 5)
              )

      }.onTapGesture {
          self.endEditing()
      }
    }
  private func endEditing() {
      UIApplication.shared.endEditing()
  }
}

final class UserData: ObservableObject {
    @Published var text: String = ""
}

struct MultilineTextField: UIViewRepresentable {

  @Binding var text: String
  func makeUIView(context: Context) -> UITextView {
    let view = UITextView()
    view.delegate = context.coordinator
    view.isScrollEnabled = true
    view.isEditable = true
    view.isUserInteractionEnabled = true
    return view
  }
  
  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UITextViewDelegate {
    var parent: MultilineTextField
    
    init(_ textView: MultilineTextField) {
      self.parent = textView
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
      self.parent.text = textView.text
    }
  }
}

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

struct MultilineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextFieldView()
    }
}

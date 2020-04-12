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
  let width: CGFloat = 200
  let height: CGFloat = 200
  let alignment: Alignment = .top
  let boarderColor: Color = Color("BaseColor")
  var body: some View {
        MultilineTextField(text: $myData.rawText, onEditingChanged: update)
          .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
          .lineLimit(nil)
          .padding(.all)
          .frame(width: width, height: height, alignment: alignment)
          .background(Color.white)
          .overlay(
              RoundedRectangle(cornerRadius: 6)
                  .stroke(boarderColor, lineWidth: 4)
          ) 
          .background(Color.white)
    
  }
  
  func update(changed: Bool) {
      guard !changed else { return }
      //document.content = content
      //document.updateChangeCount(.done)
  }
}




struct MultilineTextField: UIViewRepresentable {

  @Binding var text: String
  let onEditingChanged: (Bool) -> Void
  
  init(text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = {_ in}) {
    self._text = text
    self.onEditingChanged = onEditingChanged
  }
  
  func makeCoordinator() -> MultilineTextFieldCoordinator {
    MultilineTextFieldCoordinator(target: self, onEditingChanged: onEditingChanged)
  }
  
  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.delegate = context.coordinator
    textView.isScrollEnabled = true
    textView.text = text
    return textView
  }

  func updateUIView(_ textView: UITextView, context: Context) {
    if textView.text != text {
      textView.text = text
    }
  }
}
class MultilineTextFieldCoordinator: NSObject, UITextViewDelegate {
  let target: MultilineTextField
  let onEditingChanged: (Bool) -> Void

  init(target: MultilineTextField, onEditingChanged: @escaping (Bool) -> Void = {_ in}) {
    self.target = target
    self.onEditingChanged = onEditingChanged
  }

  func textViewDidChange(_ textView: UITextView) {
    target.text = textView.text
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    onEditingChanged(true)
  }
  func textViewDidEndEditing(_ textView: UITextView) {
    onEditingChanged(false)
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

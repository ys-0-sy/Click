//
//  MultilineTextField.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct MultilineTextFieldView: View {
  @State private var rawText: String = "Sample Text"
  let width: CGFloat = 200
  let height: CGFloat = 200
  let alignment: Alignment = .top
  let boarderColor: Color = Color("BaseColor")
  var body: some View {
    MultilineTextField("Type Here", text: $rawText, onCommit: {
      print(self.rawText)
    })
    .lineLimit(nil)
    .padding(.all)
    .frame(width: width, height: height, alignment: alignment)
    .cornerRadius(6)
    .background(Color(UIColor.systemGray))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(boarderColor, lineWidth: 2)
        )
    
  }
}

struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?
    @State private var viewHeight: CGFloat = 40 //start with one line
    @State private var shouldShowPlaceholder = false
    @Binding private var text: String
    
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.shouldShowPlaceholder = $0.isEmpty
        }
    }

    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $viewHeight, onDone: onCommit)
            .background(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View {
        Group {
            if shouldShowPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
    
    init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self._shouldShowPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }

}


private struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = true
        textField.backgroundColor = UIColor.clear
        textField.textContainer.lineFragmentPadding = 0
        textField.textContainerInset = .zero
        textField.font = UIFont.systemFont(ofSize: 17)
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text

        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
              UIApplication.shared.endEditing()
                onDone()
                return false
            }
            return true
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
      .previewLayout(.sizeThatFits)
    }
}

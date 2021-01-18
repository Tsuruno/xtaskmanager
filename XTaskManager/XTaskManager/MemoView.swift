//
//  MemoView.swift
//  XTaskManager
//
//  Created by Administrator on 2020/09/04.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import SwiftUI

struct MultilineField: UIViewRepresentable {
    @Binding var text: String
    
    let onEditingChanged: (Bool) -> Void
    
    init(text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = {_ in}) {
        self._text = text
        self.onEditingChanged = onEditingChanged
    }
    
    func makeCoordinator() -> MultilineFieldCoordinator {
        MultilineFieldCoordinator(target: self, onEditingChanged: onEditingChanged)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text != text {
            textView.text = text
        }
    }
}

class MultilineFieldCoordinator : NSObject, UITextViewDelegate {
    let target: MultilineField
    let onEditingChanged: (Bool) -> Void
    
    init(target: MultilineField, onEditingChanged: @escaping (Bool) -> Void = {_ in}) {
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

struct MemoView: View {
    @State var content = "MEMO:"
    
    var body: some View {
        MultilineField(text: $content, onEditingChanged: update)
    }
    
    func update(changed: Bool) {
        guard !changed else { return }
    }
}


struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}


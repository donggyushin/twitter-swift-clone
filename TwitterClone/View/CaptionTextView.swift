//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import UIKit

class CaptionTextView: UITextView {
    
    private lazy var placeholder:UILabel = {
        let label = UILabel()
        label.text = "여기에 적어주세요"
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        delegate = self
        
        font = UIFont.systemFont(ofSize: 16)
        
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        addSubview(placeholder)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        placeholder.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CaptionTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.placeholder.isHidden = !textView.text.isEmpty
    }
}

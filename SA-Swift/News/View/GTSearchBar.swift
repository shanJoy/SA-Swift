//
//  GTSearchBar.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/14.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit
import Foundation

class GTSearchBar: UIView, UITextFieldDelegate {

    private var textField : UITextField
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        textField = UITextField.init(frame: CGRect(x: UI(value: 10), y: UI(value: 7), width: frame.size.width - UI(value: 10) * 2, height: frame.size.height - UI(value: 7) * 2))
        super.init(frame: frame)
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        textField.leftView = UIImageView.init(image: UIImage.init(named: "search"))
        textField.leftViewMode = UITextField.ViewMode.unlessEditing
        textField.clearButtonMode = UITextField.ViewMode.always
        textField.placeholder = "今日热点推荐"
        self.addSubview(textField)
    }
    
    @available(iOS 2.0, *)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //字数判断
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

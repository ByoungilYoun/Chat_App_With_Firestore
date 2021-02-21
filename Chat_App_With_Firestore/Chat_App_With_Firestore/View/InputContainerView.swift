//
//  InputContainerView.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/22.
//

import UIKit

class InputContainerView : UIView {
  
  init(image : UIImage , textField : UITextField) {
    super.init(frame: .zero)
    
    setHeight(height: 50)
    
    let iv = UIImageView()
    iv.image = image
    iv.tintColor = .white
    iv.alpha = 0.87
    
    addSubview(iv)
    iv.centerY(inView: self)
    iv.anchor(left : leftAnchor, paddingLeft: 8)
    iv.setDimensions(height: 24, width: 28)
    
    addSubview(textField)
    textField.centerY(inView: self)
    textField.anchor(left : iv.rightAnchor, right: rightAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -8)
    
    let dividerView = UIView()
    dividerView.backgroundColor = .white
    addSubview(dividerView)
    dividerView.anchor(left : leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingLeft: 8, height: 0.75)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

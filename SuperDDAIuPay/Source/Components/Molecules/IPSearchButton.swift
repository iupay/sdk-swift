//
//  IPSearchButton.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 08/10/2020.
//

import UIKit

/**
Button with magnifying glass Icon

 ### Usage: ###
```
let searchButton = IPSearchButton(frame: .zero)
```
 ### Notes: ###
 1.  It can be inherited on .xibs/.storyboards
 */
public class IPSearchButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        let image = UIImage.bundleImage(named: "search")
        self.setImage(image?.resize(toWidth: .preLargeMargin)?.tint(with: .darkGray), for: .normal)
        self.setTitle(nil, for: .normal)
        self.setTitle(nil, for: .disabled)
    }
}

//
//  IPFilterView.swift
//  SuperDDAIuPay
//
//  Created by Luciano Bohrer on 07/10/2020.
//

import UIKit

public class IPFilterView: UIView {
    
    public enum Sort {
        case asc
        case dsc
    }
    
    public var handleFilter: ((Sort) -> ())?
    public var handleSearch: (() -> ())?

    private lazy var captionLabel: UILabel = {
        $0.text = "Ordenar por:"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.customFont(ofSize: 14, weight: .regular)
        $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
        $0.heightAnchor.constraint(equalToConstant: .largeMargin).isActive = true
        return $0
    }(UILabel(frame: .zero))
    
    private lazy var ascButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = UIFont.customFont(ofSize: 14, weight: .regular)
        $0.setTitle("A-Z |", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.addTarget(self, action: #selector(self.filterAction(sender:)), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    private lazy var dscButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = UIFont.customFont(ofSize: 14, weight: .regular)
        $0.setTitle("Z-A |", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.addTarget(self, action: #selector(self.filterAction(sender:)), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    private lazy var searchButton: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage.bundleImage(named: "search")?.tint(with: .darkGray)
        $0.widthAnchor.constraint(equalToConstant: .mediumMargin).isActive = true
        $0.contentMode = .scaleAspectFit
        $0.heightAnchor.constraint(equalToConstant: .largeMargin).isActive = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.searchAction)))
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView(frame: .zero))
    
    init(caption: String) {
        super.init(frame: .zero)
        self.captionLabel.text = caption
        self.setupContent()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupContent()
    }
    
    private func setupContent() {
        self.addSubview(self.captionLabel)
        self.addSubview(self.ascButton)
        self.addSubview(self.dscButton)
        self.addSubview(self.searchButton)
        
        self.captionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.captionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.ascButton.leadingAnchor.constraint(equalTo: self.captionLabel.trailingAnchor, constant: 4).isActive = true
        self.ascButton.centerYAnchor.constraint(equalTo: self.captionLabel.centerYAnchor).isActive = true
        
        self.dscButton.leadingAnchor.constraint(equalTo: self.ascButton.trailingAnchor, constant: 4).isActive = true
        self.dscButton.centerYAnchor.constraint(equalTo: self.ascButton.centerYAnchor).isActive = true
        
        self.searchButton.leadingAnchor.constraint(equalTo: self.dscButton.trailingAnchor, constant: 4).isActive = true
        self.searchButton.centerYAnchor.constraint(equalTo: self.dscButton.centerYAnchor).isActive = true
    }
    
    @objc private func filterAction(sender: UIButton) {
        self.handleFilter?(sender == self.ascButton ? .asc : .dsc)
    }
    
    @objc private func searchAction() {
        self.handleSearch?()
    }
}

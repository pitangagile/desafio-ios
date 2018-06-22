//
//  RoundBorderView.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 22/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//
import UIKit

@IBDesignable
class RoundBorderView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.makeRound()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.setBorder()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            self.setBorder()
        }
    }
    
    override func layoutIfNeeded() {
        self.makeRound()
        self.setBorder()
    }
    
    private func makeRound() {
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = true
    }
    
    private func setBorder() {
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }
}

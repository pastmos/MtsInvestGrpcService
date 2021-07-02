//
//  MtsTestView.swift
//  MtsInvestGrpcService
//
//  Created by Sergey Panov on 02.07.2021.
//

import UIKit
import SnapKit

open class MtsTestView: UIView {
    
    public struct ViewData {
        let title: String
        let backgroundColor: UIColor
        
        public init(title: String, backgroundColor: UIColor) {
            self.title = title
            self.backgroundColor = backgroundColor
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.textAlignment = .center
        return label
    }()
    
    public required init(data: ViewData) {
        super.init(frame: .zero)
        setupView()
        configure(data: data)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func configure(data: ViewData) {
        titleLabel.text = data.title
        titleLabel.backgroundColor = data.backgroundColor
    }
    
    private func setupView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

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
        let color: UIColor
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.textAlignment = .center
        return label
    }()
    
    required public init(data: ViewData) {
        super.init(frame: .zero)
        setupView()
        configure(data: data)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configure(data: ViewData) {
        titleLabel.text = data.title
        titleLabel.textColor = data.color
    }
    
    private func setupView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

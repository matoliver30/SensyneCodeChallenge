//
//  HospitalListCustomCell.swift
//  tech-test
//
//  Created by Robert Majtan on 05/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import UIKit
import SnapKit

class HospitalListCustomCell: UITableViewCell {

    static let identifier = "HospitalListCustomCell"

    lazy var containerView = UIStackView()

    //containerView
    lazy var hospitalNameLabel = UILabel()
    lazy var hospitalType = UILabel()
    lazy var hospitalId = UILabel()
    lazy var hospitalPhone = UILabel()
    lazy var hospitalEmail = UILabel()
    lazy var hospitalAddress = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: HospitalListCustomCell.identifier)

        configureUI()
        setSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: HospitalModel) {

        hospitalNameLabel.text = model.organisationName

        if let type = model.organisationType {
            if !type.isEmpty {
                hospitalType.text = "Type: \(type)"
            }
        }

        if let id = model.organisationID {
            if !id.isEmpty {
                hospitalId.text = "ID: \(id)"
            }
        }

        if let phone = model.phone {
            if !phone.isEmpty {
                hospitalPhone.text = "Phone: \(phone)"
            }
        }

        if let email = model.email {
            if !email.isEmpty {
                hospitalPhone.text = "Email: \(email)"
            }
        }

        hospitalAddress.text = model.getFullAddress()
    }
}

extension HospitalListCustomCell {

    // MARK: - CONFIGURE UI
    func configureUI() {
        self.selectionStyle = .none

        containerView.alignment = .fill
        containerView.axis = .vertical
        containerView.distribution = .equalSpacing
        containerView.spacing = 2

        hospitalNameLabel.textColor = UIColor(red: 0.53, green: 0.31, blue: 0.89, alpha: 1.00)
        hospitalNameLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        hospitalNameLabel.numberOfLines = 0
        hospitalNameLabel.accessibilityIdentifier = "hospitalName"
        hospitalNameLabel.isAccessibilityElement = true

        hospitalType.numberOfLines = 0
        hospitalType.font = UIFont.systemFont(ofSize: 14, weight: .light)
        hospitalType.accessibilityIdentifier = "hospitalType"
        hospitalType.isAccessibilityElement = true

        hospitalId.numberOfLines = 0
        hospitalId.font = UIFont.systemFont(ofSize: 14, weight: .light)
        hospitalId.accessibilityIdentifier = "hospitalId"
        hospitalId.isAccessibilityElement = true

        hospitalPhone.numberOfLines = 0
        hospitalPhone.font = UIFont.systemFont(ofSize: 14, weight: .light)
        hospitalPhone.accessibilityIdentifier = "hospitalPhone"
        hospitalPhone.isAccessibilityElement = true

        hospitalEmail.numberOfLines = 0
        hospitalEmail.font = UIFont.systemFont(ofSize: 14, weight: .light)
        hospitalEmail.accessibilityIdentifier = "hospitalEmail"
        hospitalEmail.isAccessibilityElement = true

        hospitalAddress.numberOfLines = 0
        hospitalAddress.font = UIFont.systemFont(ofSize: 14, weight: .light)
        hospitalAddress.accessibilityIdentifier = "hospitalAddress"
        hospitalAddress.isAccessibilityElement = true
    }

    // MARK: - SETUP SUBVIEWS
    func setSubviews() {
        contentView.addSubview(containerView)

        containerView.addArrangedSubview(hospitalNameLabel)
        containerView.addArrangedSubview(hospitalType)
        containerView.addArrangedSubview(hospitalId)
        containerView.addArrangedSubview(hospitalPhone)
        containerView.addArrangedSubview(hospitalEmail)
        containerView.addArrangedSubview(hospitalAddress)
    }

    // MARK: - SETUP CONSTRAINTS
    func setConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}


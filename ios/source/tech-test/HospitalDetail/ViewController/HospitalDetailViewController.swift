//
//  HospitalDetailViewController.swift
//  tech-test
//
//  Created by Robert Majtan on 05/11/2020.
//  Copyright © 2020 com.ro8i.techtest. All rights reserved.
//

import UIKit
import MessageUI
import MapKit

class HospitalDetailViewController: UIViewController {

    var data: HospitalModel?

    @IBOutlet weak var name: UILabel! {
        didSet {
            name.text = data?.organisationName
        }
    }

    @IBOutlet weak var parentODSCode: UILabel! {
        didSet {
            if let text = data?.parentODSCode {
                parentODSCode.text = "ODS Code: \(text)"
            } else {
                parentODSCode.isHidden = true
            }
        }
    }

    @IBOutlet weak var id: UILabel! {
        didSet {
            if let text = data?.organisationID {
                id.text = "ID: \(text)"
            } else {
                id.isHidden = true
            }

        }
    }

    @IBOutlet weak var code: UILabel! {
        didSet {
            if let text = data?.organisationCode {
                code.text = "Code: \(text)"
            } else {
                code.isHidden = true
            }
        }
    }

    @IBOutlet weak var sector: UILabel! {
        didSet {
            if let text = data?.sector {
                sector.text = "Sector: \(text)"
            } else {
                sector.isHidden = true
            }

        }
    }

    @IBOutlet weak var type: UILabel! {
        didSet {
            if let text = data?.organisationType {
                type.text = "Type: \(text)"
            } else {
                type.isHidden = true
            }
        }
    }

    @IBOutlet weak var subType: UILabel! {
        didSet {
            if let text = data?.subType {
                subType.text = "SubType: \(text)"
            } else {
                subType.isHidden = true
            }
        }
    }

    @IBOutlet weak var status: UILabel! {
        didSet {
            if let text = data?.organisationStatus {
                status.text = "Status: \(text)"
            } else {
                status.isHidden = true
            }
        }
    }

    @IBOutlet weak var pim: UILabel! {
        didSet {
            if let text = data?.isPimsManaged {
                pim.text = "PIM: \(text)"
            }
        }
    }

    @IBOutlet weak var fax: UILabel! {
        didSet {
            if let text = data?.fax {
                fax.text = "Fax: \(text)"
            } else {
                fax.isHidden = true
            }
        }
    }

    @IBOutlet weak var address: UILabel! {
        didSet {
            if let text = data?.getFullAddress() {
                address.text = text
            } else {
                address.isHidden = true
            }
        }
    }

    @IBOutlet weak var email: UILabel! {
        didSet {
            if (data?.email ?? "").isEmpty {
                email.isHidden = true
            } else {
                if let text = data?.email {
                    email.text = "✉️ \(text)"
                    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(emailTapped))
                    email.isUserInteractionEnabled = true
                    email.addGestureRecognizer(tap)
                }
            }
        }
    }

    @IBOutlet weak var phone: UILabel! {
        didSet {
            if (data?.phone ?? "").isEmpty {
                phone.isHidden = true
            } else {
                if let text = data?.phone {
                    phone.text = "☎️ \(text)"
                    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(phoneTapped))
                    phone.isUserInteractionEnabled = true
                    phone.addGestureRecognizer(tap)
                }
            }
        }
    }

    @IBOutlet weak var website: UILabel! {
        didSet {
            if (data?.website ?? "").isEmpty {
                website.isHidden = true
            } else {
                if let text = data?.website {
                    website.text = "🌐 \(text)"
                    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(webTapped))
                    website.isUserInteractionEnabled = true
                    website.addGestureRecognizer(tap)
                }
            }
        }
    }

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            if let lat = data?.latitude,
                let long = data?.longitude {
                if let annotation = self.mapAnnotation(name: data?.organisationName ?? "", lat: lat, long: long) {
                    mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegates()
    }
    
    //MARK: - ACTIONS
    @objc func phoneTapped() {
        guard let number = data?.phone else { return }
        let phoneNumber = number.replacingOccurrences(of: " ", with: "")
        guard let phoneCallURL = URL(string: "tel://\(phoneNumber)") else { return }

        if UIApplication.shared.canOpenURL(phoneCallURL) {
            UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        }

    }

    @objc func emailTapped() {
        let alert = UIAlertController(title: "Email", message: "Do you want to send email?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.sendEmail()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    @objc func webTapped() {
        guard let website = data?.website else { return }
        if let url = URL(string: website) {
            UIApplication.shared.open(url)
        }
    }

    //MARK: - HELPERS
    func mapAnnotation(name: String, lat: Double, long: Double) -> MKPointAnnotation? {
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2DMake(lat, long)
        return annotation
    }

    func sendEmail() {
        guard let email = data?.email else { return }
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            present(mail, animated: true)
        }
    }

    func openInAppleMaps(with coordinates: CLLocationCoordinate2D) {
        let query = "?ll=\(coordinates.latitude),\(coordinates.longitude)"
        let path = "http://maps.apple.com/" + query

        guard let url = URL(string: path), !url.absoluteString.isEmpty else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: MAIL COMPOSE DELEGATE
extension HospitalDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

// MARK: MAPVIEW DELEGATE
extension HospitalDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinates = view.annotation?.coordinate {
            openInAppleMaps(with: coordinates)
        }
    }
}

extension HospitalDetailViewController {
    // MARK: - CONFIGURE UI
    func configureUI() {
        view.accessibilityIdentifier = "Hospital Detail View"
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
        id.accessibilityIdentifier = "hospitalId"
        name.accessibilityIdentifier = "hospitalName"
        parentODSCode.accessibilityIdentifier = "hospitalODSCode"
        code.accessibilityIdentifier = "hospitalCode"
        sector.accessibilityIdentifier = "hospitalSector"
        type.accessibilityIdentifier = "hospitalType"
        subType.accessibilityIdentifier = "hospitalSubType"
        status.accessibilityIdentifier = "hospitalStatus"
        pim.accessibilityIdentifier = "hospitalPim"
        fax.accessibilityIdentifier = "hospitalFax"
        address.accessibilityIdentifier = "hospitalAddress"
        email.accessibilityIdentifier = "hospitalEmail"
        phone.accessibilityIdentifier = "hospitalPhone"
        website.accessibilityIdentifier = "hospitalWebsite"
        mapView.accessibilityIdentifier = "hospitalMap"
        
        mapView.isAccessibilityElement = true
    }

    // MARK: - SETUP DELEGATES
    func setDelegates() {
        self.mapView.delegate = self
    }
}

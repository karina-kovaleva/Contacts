//
//  DetailContactViewController.swift
//  Lesson 3
//
//  Created by Karina Kovaleva on 21.12.22.
//

import UIKit

class DetailContactViewController: UIViewController {

    private var contact: Contact
    
    private lazy var profileImageView: CircleImageView = {
        var imageView = CircleImageView()
        return imageView
    }()
    
    private lazy var stackViewForTextFields: UIStackView = {
        var stackViewForLabels = UIStackView()
        stackViewForLabels.axis = .vertical
        stackViewForLabels.distribution = .fillProportionally
        stackViewForLabels.alignment = .fill
        stackViewForLabels.spacing = 5
        [self.fullNameTextField, self.phoneNumberTextField].forEach { stackViewForLabels.addArrangedSubview($0) }
        return stackViewForLabels
    }()
    
    private lazy var fullNameTextField: UITextField = {
        var fullNameTextField = UITextField()
        fullNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        fullNameTextField.isUserInteractionEnabled = false
        return fullNameTextField
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        var phoneNumberTextField = UITextField()
        phoneNumberTextField.borderStyle = UITextField.BorderStyle.roundedRect
        phoneNumberTextField.isUserInteractionEnabled = false
        return phoneNumberTextField
    }()
    
    init(contact: Contact) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoForProfile()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(profileImageView)
        self.view.addSubview(stackViewForTextFields)
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        stackViewForTextFields.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            profileImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            stackViewForTextFields.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            stackViewForTextFields.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            stackViewForTextFields.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
    }
    
    private func getInfoForProfile() {
        let image = contact.imageData
        profileImageView.image = UIImage(data: image!)
        fullNameTextField.text = "\(contact.familyName) \(contact.givenName) "
        phoneNumberTextField.text = contact.phoneNumber
    }
    
    override func setEditing (_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            fullNameTextField.isUserInteractionEnabled = true
            phoneNumberTextField.isUserInteractionEnabled = true
            self.editButtonItem.title = "Save"
        } else {
            fullNameTextField.isUserInteractionEnabled = false
            phoneNumberTextField.isUserInteractionEnabled = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

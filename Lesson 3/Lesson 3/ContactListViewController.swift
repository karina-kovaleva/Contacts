//
//  ContactListViewController.swift
//  Lesson 3
//
//  Created by Karina Kovaleva on 19.12.22.
//

import Contacts
import UIKit

class ContactListViewController: UIViewController {

    private let contactStore = CNContactStore()
    
    var contacts = [Contact]() {
        didSet {
            contactsTableView.reloadData()
        }
    }
    
    private lazy var contactsTableView: UITableView = {
        var contactsTableView = UITableView()
        contactsTableView.register(ContactListTableViewCell.self, forCellReuseIdentifier: ContactListTableViewCell.identifier)
        return contactsTableView
    }()
    
    private lazy var buttonConfiguration: UIButton.Configuration = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.buttonSize = .large
        buttonConfiguration.title = "Download contacts"
        buttonConfiguration.imagePadding = 3
        buttonConfiguration.imagePlacement = .trailing
        buttonConfiguration.image = UIImage(systemName: "arrow.down.to.line.alt")
        return buttonConfiguration
    }()
    
    private lazy var accessСontactsButton: UIButton = {
        var configuration = buttonConfiguration
        var accessСontactsButton = UIButton(type: .custom)
        accessСontactsButton.configuration = configuration
        accessСontactsButton.addTarget(self, action: #selector(requestAccessToContacts), for: .touchUpInside)
        return accessСontactsButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupButton()
    }
    
    private func setupNavBar() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Contacts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        accessСontactsButton.removeFromSuperview()
        self.view.addSubview(contactsTableView)
        
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contactsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupButton() {
        self.view.addSubview(accessСontactsButton)
        accessСontactsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            accessСontactsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            accessСontactsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc func requestAccessToContacts() {
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
            
        case .authorized:
            fetchContacts()
            setupTableView()
        case .denied:
            showSettingsAlert()
        case .restricted, .notDetermined:
            contactStore.requestAccess(for: .contacts) { isAccessed, error in
                if isAccessed {
                    
                } else {
                    self.showSettingsAlert()
                }
            }
        }
    }
    
    private func fetchContacts() {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataAvailableKey, CNContactImageDataKey, CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
        let contactRequest = CNContactFetchRequest(keysToFetch: keys)
        do {
            try self.contactStore.enumerateContacts(with: contactRequest) { contact, stoppingPointer in
                let givenName = contact.givenName
                let familyName = contact.familyName
                guard let number = contact.phoneNumbers.first?.value.stringValue else { return }
                if contact.imageDataAvailable {
                    let thumbnailImage = contact.thumbnailImageData
                    let imageData = contact.imageData
                    let contact = Contact(givenName: givenName, familyName: familyName, phoneNumber: number, thumbnailImage: thumbnailImage, imageData: imageData)
                    self.contacts.append(contact)
                } else {
                    let imageData = UIImage(named: "person")?.pngData()
                    let contact = Contact(givenName: givenName, familyName: familyName, phoneNumber: number, thumbnailImage: imageData, imageData: imageData)
                    self.contacts.append(contact)
                }
            }
        } catch {
            print("error")
        }        
    }
    
    
    private func showSettingsAlert() {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access.", preferredStyle: .alert)
        if let settings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settings) {
                alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
                    UIApplication.shared.open(settings)
                })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

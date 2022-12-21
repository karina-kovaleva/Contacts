//
//  extension+ContactListViewController.swift
//  Lesson 3
//
//  Created by Karina Kovaleva on 20.12.22.
//

import UIKit

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTableViewCell.identifier) as? ContactListTableViewCell else { return ContactListTableViewCell() }
        cell.fullNameLabel.text = "\(contacts[indexPath.row].familyName) \(contacts[indexPath.row].givenName)"
        cell.phoneNumberLabel.text = contacts[indexPath.row].phoneNumber
        if contacts[indexPath.row].thumbnailImage != nil {
            let image = UIImage(data: contacts[indexPath.row].thumbnailImage!)
            cell.avatar.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = DetailContactViewController(contact: contacts[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}

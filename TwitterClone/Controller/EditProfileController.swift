//
//  EditProfileController.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 4.02.2023.
//

import UIKit

private let reuseIdentifier = "EditProfileCell"

class EditProfileController: UITableViewController {
    
    //MARK: - Properties
    
    private var user: User
    private lazy var headerView = EditProfileHeader(user: user)
    private let imagePicker = UIImagePickerController()
    
    private var selectedImage: UIImage? {
        didSet { headerView.profileImageView.image = selectedImage }
    }
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImagePicker()
        configureNavigationBar()
        configureTableView()
    }
    
    //MARK: - Selectors
    
    @objc func cancelPressed() {
        dismiss(animated: true)
    }
    
    @objc func donePressed() {
        dismiss(animated: true)
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        title = "Edit Profile"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func configureTableView() {
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        tableView.tableFooterView = UIView()
        
        headerView.delegate = self
        
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
}

//MARK: -

extension EditProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfileOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
        
        cell.delegate = self
        
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return cell }
        cell.viewModel = EditProfileViewModel(user: user, option: option)
        
        return cell
    }
}

//MARK: -

extension EditProfileController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0 }
        return option == .bio ? 100 : 48
    }
}

//MARK: -

extension EditProfileController: EditProfileHeaderDelegate {
    func changeProfilePhotoPressed() {
        print("DEBUG: changeProfilePhotoPressed")
        present(imagePicker, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate

extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("DEBUG: Update profile photo...")
        
        guard let image = info[.editedImage] as? UIImage else { return }
        self.selectedImage = image
        
        dismiss(animated: true)
    }
}

//MARK: - EditProfileCellDelegate

extension EditProfileController: EditProfileCellDelegate {
    func updateUserInfo(_ cell: EditProfileCell) {
        guard let viewModel = cell.viewModel else { return }
        
        switch viewModel.option {
        case .fullname:
            guard let fullname = cell.infoTextField.text else { return }
            user.fullname = fullname
        case .username:
            guard let username = cell.infoTextField.text else { return }
            user.username = username
        case .bio:
            user.bio = cell.bioTextView.text
        }
        
        print("DEBUG: Fullname is \(user.fullname)")
        print("DEBUG: Username is \(user.username)")
        print("DEBUG: Bio is \(user.bio)")
    }
}

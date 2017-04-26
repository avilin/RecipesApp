//
//  EditRecipeViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 25/4/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class EditRecipeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    // MARK: - Properties
    var editRecipePresenter: EditRecipePresenter!
    var keyboardHelper: KeyboardHelper?
    var imageSelected = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        editRecipePresenter.attachView(editRecipeView: self)
        editRecipePresenter.initView()

        keyboardHelper = KeyboardHelper()
        keyboardHelper?.configure(viewController: self)
    }

    // MARK: - IBActions
    @IBAction func selectImageButtonTouched(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self

            present(imagePicker, animated: true)
        }
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if let name = nameTextField.text, let time = timeTextField.text,
            !name.isEmpty && !time.isEmpty {
            saveButton.isEnabled = editRecipePresenter.validateRecipe(name: name, time: time)
        } else {
            saveButton.isEnabled = false
        }
    }

    @IBAction func addIngredientsButtonTouched(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Ingredient".localized(), message: "",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Introduce the new ingredient...".localized()
            textField.delegate = self
        }

        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .default)
        alertController.addAction(cancelAction)

        let addAction = UIAlertAction(title: "Add".localized(), style: .default) { (_) in
            let textField = alertController.textFields![0] as UITextField
            let text = textField.text
            self.editRecipePresenter.addIngredient(text ?? "")
        }
        alertController.addAction(addAction)

        present(alertController, animated: true)
    }

    @IBAction func addStepsButtonTouched(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Step".localized(), message: "",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Introduce the new step...".localized()
            textField.delegate = self
        }

        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .default)
        alertController.addAction(cancelAction)

        let addAction = UIAlertAction(title: "Add".localized(), style: .default) { (_) in
            let textField = alertController.textFields![0] as UITextField
            let text = textField.text
            self.editRecipePresenter.addStep(text ?? "")
        }
        alertController.addAction(addAction)

        present(alertController, animated: true)
    }

    @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
        let image = imageSelected ? imageView.image : nil
        editRecipePresenter.updateRecipe(name: nameTextField.text!, time: timeTextField.text!, image: image)
    }

}

// MARK: - EditRecipeView
extension EditRecipeViewController: EditRecipeView {

    func setRecipeName(_ name: String) {
        nameTextField.text = name
    }

    func setRecipeTime(_ time: String) {
        timeTextField.text = time
    }

    func setRecipeImage(_ image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
    }

    func setPlaceholderImage() {
        imageView.image = #imageLiteral(resourceName: "placeholder_image")
        imageView.contentMode = .scaleAspectFit
    }

    func insertRow(at indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    func deleteRow(at indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    func onSave() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UIImagePickerControllerDelegate
extension EditRecipeViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageSelected = true

        dismiss(animated: true)
    }

}

// MARK: - UINavigationControllerDelegate
extension EditRecipeViewController: UINavigationControllerDelegate {

}

// MARK: - UITextFieldDelegate
extension EditRecipeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextField {
            timeTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

}

// MARK: - UITableViewDataSource
extension EditRecipeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return editRecipePresenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editRecipePresenter.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailViewController.cellID, for: indexPath)
        cell.textLabel?.text = editRecipePresenter.textForCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return editRecipePresenter.titleForHeader(atSection: section)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            editRecipePresenter.deleteElement(at: indexPath)
        }
    }

}

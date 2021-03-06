//
//  CreateRecipeViewController.swift
//  RecipesApp
//
//  Created by Andrés Vicente Linares on 18/3/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class CreateRecipeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    // MARK: - Properties
    var createRecipePresenter: CreateRecipePresenter!
    var keyboardHelper: KeyboardHelper?
    var imageSelected = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        createRecipePresenter.attachView(createRecipeView: self)

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
            saveButton.isEnabled = createRecipePresenter.validateRecipe(name: name, time: time)
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
            self.createRecipePresenter.addIngredient(text ?? "")
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
            self.createRecipePresenter.addStep(text ?? "")
        }
        alertController.addAction(addAction)

        present(alertController, animated: true)
    }

    @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
        let image = imageSelected ? imageView.image : nil
        createRecipePresenter.saveRecipe(name: nameTextField.text!, time: timeTextField.text!, image: image)
    }

}

// MARK: - CreateRecipeView
extension CreateRecipeViewController: CreateRecipeView {

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
extension CreateRecipeViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageSelected = true

        dismiss(animated: true)
    }

}

// MARK: - UINavigationControllerDelegate
extension CreateRecipeViewController: UINavigationControllerDelegate {

}

// MARK: - UITextFieldDelegate
extension CreateRecipeViewController: UITextFieldDelegate {

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
extension CreateRecipeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return createRecipePresenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createRecipePresenter.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailViewController.cellID, for: indexPath)
        cell.textLabel?.text = createRecipePresenter.textForCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return createRecipePresenter.titleForHeader(atSection: section)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            createRecipePresenter.deleteElement(at: indexPath)
        }
    }

}

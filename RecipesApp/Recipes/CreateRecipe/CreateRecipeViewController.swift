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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        createRecipePresenter.attachView(createRecipeView: self)
    }

    // MARK: - IBActions
    @IBAction func selectImageButtonTouched(_ sender: UIButton) {
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
        createRecipePresenter.saveRecipe()
    }

}

// MARK: - CreateRecipeView
extension CreateRecipeViewController: CreateRecipeView {

    func updateTableWithRowAdded(at indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    func onSave() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITextFieldDelegate
extension CreateRecipeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextField {
            timeTextField.becomeFirstResponder()
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

}

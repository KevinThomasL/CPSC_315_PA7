//
//  AddTripViewController.swift
//  PA7
//
//  Created by Kevin Lunden on 10/30/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//
import UIKit

class AddTripViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
 {

    var tripOptional: Trip? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var destinationName: String?
    var startDate: Date?
    var endDate: Date?
    var imageFileName: String?
    var imageFilePath: String?
    
    @IBOutlet var destinationTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let identifier = segue.identifier {
            if identifier == "SaveSegue" {
                if let destination = destinationTextField.text, let start = dateFormatter.date(from: startDateTextField.text!), let end = dateFormatter.date(from: endDateTextField.text!) {
                    
                    destinationName = destination
                    startDate = start
                    endDate = end

                    if let imagePath = imageFilePath {
                        imageFileName = imagePath
                    }
                    else {
                        imageFileName = nil
                    }
                }
            }
        }
    }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true,
                completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
    
        present(alertController, animated: true, completion: nil)
    }
    
    // Controller for image picker option
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
        guard let selectedImage = info[.originalImage] as? UIImage
        else { return }
       
        writeImage(imageOptional: selectedImage)
        dismiss(animated: true, completion: nil)
    }

    
    func writeImage(imageOptional: UIImage?) {
        if let image = imageOptional {
            let imageName = UUID().uuidString
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let imagePath = paths[0].appendingPathComponent(imageName)
            
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imagePath)
            }
            
            self.imageFilePath = imagePath.path
        }
    }
    
    func destinationInputCheck() -> Bool {
        if let text = destinationTextField.text, text.isEmpty {
            let alertController = UIAlertController(title: "Destination Input Alert", message: "Missing Destination", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            return true
        }
        return false
    }
    
    func startDateInputCheck() {
        let alertController = UIAlertController(title: "Start Date Input Alert", message: "Invalid Start Date Entered", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func endDateInputCheck() {
        let alertController = UIAlertController(title: "End Date Input Alert", message: "Invalid End Date Entered", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        destinationTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
        return true
    }
    
    @objc func handleTap() {
        destinationTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
    }
    
}

//
//  CameraViewController.swift
//  wip_meenagram
//
//

import UIKit


class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func pickFromPhotoLibrary(_ sender: Any) {
        pickFromLibrary()
    }
    @IBAction func takeAPhoto(_ sender: Any) {
        pickupCamera()
    }
    @IBAction func cancelShareAction(_ sender: Any) {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePVC") as! UIPageViewController
        self.present(homeVC, animated: true, completion: nil)
    }
    @IBAction func shareAction(_ sender: Any) {

        photoUploaded()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        self.dismiss(animated: true, completion: nil)
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePVC") as! UIPageViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
        
    }
    func pickFromLibrary(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
       
    }
    func pickupCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    func photoUploaded(){
        let alertVC = UIAlertController(
            title: "Photo Uploaded",
            message: "Your Photo as been Uploaded",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }

}

//
//  PhotoViewController.swift
//  MSU Groups
//
//  Created by John Lin on 12/7/20.
//

import UIKit
import AlamofireImage
import Parse

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onChoosePicture(_ sender: Any) {
        let user = PFUser.current
        let imageData = imageView.image?.pngData()
        if imageView.image == nil {
           // myTextField is not empty here
            print("Image view is empty")
        }else{
            let file = PFFileObject(data: imageData!)
            user()!["profileImage"] = file
        
            user()!.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("Success!!")
              } else {
                print("Error!!")
              }
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            picker.sourceType = .savedPhotosAlbum
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  CameraView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/14.
//

import SwiftUI

class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @Binding var image: UIImage
    @Binding var isActive: Bool
    
    init(image: Binding<UIImage>, isActive: Binding<Bool>) {
        _image = image
        _isActive = isActive
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isActive = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isActive = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    //coordinator
    @Binding var image: UIImage
    @Binding var isActive: Bool
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        //풀스크린
        picker.modalPresentationStyle = .fullScreen
        picker.cameraViewTransform = CGAffineTransformMakeScale(1.0, 1.03);
        picker.modalPresentationStyle = .fullScreen
        
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //do nothing
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isActive: $isActive)
    }
}





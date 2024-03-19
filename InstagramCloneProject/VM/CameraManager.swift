//
//  CameraManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/14.
//

import Foundation
import AVKit

class CameraManager: ObservableObject {
    static let shared = CameraManager()
    
    func checkCameraAuth() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        if status == .authorized {
            //TODO: 카메라 접근 권한이 이미 허용 상태인 경우
        } else if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { accessGranted in
                DispatchQueue.main.async {
                    if accessGranted {
                        //TODO: 지금 카메라 접근 권한을 허용한 경우
                    } else {
                        //TODO: 카메라 접근 권한 거부 상태인 경우
                    }
                }
            }
        } else {
            //TODO: 카메라 접근 권한 거부 상태인 경우
        }
        // MARK: - 전면,후면,마이크
//                AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
//                AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
//                AVCaptureDevice.default(.builtInMicrophone, for: AVMediaType.audio, position: .unspecified)
        
        return true
    }
    
    
    private init(){}
}

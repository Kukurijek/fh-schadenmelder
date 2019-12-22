//
//  TakePhotoController.swift
//  
//
//  Created by Filipovic Nemanja on 22.12.19.
//

import UIKit
import AVFoundation
import ProgressHUD
import Photos

class TakePhotoController: UIViewController {

    @IBOutlet weak var takePhoto: UIButton!
    @IBOutlet weak var switchCamera: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var imagePreview: UIImageView!
    
    var captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        takePhoto.isHidden = false
    }
    
    func switchCamerafunc() {
        guard let input = captureSession.inputs[0] as? AVCaptureDeviceInput else { return }
        
        captureSession.beginConfiguration()
        defer { captureSession.commitConfiguration() }
        
        var newDevice: AVCaptureDevice?
        
        if input.device.position == .back {
            newDevice = whichCameraIsInUse(with: .front)
        } else {
            newDevice = whichCameraIsInUse(with: .back)
        }
        
        var deviceInput: AVCaptureDeviceInput!
        
        do {
            guard let device = newDevice else { return }
            deviceInput = try AVCaptureDeviceInput(device: device)
            
        } catch let error {
            ProgressHUD.show(error.localizedDescription)
        }
        
        captureSession.removeInput(input)
        captureSession.addInput(deviceInput)
    }
    
    func whichCameraIsInUse(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTelephotoCamera, .builtInWideAngleCamera], mediaType: .video, position: .unspecified).devices
        for device in device {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    func cancel() {
        if imagePreview.image == nil {
            dismiss(animated: true, completion: nil)
        } else {
            imagePreview.image = nil
        }
    }
    
    @IBAction func switchCameraPressed(_ sender: Any) {
        switchCamerafunc()
    }
    @IBAction func takePhotoPressed(_ sender: Any) {
    }
    @IBAction func backPressed(_ sender: Any) {
        cancel()
        takePhoto.isHidden = true
    }
}

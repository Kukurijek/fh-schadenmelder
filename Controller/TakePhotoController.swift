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

class TakePhotoController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var takePhoto: UIButton!
    @IBOutlet weak var switchCamera: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var savePhotoButton: UIButton!
    
    var captureSession = AVCaptureSession()
    var photoOutput = AVCapturePhotoOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        takePhoto.isHidden = false
        savePhotoButton.isHidden = true
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do {
            guard let device = captureDevice else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
        } catch let error {
            ProgressHUD.show(error.localizedDescription)
        }
        
        photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
        
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
        cameraPreviewLayer.frame = view.frame
        
        view.layer.insertSublayer(cameraPreviewLayer, at: 0)
        
        captureSession.startRunning()
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
    
    func takePhotoFunc() {
        let settings = AVCapturePhotoSettings()
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func savePhoto() {
        let library = PHPhotoLibrary.shared()
        guard let image = imagePreview.image else { return }
        
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { (success, error) in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
                return
            } else {
                ProgressHUD.showSuccess("Foto gespeichert")
            }
        }
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
    @IBAction func savePhotoPressed(_ sender: Any) {
        savePhoto()
        savePhotoButton.isHidden = true
        takePhoto.isHidden = false
    }
}

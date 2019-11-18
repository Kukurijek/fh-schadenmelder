//
//  CameraController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 16.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos
import ProgressHUD

class CameraController : UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var photoPreview: UIImageView!
    @IBOutlet weak var fotoSpeichern: UIButton!
    @IBOutlet weak var fotoAufnehmen: UIButton!
    @IBOutlet weak var fotoLoeschen: UIButton!
    @IBOutlet weak var fotoHinzufuegen: UIButton!
    
    var captureSession = AVCaptureSession()
    var photoOutput = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        setupCaptureSession()
        fotoLoeschen.isHidden = false
        fotoSpeichern.isHidden = true
        fotoHinzufuegen.isHidden = true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
           // ProgressHUD.show(error.localizedDescription)
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
    
    func switchCamera() {
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
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewFormatType]
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            photoPreview.image = UIImage(data: imageData)
        }
    }
    
    func savePhoto() {
        let library = PHPhotoLibrary.shared()
        guard let image = photoPreview.image else { return }
        
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
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        print("testttttt")
        takePhoto()
        print("ja")
        fotoAufnehmen.isHidden = true
        fotoLoeschen.isHidden = false
        fotoSpeichern.isHidden = false
        fotoHinzufuegen.isHidden = false

    }
    @IBAction func switchCameraButtonPressed(_ sender: Any) {
        print("buumbumbumbula")
        switchCamera()
        print("jaaaaaa")
    }
    @IBAction func savePhoto(_ sender: Any) {
        savePhoto()
        fotoSpeichern.isHidden = true
        fotoHinzufuegen.isHidden = true

    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        cancel()
        fotoAufnehmen.isHidden = false
        fotoSpeichern.isHidden = true
        fotoHinzufuegen.isHidden = true
        
    }
    
    func cancel() {
        if photoPreview.image == nil {
            dismiss(animated: true, completion: nil)
        } else {
        photoPreview.image = nil
        }
    }
}

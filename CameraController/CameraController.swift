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

class CameraController : UIViewController {
    
    var captureSession = AVCaptureSession()
    var photoOutput = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        setupCaptureSession()
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
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        print("testttttt")
    }
}

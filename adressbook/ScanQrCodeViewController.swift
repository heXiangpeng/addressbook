//
//  ScanQrCodeViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/11.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit
import AVFoundation
import Contacts

class ScanQrCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    
     let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.view.backgroundColor = UIColor.whiteColor()
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "扫一扫"
        self.navigationItem.titleView = lable
        lable.sizeToFit()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navback"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.translucent = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
       self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            
            
            captureMetadataOutput.metadataObjectTypes = supportedBarCodes
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = CGRectMake(25, self.view.frame.height*0.5-(self.view.frame.width-50)*0.7, self.view.frame.width-50, self.view.frame.width-50)
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture
            captureSession?.startRunning()
            


            
        }catch{
           
            
            
            
            return
        }
        
        
       
    
    
    }
    
  
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            return
        }
        
        let metadataOBJ = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        
        if metadataOBJ.type == AVMetadataObjectTypeQRCode {
            let barCodeObject =
            videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataOBJ
                as AVMetadataMachineReadableCodeObject) as!
            AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataOBJ.stringValue != nil {
               print(metadataOBJ.stringValue)
                print(metadataOBJ.stringValue)
                let code = metadataOBJ.stringValue.split(":")
                if(code[0]=="huayuan"){
                    
               
                let add = ["name":code[1],"phone":code[2]]
                let adddictory = [add]
                    
                 self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        Register.getInstance().uploadByJson(adddictory, taken: tak, callback: { (result) -> Void in
                            if (result=="suc"){
                                MessageNotice.showNotice("上传成功")
                            }
                        })
                        
                        
                    })
                    
                    
                }
                
            }
            
            
        }
        
                
                
                
                
            
        
        
        
    }
    
    
    func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    



}

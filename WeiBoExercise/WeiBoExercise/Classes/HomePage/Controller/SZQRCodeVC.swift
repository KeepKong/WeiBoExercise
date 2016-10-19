//
//  SZQRCodeVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/20.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import AVFoundation


class SZQRCodeVC: UIViewController {


    @IBOutlet weak var heightConstans: NSLayoutConstraint!
    
    @IBOutlet weak var scanBgView: UIView!


    @IBOutlet weak var scanImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        print("push出二维码界面")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(white: 0.4, alpha: 0.05)
        
        scanBgView.layer.masksToBounds = true
    
        startQRAnimation()

        
    }
    
    
    func startQRAnimation(){
        
        
        //1.创建动画对象
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        //2.设置动画属性
        
        animation.fromValue = -heightConstans.constant
        animation.toValue = heightConstans.constant
        
        //重复
        animation.repeatCount = HUGE
        
        //时长
        animation.duration = 5.0
        
        //动画结束后 是否移除
        animation.removedOnCompletion = false
        

        scanImage.layer.addAnimation(animation, forKey: "animationView")
        
        
    }
    
    
    @IBAction func backAction(sender: UIButton)
    {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
        
    }

    func startScanQRCode(){
        

        if !session.canAddInput(inputDevice){
            
            //提示用户，
            
            return
            
        }
        
        if !session.canAddOutput(output){
            

            return
        }
        

        session.addInput(inputDevice)
        

        session.addOutput(output)
        

        output.metadataObjectTypes = output.availableMetadataObjectTypes

        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        

        view.layer.insertSublayer(previewLayer, atIndex: 0)
        

        session.startRunning()
        
        
        
    }

    lazy var session : AVCaptureSession = AVCaptureSession()
    
    
    //输入设备
    lazy var inputDevice : AVCaptureDeviceInput? = {
        
        //获取设备的类型
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

        
        do {
            

            let input = try AVCaptureDeviceInput.init(device: device)  
            
            return input
            
        }catch{
            
            
            print(error)
            
            return nil
            
        }
        
        
    }()
    
    //输出设备
    lazy var output : AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    //预览图层
    lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        
        
        let pLayer = AVCaptureVideoPreviewLayer.init(session: self.session)
        
        pLayer.frame = UIScreen.mainScreen().bounds
        
        return pLayer
        
    }()
    
    //绘图的 父层
    lazy var  drawLayer : CALayer = {
        
        let drawLayer = CALayer()
        
        drawLayer.frame = UIScreen.mainScreen().bounds
        
        self.previewLayer.addSublayer(drawLayer)
        
        return drawLayer
    }()
    
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension SZQRCodeVC : AVCaptureMetadataOutputObjectsDelegate {
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        removeLayer()
        
        
        print("输出设备解析到值 ，就会触发代理的这个方法")
        print(metadataObjects)
        
        
        
        //遍历数组
        for metaObject in metadataObjects {
            
            
            if metaObject is AVMetadataMachineReadableCodeObject {
                
                let mechineObject  = previewLayer.transformedMetadataObjectForMetadataObject(metaObject as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                
                
                //调用方法，绘制二维码边框
                
                drawQRBorder(mechineObject)
            }
            
            
            
        }
        
    }
    
    
    
    private func drawQRBorder(mechineObject : AVMetadataMachineReadableCodeObject){
        
        
        
        let path = UIBezierPath()
        
        var point = CGPointZero
        
        CGPointMakeWithDictionaryRepresentation( mechineObject.corners[0] as! CFDictionaryRef , &point)
        
        path.moveToPoint(point)
        
        
        for index in 1..<mechineObject.corners.count {
            
            CGPointMakeWithDictionaryRepresentation( mechineObject.corners[index] as! CFDictionaryRef , &point)
            
            path.addLineToPoint(point)
            
        }
        
        
        path.closePath()
        
        
        //CAShapeLayer
        let shapeLayer : CAShapeLayer = CAShapeLayer()
        
        shapeLayer.path = path.CGPath
        
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.borderWidth = 5
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        
        
        drawLayer.addSublayer(shapeLayer)
        
    }
    
    
    private func removeLayer(){
        
        if drawLayer.sublayers != nil {
            
            
            for sublayer in drawLayer.sublayers! {
                
                
                sublayer.removeFromSuperlayer()
            }
            
            
        }
        
        
        
    }
    
    
    
}

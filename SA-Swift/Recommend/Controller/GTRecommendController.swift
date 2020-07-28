//
//  GTRecommendController.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/10.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit
import MobileCoreServices

class GTRecommendController: UIViewController,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private var picker : UIImagePickerController
    private var imageView : UIImageView
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        picker = UIImagePickerController()
        imageView = UIImageView.init(frame: UIRect(x: 10, y: 150, width: 150, height: 150))
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "推荐"
        self.tabBarItem.image = UIImage.init(named: "icon.bundle/like@2x.png")
        self.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/like_selected@2x.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.showsVerticalScrollIndicator = false //垂直滚动条
        scrollView.showsHorizontalScrollIndicator = false //水平滚动条
        scrollView.contentSize = CGSize(width: self.view.bounds.size.width * 5, height: 0)
        scrollView.delegate = self
        picker.delegate = self
        let colorArray = [UIColor.red,.blue,.yellow,.lightGray,.gray]
        for i in 0..<5 {
            let view = UIView.init(frame: CGRect(x: scrollView.bounds.size.width * CGFloat(i), y: 0, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height))
            view.backgroundColor = colorArray[i]
            if (i == 0) {
                let picBtn = UIButton.init(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
                picBtn.backgroundColor = UIColor.white
                picBtn.setTitle("拍照", for: .normal)
                picBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
                picBtn.addTarget(self, action: #selector(takePicture), for: .touchUpInside)
                view.addSubview(picBtn)
                
                let chooseBtn = UIButton.init(frame: CGRect(x: 200, y: 10, width: 100, height: 50))
                chooseBtn.backgroundColor = UIColor.white
                chooseBtn.setTitle("选取照片", for: .normal)
                chooseBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
                chooseBtn.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
                view.addSubview(chooseBtn)
                
                imageView.backgroundColor = UIColor.white
                view.addSubview(imageView)
            }
            scrollView.addSubview(view)
        }
        self.view.addSubview(scrollView)
    }
    
    @objc func takePicture() {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            // 将sourceType设为camera代表拍照或拍视频
            picker.sourceType = .camera
            // 设置拍摄照片
            picker.cameraCaptureMode = .photo
            // 设置使用手机的后置摄像头（默认使用后置摄像头）
            picker.cameraDevice = .rear
            // 设置使用手机的前置摄像头
            picker.cameraDevice = .front
            // 设置拍摄的照片允许编辑
            picker.allowsEditing = true
            // 显示picker实图控制器
            self.present(picker, animated: true, completion: nil)
        }else {
            print("模拟器无法打开摄像头")
        }
    }
    
    @objc func chooseImage() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll---")
    }
    
    //和点进协议里面的方法不一样，很蛋疼，得输入关键字手动提示，才能看到协议中的方法，类后面写上协议之后，xcode可以自动提示，并添加协议中的方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 获取用户拍摄的是照片还是视频 swift这边需要包装一下
        let mediaType = info[UIImagePickerController.InfoKey.mediaType]
        if mediaType as! String == kUTTypeImage as String{
            if (picker.sourceType == .camera) {
                imageView.image = info[.originalImage] as? UIImage
            }else if (picker.sourceType == .photoLibrary) {
                imageView.image = info[.originalImage] as? UIImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("用户取消拍摄！")
        picker.dismiss(animated: true, completion: nil)
    }
}

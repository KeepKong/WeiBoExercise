//
//  SZNotLoginView.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/20.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit



protocol RegisterOrLoginOrFollowActionDelegate : NSObjectProtocol {
    
    //登录事件
    func loginBtnClicked()
    
    //注册事件
    func registerBtnClicked()
    
    //去关注事件
    func followBtnClicked()
    
}


class SZNotLoginView: UIView {


    weak var delegate : RegisterOrLoginOrFollowActionDelegate?

    
    var isHomePage : TabBarIndex?
    {
        willSet
        {
            
        
            switch(newValue!)
            {
            
            case .HomePage:
                
                iconView.image = UIImage.init(named: "visitordiscover_feed_image_house")
                descriptionLabel.text = "关注一些人，回这里看看有什么惊喜"
                followBtn.hidden = false

                
                registerBtn.hidden = true
                loginBtn.hidden = true

                
                break
                
            case .MessagePage:
                
                iconView.image = UIImage.init(named: "visitordiscover_image_message")
                descriptionLabel.text = "关注一些人，回这里看看有什么惊喜"
                followBtn.hidden = true
                
                registerBtn.hidden = false
                loginBtn.hidden = false
                
                
                break
            case .PersonalPage:
            
                iconView.image = UIImage.init(named: "visitordiscover_image_profile")
                descriptionLabel.text = "个人页面，登录有信息哦！"
                followBtn.hidden = true
                
                registerBtn.hidden = false
                loginBtn.hidden = false
                break
            }
            
        }
        
    
    }
    
    
    
    override init(frame: CGRect)
    {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
 
        self.addSubview(circleView)
        self.addSubview(maskV)
        self.addSubview(iconView)
        self.addSubview(descriptionLabel)
        self.addSubview(followBtn)
        self.addSubview(registerBtn)
        self.addSubview(loginBtn)

        print(center)
        
        
        //（2）布局子视图
        circleView.center = CGPointMake(center.x, center.y * 0.75)
        circleView.bounds.size.height = 200.0
        circleView.bounds.size.width = 200.0
        
        maskV.center = circleView.center
        maskV.bounds.size.height = 200.0
        maskV.bounds.size.width = 200.0
        
        
        iconView.center = CGPointMake(center.x, center.y * 0.75)
        iconView.bounds.size.height = 100.0
        iconView.bounds.size.width = 100.0
        
        //宽度
        let labelW = frame.size.width * 0.6
        
        //在Swift中 结构体也是类型，因此下面的代码没有问题
        descriptionLabel.frame.origin.x = (frame.size.width * 0.4)/2.0
        descriptionLabel.frame.origin.y = CGRectGetMaxY(iconView.frame) + 70.0
        descriptionLabel.frame.size.width = labelW
        
        //textLabel是代码创建的，它的高度要自适应的话，需要一行代码
        //如果没有这一行，你又没有设置高度，那么label无法显示
        descriptionLabel.sizeToFit()
        
        
        //按钮
        let btnW = (descriptionLabel.frame.size.width - 20.0)/2.0
        let btnH : CGFloat = 40.0
        
        


        followBtn.center.x = descriptionLabel.center.x
        followBtn.frame.origin.y = CGRectGetMaxY(descriptionLabel.frame) + 40.0
        followBtn.bounds.size.height = btnH
        followBtn.bounds.size.width = btnW
        
        registerBtn.frame = CGRectMake(descriptionLabel.frame.origin.x, CGRectGetMaxY(descriptionLabel.frame) + 20.0, btnW, btnH)

        
        //登录按钮
        loginBtn.frame = CGRectMake(CGRectGetMaxX(registerBtn.frame) + 20.0, registerBtn.frame.origin.y,btnW, btnH)
        
        
        
        //开启旋转动画
        startAnimation()
        
        
    }

    //MARK: - 转盘的动画
    private func startAnimation(){
        
        
        //1.创建动画对象
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        //2.设置动画属性
        
        //旋转角度
        //animation.fromValue
        animation.toValue = 2 * M_PI
        
        //重复
        animation.repeatCount = MAXFLOAT
        
        //时长
        animation.duration = 30.0
        
        //动画结束后 是否移除
        animation.removedOnCompletion = false
        
        //3.添加给对应的图层
        circleView.layer.addAnimation(animation, forKey: nil)
        
    }

    
    
    //MARK: -按钮相应方法
    
    func followBtnAction(sender : UIButton)
    {
    
        self.delegate?.followBtnClicked()
        
        
    }
    func registerBtnAction(sender : UIButton)
    {
    
        self.delegate?.registerBtnClicked()
        
    }
    func loginBtnAction(sender : UIButton)
    {
    
        self.delegate?.loginBtnClicked()
    }
    
    
    //MARK: -懒加载
    lazy var circleView : UIImageView =
    {
    
        let circleView : UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_smallicon"))
    
        
    
        return circleView
        
        
    }()
    
    lazy var maskV : UIImageView =
    {
        
        let maskV : UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_mask_smallicon"))
        
        return maskV
        
    }()
    
    lazy var iconView : UIImageView =
    {
        
        let iconView : UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_image_message"))

        return iconView
        
        
    }()
    lazy var descriptionLabel : UILabel =
    {
        
        let descriptionLabel : UILabel = UILabel.init()
        //设置属性
        descriptionLabel.textColor = UIColor.grayColor()
        descriptionLabel.font = UIFont.systemFontOfSize(15.0)
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.text = "登录后，别人评论你的微博，给你发消息都会在这里收到通知"
        
        return descriptionLabel
        
    }()
    
    
    lazy var followBtn : UIButton =
    {
        
        let followBtn : UIButton = UIButton.init()
        followBtn.setTitle("去关注", forState: .Normal)
        followBtn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        followBtn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), forState: .Normal)
        
        //事件处理
        followBtn.addTarget(self, action: "followBtnAction:", forControlEvents: .TouchUpInside)
        
        
        return followBtn
        
    }()
    
    lazy var registerBtn : UIButton =
    {
        
        let registerBtn : UIButton = UIButton.init()
        registerBtn.setTitle("注册", forState: .Normal)
        registerBtn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        registerBtn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), forState: .Normal)
        
        //事件处理
        registerBtn.addTarget(self, action: "registerBtnAction:", forControlEvents: .TouchUpInside)
        
        
        return registerBtn
        
    }()
    
    lazy var loginBtn : UIButton =
    {
        
        let loginBtn : UIButton = UIButton.init()
        loginBtn.setTitle("登录", forState: .Normal)
        loginBtn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        loginBtn.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), forState: .Normal)
        
        //事件处理
        loginBtn.addTarget(self, action: "loginBtnAction:", forControlEvents: .TouchUpInside)
        
        
        return loginBtn
        
        
    }()

    
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

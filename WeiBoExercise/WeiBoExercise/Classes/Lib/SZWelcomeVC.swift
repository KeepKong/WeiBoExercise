//
//  SZWelcomeVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/23.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import SDWebImage


class SZWelcomeVC: UIViewController {

    
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var infolabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        infolabel.alpha = 0.05
        
        iconImage.layer.cornerRadius = iconImage.bounds.size.height/2.0
        iconImage.layer.masksToBounds = true
        
        let model : SZAccountModel? = SZAccountModel.loadAccount()
        
        if model != nil
        {
        
            let urlStr : String = model!.avatar_large!

            
            let url : NSURL = NSURL(string: urlStr)!
            iconImage.sd_setImageWithURL(url)
//            print("url = \(urlStr)")
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        bgView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen().bounds.size.height - bgView.frame.origin.y)
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.45, initialSpringVelocity: 5, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.bgView.transform = CGAffineTransformIdentity
            
            self.infolabel.alpha = 1

            
            }) { (_) -> Void in
                
                
                self.performSelector("welcomeToLoginPage", withObject: nil, afterDelay: 0.5)
                
                
        }
        
    }
    
    func welcomeToLoginPage()
    {
    
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginInterface : SZMainTabBarVC = storyBoard.instantiateInitialViewController() as! SZMainTabBarVC
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = LoginInterface
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  SZHomeRetweetedCell.swift
//  WeiBoExercise
//
//  Created by lx on 16/10/3.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import SDWebImage


class SZHomeRetweetedCell: UITableViewCell {


    @IBOutlet weak var iconButton: UIButton!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
    
    
    @IBOutlet weak var verifiedImage: UIImageView!
    
    
    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var vipImageV: UIImageView!
    
    
    
    
    @IBOutlet weak var creatTimeLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    //------------------------
    
    //原创微博中间内容视图
    //    @IBOutlet weak var amongContentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var amongContentHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var amongContentView: UIView!
    
    //中间内容视图的集合视图
    @IBOutlet weak var amongCollectionView: SZAmongCollectionV!
    //中间内容集合视图的高度约束
    
    @IBOutlet weak var amongCollectionViewHeight: NSLayoutConstraint!
    //中间内容结合视图的宽度
    @IBOutlet weak var amongCollectionViewWidth: NSLayoutConstraint!
    
    
        //转发相关控件
    
    @IBOutlet weak var retweetedLabel: UILabel!
    
    
    
    //------------------------
    
    
    
    
    
    @IBOutlet weak var repostButton: UIButton!
    
    @IBOutlet weak var repostCount: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var commentCount: UILabel!
    
    
    @IBOutlet weak var attitudeButton: UIButton!
    
    @IBOutlet weak var attitudeCount: UILabel!
    
    @IBOutlet weak var attitudeImage: UIImageView!
    
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    
    
    
    
    
    var model : SZHomePageModel?
        {
        
        didSet
        {
            
            let url = NSURL.init(string: (model?.user!.profile_image_url)!)
//            print(url!)
            iconImage.sd_setImageWithURL(url!)
            //用户名字
            screenName.text = model?.user?.screen_name
//            print(model!.user!.screen_name!)
//            print("name = \(model?.user?.screen_name!)")
            //vip图片
            vipImageV.image = model?.user?.vipImage
            
            
            //设置认证图片
            verifiedImage.image = model?.user?.verifiedImage
            
            
            //设置微博发布时间
            creatTimeLabel.text = model?.created_at
            
            //来源信息
            sourceLabel.text = model?.source
            
            //发布的文本内容
            contentLabel.text = model?.text
            
            //转发数
            repostCount.text = "\(model!.reposts_count!)"
            
            //评论数
            commentCount.text = "\(model!.comments_count!)"
            
            //点赞数
            attitudeCount.text = "\(model!.attitudes_count!)"
            
            //转发微博文本内容
            retweetedLabel.text = "\(model!.retweeted_status!.text!)"
            
            
            //改变顶部个人信息和微博内容的高度
            //上面的间距 + （头像等用户信息的固定高度 + 头像和内容间距） + （微博内容高度 + 间距）
            
            topViewHeight.constant = 10 + (40 + 10) + (model?.topContentHeight)!
            
            //改变中间内容视图的总高度的约束
            amongContentHeight.constant = (model?.retweetedContentHeight)!
            
            
            /**
            改变中间内容集合视图的宽度和高度，来适应相应图片个数的变化，例如4张图片就以田字形显示等.
            */
            amongCollectionViewHeight.constant = (model?.retweetedCollectionHeight)!
            amongCollectionViewWidth.constant = (model?.retweetedCollectionWidth)!
            
            amongCollectionView.storedImageUrlArr = model?.retweeted_status?.storedImageUrlArr
            //设置对应图片的宽度和高度
            amongCollectionView.imageWidth = (model?.imageWidth)!
//            print((model?.imageWidth)!)
            
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        iconButton.layer.cornerRadius = iconButton.bounds.size.height/2.0
        iconButton.layer.masksToBounds = true
        
        
        iconImage.layer.cornerRadius = iconImage.bounds.size.height/2.0
        iconImage.layer.masksToBounds = true
        
        
        contentLabel.font = UIFont.systemFontOfSize(16);
        retweetedLabel.font = UIFont.systemFontOfSize(16)
                
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

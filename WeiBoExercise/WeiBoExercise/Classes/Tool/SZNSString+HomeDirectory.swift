//
//  SZNSString+HomeDirectory.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/23.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import Foundation


extension String
{

    func documentsDir() -> String{
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString
        
        return path.stringByAppendingPathComponent(self)
        
    }
    
    
    func cachesDir() -> String{
        
        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last! as NSString
        
        return path.stringByAppendingPathComponent(self)
        
    }
    
    
    func tempDir() -> String{
        
        let path = NSTemporaryDirectory() as NSString
        
        return path.stringByAppendingPathComponent(self)
    }
}

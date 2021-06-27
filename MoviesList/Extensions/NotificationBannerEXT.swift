//
//  CLayerExt.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import UIKit
import NotificationBannerSwift

extension NotificationBanner {
    
    class func showTopBanner(_ titleText:String, style: BannerStyle) {
        
        let banner = GrowingNotificationBanner(title: "", subtitle: titleText, leftView: nil, rightView: nil, style: style, colors: nil, iconPosition: .top)
        
        banner.duration = 5.0
        if banner.bannerQueue.numberOfBanners < 1 {
            banner.show(queuePosition: QueuePosition(rawValue: 1)!, bannerPosition: BannerPosition.top, queue: banner.bannerQueue, on: nil)
        }
    }
    
    
    class func showTopBannerWithDuration(_ titleText:String, style: BannerStyle, duration:Double) {
        
        let banner = GrowingNotificationBanner(title: "", subtitle: titleText, leftView: nil, rightView: nil, style: style, colors: nil, iconPosition: .top)
        
        banner.duration = duration
        if banner.bannerQueue.numberOfBanners < 1 {
            banner.show(queuePosition: QueuePosition(rawValue: 1)!, bannerPosition: BannerPosition.top, queue: banner.bannerQueue, on: nil)
        }
    }
}

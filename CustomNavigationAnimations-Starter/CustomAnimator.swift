//
//  CustomAnimator.swift
//  CustomNavigationAnimations-Starter
//
//  Created by MyGlamm on 9/20/19.
//  Copyright © 2019 Sam Stone. All rights reserved.
//

import UIKit

class customAnimator : NSObject,UIViewControllerAnimatedTransitioning{
    
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect
    var image : UIImage
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, image : UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
    }
    
    //The tag of ImageView in musicPlayerVC
    public let customAnimatorTag = 99
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: .from) else {return}
        
        guard let toView = transitionContext.view(forKey: .to) else {return}
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        

        
        //Getting image of MusicPlayer and setting it 0
        guard let artwork = detailView.viewWithTag(customAnimatorTag) as? UIImageView else  {return}
        artwork.image = image
        artwork.alpha = 0
        
        //UIImageView for transition for presenting and dismissing
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : artwork.frame)
        transitionImageView.image = image
        
        container.addSubview(transitionImageView)
        
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        
        toView.alpha = isPresenting ? 0 : 1
        
        
        
        
         toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            
            transitionImageView.frame = self.isPresenting ? artwork.frame : self.originFrame
            
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            artwork.alpha = 1
        }
        
        
        
    }
    
    
    
    
    
    
    
}


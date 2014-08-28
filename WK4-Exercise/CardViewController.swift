//
//  CardViewController.swift
//  WK4-Exercise
//
//  Created by Daniel Eden on 8/27/14.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class CardViewController: ViewController {

    var cardInitialCenter: CGPoint!
    var transition: CustomSegue!

    
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardImageView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
        
        cardInitialCenter = cardImageView.center
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    
        transition = CustomSegue()
        var duration = 0.4
        
        var window = UIApplication.sharedApplication().keyWindow
        var frame = window.convertRect(cardImageView.frame, fromView: self.view)
        var newImageView = UIImageView(image: cardImageView.image)
        newImageView.frame = frame
        newImageView.contentMode = UIViewContentMode.ScaleAspectFill
        newImageView.layer.cornerRadius = 5
        newImageView.clipsToBounds = true
        
        window.addSubview(newImageView)
        
        transition.duration = duration
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            newImageView.frame = CGRect(x: 0, y: 63, width: 320, height: 320)
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.1, animations: {
                    newImageView.alpha = 0
                    }, completion: { (finished: Bool) -> Void in
                    newImageView.removeFromSuperview()
                })
        }
        
        var destinationViewController = segue.destinationViewController as ProfileViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.image = self.cardImageView.image
        destinationViewController.transitioningDelegate = transition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCardPanGesture(gesture: UIPanGestureRecognizer) {
        var translation = gesture.translationInView(view)
        var location = gesture.locationInView(view)
        
        var rotation = translation.x / 10 * CGFloat(M_PI / 180)
        
        if gesture.state == UIGestureRecognizerState.Began {
            
            if location.y > cardInitialCenter.y {
                rotation = -rotation
            }
            
        } else if gesture.state == UIGestureRecognizerState.Changed {
            
            self.cardImageView.center.y = cardInitialCenter.y + translation.y
            self.cardImageView.center.x = cardInitialCenter.x + translation.x
            
            self.cardImageView.transform = CGAffineTransformMakeRotation(rotation)
            
        } else if gesture.state == UIGestureRecognizerState.Ended {
            
            if translation.x > 50 {
                UIView.animateWithDuration(0.3, animations: {
                    self.cardImageView.center.x += self.view.frame.width
                }, completion: nil)
            
            } else if translation.x < -50 {
                UIView.animateWithDuration(0.3, animations: {
                    self.cardImageView.center.x -= self.view.frame.width
                    }, completion: nil)
    
            } else {
                UIView.animateWithDuration(0.3, animations: {
                    self.cardImageView.center = self.cardInitialCenter
                    self.cardImageView.transform = CGAffineTransformIdentity
                    }, completion: nil)
            }
        }
    }
    
    @IBAction func onImageTap(sender: AnyObject) {
        
        performSegueWithIdentifier("profileViewSegue", sender: self)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ProfileViewController.swift
//  WK4-Exercise
//
//  Created by Daniel Eden on 8/27/14.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.image = image
        
        profileImageView.hidden = true
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        profileImageView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        var duration = 0.4
        
        var window = UIApplication.sharedApplication().keyWindow
        var frame = window.convertRect(profileImageView.frame, fromView: self.view)
        var newImageView = UIImageView(image: profileImageView.image)
        newImageView.frame = frame
        newImageView.contentMode = UIViewContentMode.ScaleAspectFill
        newImageView.layer.cornerRadius = 5
        newImageView.clipsToBounds = true
        
        window.addSubview(newImageView)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            newImageView.frame = CGRect(x: 16, y: 106, width: 288, height: 236)
            }) { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.1, animations: {
                    newImageView.alpha = 0
                    }, completion: { (finished: Bool) -> Void in
                        newImageView.removeFromSuperview()
                })
        }
        
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

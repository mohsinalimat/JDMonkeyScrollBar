//
//  JDMonkeyScrollBar.swift
//  JDMonkeyScrollBar
//
//  Created by jamesdouble on 2016/11/18.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

import UIKit



class JDMonkeyScrollBar
{
    var scrollview:UIScrollView!
    var scrollBarview:JDMonkeyScrollBarView!
    var delegte:JDMonkeyScrollBarDelegate!
    
    init(scrollview:UIScrollView)
    {
        self.scrollview = scrollview
        self.scrollview.showsVerticalScrollIndicator = false
        
        delegte = JDMonkeyScrollBarDelegate(contentheight: self.scrollview.contentSize.height,scroll: self.scrollview)
        self.scrollview.addObserver(delegte, forKeyPath: "contentOffset", options: .new, context: nil)
        
        let scrollbarviewframe:CGRect = CGRect(x: self.scrollview.frame.origin.x + self.scrollview.frame.width * 9.3/10, y: self.scrollview.frame.origin.y, width: 0.6/10 * self.scrollview.frame.width, height: self.scrollview.frame.height)
        scrollBarview = JDMonkeyScrollBarView(frame: scrollbarviewframe)
        self.scrollview.superview?.addSubview(scrollBarview)

        self.delegte.monkeyview = scrollBarview
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}



class JDMonkeyScrollBarDelegate:NSObject
{
    var scrollViewContentHeight:CGFloat = 0.0
    var monkeyview:monkeydelegate?
    var scrollView:UIScrollView?
    
    init(contentheight:CGFloat,scroll:UIScrollView) {
        super.init()
        scrollView = scroll
        scrollViewContentHeight = contentheight
    }
    
    
    func scrollViewDidScroll(){
        let contentoffsety = scrollView?.contentOffset.y
        let ratio = contentoffsety! / scrollViewContentHeight
        monkeyview?.climbingto(y: ratio)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "contentOffset") {
          scrollViewDidScroll()
        }
    }
    
    
    
}

protocol monkeydelegate {
    func climbingto(y:CGFloat)
}


class JDMonkeyScrollBarView:UIView,monkeydelegate
{
    var ladder:JDMonkeyLadder?
    var monkey_img:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = UIColor.clear
        
        ladder = JDMonkeyLadder(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.layer.addSublayer(ladder!)
        
        monkey_img = UIImageView(image: UIImage(named: "monkey"))
        monkey_img?.frame.size.width = self.frame.width
        monkey_img?.frame.size.height = self.frame.width
        self.addSubview(monkey_img!)
    }
    
    
    func climbingto(y:CGFloat)
    {
       UIView.animate(withDuration: 0.2, animations: {
        let new_y = self.frame.height * y
        
        //self.monkey_img!.frame.origin.y = new_y
        self.monkey_img!.center.y = new_y
        
            }, completion:  { b in
             var rotating_angle:CGFloat = 0.0
                
          
             if(y < 0.25)
             {
               rotating_angle = CGFloat(-0.25*M_PI) + 4*(y)*CGFloat(0.5*M_PI)
             }
             else if((y > 0.25) && (y < 0.5)){
               rotating_angle = CGFloat(0.25*M_PI) - 4*(y - 0.25)*CGFloat(0.5*M_PI)
             }
             else if((y > 0.5) && (y < 0.75)){
                rotating_angle = CGFloat(-0.25*M_PI) + 4*(y - 0.5)*CGFloat(0.5*M_PI)
             }
             else
             {
                rotating_angle = CGFloat(0.25*M_PI) - 4*(y - 0.75)*CGFloat(0.5*M_PI)
             }
                
             var climbing2 = CGAffineTransform.identity
             climbing2 = CGAffineTransform(rotationAngle: rotating_angle);
             self.monkey_img!.transform = climbing2
        })
    
    
    }
    
    
    
    
       required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class JDMonkeyLadder:CAShapeLayer
{
    var height:CGFloat!
    var width:CGFloat!
    
    init(frame:CGRect) {
        super.init()
        self.frame = frame
        var color = UIColor.black
        color = color.withAlphaComponent(0.8)
        self.strokeColor = color.cgColor
        self.lineWidth = 0.5
        self.fillColor = UIColor.clear.cgColor
        height = frame.height
        width = frame.width
        drawLadder()
    }
    
    func drawLadder()
    {
        let ladder_path = UIBezierPath()
        ladder_path.move(to: CGPoint(x: 0.0, y: 0.0))
        ladder_path.addLine(to: CGPoint(x:0.0, y:height))
        ladder_path.addLine(to: CGPoint(x:width,y:height))
        ladder_path.addLine(to: CGPoint(x:width,y:0.0))
        ladder_path.addLine(to: CGPoint(x:0.0,y:0.0))
        
        
        var now_rectangle_y:CGFloat = 5.0
        let rectangle_leftx:CGFloat = width * 1/5
        let rectangle_height:CGFloat = width * 3/5
        let rectangle_width:CGFloat = rectangle_height
        let rectangle_rightx:CGFloat = rectangle_leftx + rectangle_width
        let delta:CGFloat = 20.0
        repeat{
            let now_rectanle_downy = now_rectangle_y + rectangle_height
            ladder_path.move(to: CGPoint(x: rectangle_leftx, y: now_rectangle_y))
            ladder_path.addLine(to: CGPoint(x:rectangle_leftx, y:now_rectanle_downy))
            ladder_path.addLine(to: CGPoint(x:rectangle_rightx,y:now_rectanle_downy))
            ladder_path.addLine(to: CGPoint(x:rectangle_rightx,y:now_rectangle_y))
            ladder_path.addLine(to: CGPoint(x:rectangle_leftx,y:now_rectangle_y))
            
            now_rectangle_y += delta
        }while (now_rectangle_y < height)
        self.path = ladder_path.cgPath
    }
    

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
















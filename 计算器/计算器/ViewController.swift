//
//  ViewController.swift
//  计算器
//
//  Created by donglei on 16/5/10.
//  Copyright © 2016年 donglei. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

     let screenWidth = UIScreen.mainScreen().bounds.size.width
     let scrrenHeight = UIScreen.mainScreen().bounds.size.height
    var keyButtonWidthAndHeight :CGFloat = 0.0
    var calculateHeight:CGFloat = 0.0
    var resultViewHeight:CGFloat = 0.0
    
    var relustTextView : UITextView! = nil
    
    var relustFirst : Double? = 0.0
    var relustTwo : Double? = 0.0
    var relust : Double? = 0.0
    var relustString : String? = "0"
    
    var calculateSymbol : String? = nil  //符号
    var preSybmbol :String? = nil
    
    var ACLabel : UILabel? = nil
    
    var isconticut : Bool = false
    
    var symbolArray:NSArray{
        get{
           let pathstring =  NSBundle.mainBundle().pathForResource("array", ofType: "plist")
            let arrayy = NSArray(contentsOfFile:pathstring!)
            return arrayy!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
       keyButtonWidthAndHeight = (screenWidth  - 3) * 1/4
        calculateHeight = keyButtonWidthAndHeight * 5
       resultViewHeight = scrrenHeight - calculateHeight
        
        
        relustTextView = UITextView()
        relustTextView.text = "0"
        relustTextView.backgroundColor = UIColor.blackColor()
        relustTextView.textColor = UIColor.whiteColor()
        relustTextView.font = UIFont.systemFontOfSize(70.0)
        relustTextView.textAlignment = NSTextAlignment.Right
        relustTextView.frame = CGRectMake(0, resultViewHeight * 0.5, screenWidth, resultViewHeight * 0.5)
        self.view.addSubview(relustTextView)
        
        let layout = UICollectionViewFlowLayout()

        
        let collection = UICollectionView(frame:CGRectMake(0, resultViewHeight, UIScreen.mainScreen().bounds.size.width,calculateHeight),collectionViewLayout:layout)
 
        
        
        collection.dataSource = self
        collection.delegate = self
        collection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collection)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
   
    let label = UILabel()
    label.text = self.symbolArray[indexPath.row] as? String
    label.font  = UIFont.systemFontOfSize(40.0)
    label.textAlignment = NSTextAlignment.Center
    label.frame  = CGRectMake(0, 0, keyButtonWidthAndHeight, keyButtonWidthAndHeight)
    cell.contentView.addSubview(label)
    if indexPath.row == 0 {
        ACLabel = label
    }
    
    switch indexPath.row {
    case 3,7,11,15,18:
        label.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.orangeColor()
    default:
        cell.backgroundColor = UIColor.lightGrayColor()
    }
    
        
    
      return cell
    }
    
    
    
    //UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        
            switch indexPath.row {
            case 0:
                ACLabel?.text = "AC"
                relustString = "0"
               isconticut = false
                calculateSymbol = nil
                relustTextView.text = "0"

            case 2: // %
                 preSybmbol = calculateSymbol
                if isconticut == false {
                    
                    if let number = Double(relustString!)  {
                        relustFirst = number
                    }
                }
               relustString = "0"
                calculateSymbol = "%"
                 case 3: // /
                    if isconticut == false {
                        
                        if let number = Double(relustString!)  {
                            relustFirst = number
                        }
                    }
                    relustString = "0"
                   
                    calculateSymbol = "/"
            case 7: //*
                 preSybmbol = calculateSymbol
                if isconticut == false {
                    
                    if let number = Double(relustString!)  {
                        relustFirst = number
                    }
                }
                relustString = "0"
                calculateSymbol = "*"
            case 11://-
                 preSybmbol = calculateSymbol
                if isconticut == false {
                    
                    if let number = Double(relustString!)  {
                        relustFirst = number
                    }
                }
                relustString = "0"
                calculateSymbol = "-"
            case 15://+
               preSybmbol = calculateSymbol
                if isconticut == false {
                    
                    if let number = Double(relustString!)  {
                        relustFirst = number
                    }
                }
                relustString = "0"
                calculateSymbol = "+"
                
            case 1,4,5,6,8,9,10,12,13,14,16,17:
                
                if relustString == "0" {
                    relustString = self.symbolArray[indexPath.row] as? String
                }else {
               relustString = relustString! + (self.symbolArray[indexPath.row] as! String)
                }
                
                relustTextView.text = relustString
                

                
            case 18:
                if isconticut == true || calculateSymbol != preSybmbol {
                    
                    if let number = Double(relustString!)  {
                        relustTwo = number
                    }
                }
                calcu()
            default:
                break
                
            }

        
        
        if relustString != "0" {
            ACLabel?.text = "C"
        }
    
       
            }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    
    
    func calcu()  {
        var value: Double?
        switch calculateSymbol {
        case "*"?:
            value = relustFirst! * relustTwo!
        case "+"?:
             value = relustFirst! + relustTwo!
        case "/"?:
             value = relustFirst! / relustTwo!
        case "-"?:
            value = relustFirst! - relustTwo!
        case "%"?:
            value = relustFirst! % relustTwo!
        default:
            break
        }
         isconticut = true
        print("value:\(String(value))")
        relustFirst = value
        
        relustTextView.text = NSString(format:"%f",value!) as String
    }
    
    
    
    //UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        if indexPath.row == 16 {
            return CGSizeMake(keyButtonWidthAndHeight * 2 + 1, keyButtonWidthAndHeight)
        }
        return CGSizeMake(keyButtonWidthAndHeight, keyButtonWidthAndHeight)
    }
    
    //列间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
    
    //行间距
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }



}


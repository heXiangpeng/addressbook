//
//  HomeAddressTableViewCell.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/13.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class HomeAddressTableViewCell: UITableViewCell {
    var photo:UIImageView!
    var name:UILabel!
    var phone:UILabel!
    var numberPhone:NumberPhone!
    
    
  
    

    
    var firstName:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        photo = UIImageView(frame: CGRectMake(5,5,40,40))
//        photo.image = colorToImage(RGB(69, g: 114, b: 32), size:  photo.frame.size)
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = 20
        
        firstName = UILabel(frame: CGRectMake(10,10,20,20))
        firstName.font = UIFont.systemFontOfSize(20)
        
       
//        firstName.center = photo.center
//        firstName.textAlignment = .Center
        
        photo.addSubview(firstName)
        
        name  = UILabel(frame: CGRectMake(44+5,2,self.frame.width,30))
        name.textColor = RGB(0, g: 0, b: 0)
    
        name.font = UIFont.systemFontOfSize(15)
        
        phone = UILabel(frame: CGRectMake(44+5,35,120,12))
        phone.font = UIFont.systemFontOfSize(12)
        numberPhone = NumberPhone(frame: CGRectMake(47+100,30,18,18))
        numberPhone.layer.cornerRadius = 9
        
//        numberPhone.layer.cornerRadius = 6
//        numberPhone.backgroundColor = UIColor.grayColor()
//        numberPhone.frame.size = CGSize(width: 10, height: 10)
//        numberPhone.font = UIFont(name: "", size: 10)
//        numberPhone.translatesAutoresizingMaskIntoConstraints = false
//        self.phone.translatesAutoresizingMaskIntoConstraints = false
        let tapNumberPhone:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "clickNumber:")
         numberPhone.addGestureRecognizer(tapNumberPhone)
        

        self.addSubview(photo)
        self.addSubview(name)
        self.addSubview(phone)
        self.addSubview(numberPhone)
//        self.translatesAutoresizingMaskIntoConstraints = false
//         var metrics:Dictionary = ["hPadding":10,"vPadding":0];
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-44-[redView]-10-[yellowView]", options: NSLayoutFormatOptions.AlignAllRight, metrics: nil, views: ["numberPhone":numberPhone]))
        
//        let con = NSLayoutConstraint(item: numberPhone, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: phone, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 5)
//        
//         let con1 = NSLayoutConstraint(item: numberPhone, attribute: NSLayoutAttribute.Baseline, relatedBy: NSLayoutRelation.Equal, toItem: phone, attribute: NSLayoutAttribute.Baseline, multiplier: 1.0, constant: 0)
//        
//         let con2 = NSLayoutConstraint(item: phone, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 44)
//        
//        self.addConstraint(con)
//        self.addConstraint(con1)
//         self.addConstraint(con2)
      
    }
    
    func clickNumber(event:UITapGestureRecognizer){
        
        print(name.text)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  StringExtension.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/17.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

extension String{
    
    func getPhone() -> String {
        if(self.characters.count>11){
            var x=[String]()
            
            for y in self.characters{
                x.append(String(y))
            }
           
            var phone = String()
            for(var index = 3 ; index<self.characters.count;index++){
                phone+=x[index]
            }
            
            return String(phone)
        }else{
            return self
        }
    }
    
    func split(s:String)->[String]{
        if s.isEmpty{
            var x=[String]()
            
            for y in self.characters{
                x.append(String(y))
            }
            
          
            return x
        }
        
        return self.componentsSeparatedByString(s)
    }
    
    
    func getFirst()->String {
       
            var x=[String]()
            
            for y in self.characters{
                x.append(String(y))
            }
        if (x.count>0){
        return x[0] as String
         }
        
        return ""
    }
    
    func getfromto(s:Int)->String {
        
        var x=[String]()
        
        for y in self.characters{
            x.append(String(y))
        }
        var retsturn = ""
        for(var i = s ;i<x.count;i++){
            retsturn+=x[i]
        }
        
        return retsturn
    }
    
    
    
    
    func URLEncodedString() -> String? {
        let customAllowedSet =  NSCharacterSet.URLQueryAllowedCharacterSet()
        let escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return escapedString
    }
}

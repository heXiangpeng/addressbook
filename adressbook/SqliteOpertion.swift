//
//  SqliteOpertion.swift
//  adressbook
//
//  Created by hexiangpeng on 15/12/8.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class SqliteOpertion: NSObject {
    
    var db:COpaquePointer = nil
    let dbname = "addressbook"

    
    class func getInstance() -> SqliteOpertion {
        var instance:SqliteOpertion? = nil
        if(instance == nil){
            instance = SqliteOpertion()
        }
        return instance!
    }
    
    
//    创建数据库
    func createDataBase(){
        let sqlitepath = NSHomeDirectory().stringByAppendingString("/Documents/"+dbname+".db")
        print(sqlitepath)
        let state = sqlite3_open(sqlitepath, &db)
        
        if state == SQLITE_OK{
            print("数据库创建成功")
            createTable()
        }else{
            print("数据库创建失败")
        }
        
    }
    
//    创建数据表
    func createTable(){
        let createtable = "create table if not exists addressbook (id integer primary key autoincrement,name text,phone text)"
        
        let result = sqlite3_exec(db, createtable, nil, nil, nil)
        
        
        if result == SQLITE_OK {
            print("创建表成功")
        }
    }
    
//    插入
    func insertdata(name:String,phone:String){
        let insertsql = "insert into \(dbname)(name,phone) values(\"\(name)\",\"\(phone)\")"
        
        print(insertsql)
        
        
        if   sqlite3_exec(db, insertsql.cStringUsingEncoding(NSUTF8StringEncoding)!, nil, nil, nil) != SQLITE_OK {
            sqlite3_close(db)
            print("数据库插入失败")
        }

   
        

    }
    
    
    
//    删除数据
    
    func deletedata(phone:String){
        var statement:COpaquePointer = nil
        let deleterow = "delete from addressbook where phone="+"\'\(phone)\'"
        print(deleterow)
        sqlite3_prepare_v2(db, deleterow, -1, &statement, nil)
        sqlite3_step(statement)
        sqlite3_finalize(statement)
    }
    
    
//    查询
    
    func query()->NSMutableArray{
        var statement:COpaquePointer = nil
        
        
        let query = "select * from addressbook"
        
        var person:[UserAddress] = []
        
        
        //这条执行后，数据就已经在sattement中了
        sqlite3_prepare_v2(db, query.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &statement, nil)
        //游标往下走一步，如果返回SQLITE_ROW就进入
        while sqlite3_step(statement) == SQLITE_ROW{
            
            let newperson = UserAddress()
        
         let chars = UnsafePointer<CChar>(sqlite3_column_text(statement, 1))
            let name = String(CString: chars, encoding: NSUTF8StringEncoding)!
            
            let charsphone = UnsafePointer<CChar>(sqlite3_column_text(statement, 2))
            let phone = String(CString: charsphone, encoding: NSUTF8StringEncoding)!
            
            
           
            newperson.name = name
            newperson.phone = phone
            
            
            person.append(newperson)
            
            
            //            let name = NSString(UTF8String: id)
           
        }
        
        
        
        return (person as NSArray).mutableCopy() as! NSMutableArray

    }
    
//    删除表
    func removedatabase(){
        let removetable = "drop table "+dbname
        let result = sqlite3_exec(db, removetable, nil, nil, nil)
        
        if result == SQLITE_OK{
            print("删除表")
        }
    }
    
    
    
    
}

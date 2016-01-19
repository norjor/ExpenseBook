//
//  AppDelegate.swift
//  Kulukirja2
//
//  Created by Koulutus on 24/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        //print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        //print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //print("applicationDidBecomeActive")
        
        // set file path for saved expenses
        var filePath = documentsDirectory().stringByAppendingPathComponent("expenses.txt")
        
        // fetch former expenses from file
        if let retrieved = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [ExpenseClass] {
            
//            for index in 0..<retrieved.count {
//                let reco = String(format: "retrieved: %@  %6.2f  %@", arguments:[
//                    retrieved[index].date,
//                    retrieved[index].expenseValue,
//                    retrieved[index].expenseType
//                    ])
//                print(reco)
//            }
            
            MyGlobalVariables.myArrayOfExpenses = retrieved
        }
        else {
            print ("myArrayOfExpenses fetch failed or file didn't exist")
        }
        
        
        // fetch expense types from file expenseTypes.txt
        filePath = documentsDirectory().stringByAppendingPathComponent("expenseTypes.txt")
        
        if let types = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [String] {
            
            // if file is empty, some pre-defined types are used
            //if types.count > 0 {
                MyGlobalVariables.myTypes = types
            //}
            //print (types)
        }
        else {
            print ("myTypes fetch failed or file didn't exist")
        }
    }
    

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        //print("applicationWillTerminate")
        
        // set file path to save expenses
        var filePath = documentsDirectory().stringByAppendingPathComponent("expenses.txt")
        
        // save myArrayOfExpenses to file
        NSKeyedArchiver.archiveRootObject(MyGlobalVariables.myArrayOfExpenses, toFile: filePath)
        
        print("myArrayOfExpenses saved to file")
        
        // save myTypes to file
        filePath = documentsDirectory().stringByAppendingPathComponent("expenseTypes.txt")

        NSKeyedArchiver.archiveRootObject(MyGlobalVariables.myTypes, toFile: filePath)
        
        print("myTypes saved to file")
        
    }
    
    //
    // function for setting file path to DocumentDirectory
    //
    func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        
        return documentDirectory
    }

}


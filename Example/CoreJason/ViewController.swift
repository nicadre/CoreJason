//
//  ViewController.swift
//  CoreJason
//
//  Created by Nicolas Chevalier on 10/31/2016.
//  Copyright (c) 2016 Nicolas Chevalier. All rights reserved.
//

import UIKit
import CoreJason
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        let user: User = User(entity: User.entityDescription, insertInto: User.context)
//        let comment: Comment = Comment(entity: Comment.entityDescription, insertInto: Comment.context)

        let json: [String: AnyObject?] = [
            "full_name" : "Moi" as Optional<AnyObject>,
            "created_at": NSDate(),
            "comments" : [
                ["text": "lorem ipsum" as Optional<AnyObject>, "created_at": NSDate()],
                ["text": "lorem ipsum 2" as Optional<AnyObject>, "created_at": NSDate()]
            ] as Optional<AnyObject>
        ]

        User.json(object: json, toObject: user)

//        Comment.json(object: ["text": "lorem ipsum" as Optional<AnyObject>, "created_at": NSDate()], toObject: comment)
//        print(comment)
//        user.addToComments(comment)

//        print("\(user)")

    }

}

extension Comment: CoreJasonObject {

    public static var mapping: [String : String] {
        return [:]
    }

    public static var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }

    public static var entityDescription: NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Comment", in: Object.context)!
    }

    public typealias Object = Comment

}

extension User: CoreJasonObject {

    public static var mapping: [String : String] {
        return ["name":"full_name"]
    }

    public static var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }

    public static var entityDescription: NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "User", in: Object.context)!
    }

    public typealias Object = User

}

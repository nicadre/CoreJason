//
//  CoreJasonObject.swift
//  Pods
//
//  Created by Nicolas Chevalier on 31/10/16.
//
//

import Foundation
import CoreData

public protocol CoreJasonObject {

    associatedtype Object: NSManagedObject

    static var entityDescription: NSEntityDescription { get }
    static var context: NSManagedObjectContext { get }
    static var mapping: [String : String] { get }

}

public extension CoreJasonObject {

    public static func json(object jsonObject: [String: AnyObject?], toObject object: Object) {

        for (attributeName, attribute) in object.entity.attributesByName {
            if let jsonValue = jsonObject[mapping[attributeName] ?? attributeName.snakeCased()] {
                var value: AnyObject?
                if let className = attribute.attributeValueClassName {
                    switch className {
                    case "NSNumber":
                        value = jsonValue as? NSNumber
                    case "NSString":
                        value = jsonValue as? NSString
                    case "NSDate":
                        value = jsonValue as? NSDate
                    case "NSData":
                        value = jsonValue as? NSData
                    default:
                        break
                    }
                    if let value = value {
                        object.setValue(value, forKey: attributeName)
                    }
                }
            }
        }

//        for (relationShipName, relationShip) in object.entity.relationshipsByName {
//            print(jsonObject[relationShipName])
//            print(relationShip.destinationEntity)
//            print("\n\n\n\n")
//
//            let array: [Object] = json(array: jsonObject[relationShipName] as! [AnyObject], entity: relationShip.destinationEntity!)
//            var set = object.mutableSetValue(forKeyPath: relationShipName)
//            set.addObjects(from: array)
//            print(set)
//        }

    }

    public static func json(array jsonArray: [AnyObject], toArray array: [Object]) {

        jsonArray.enumerated().forEach { (offset: Int, jsonObject: AnyObject) in

            if let object = jsonObject as? [String : AnyObject?] {
                json(object: object, toObject: array[offset])
            }

        }

    }

    public static func fromJSON(array jsonArray: [AnyObject]) -> [Object] {

        var array: [Object] = []

        for _ in 0 ..< jsonArray.count {
            array.append(Object(entity: entityDescription, insertInto: context))
        }

        json(array: jsonArray, toArray: array)

        return array
        
    }

    public static func formJSON(object jsonObject: [String: AnyObject?]) -> Object {

        let object: Object = Object(entity: entityDescription, insertInto: context)

        json(object: jsonObject, toObject: object)

        return object

    }

}

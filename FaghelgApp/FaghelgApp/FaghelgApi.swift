import UIKit
import Alamofire
import CoreData
import BrightFutures

protocol FaghelgApiProtocol {
    func didRecieveResponse(results: NSDictionary)
}

class FaghelgApi : NSObject {
    var data: NSMutableData = NSMutableData()
    var delegate: FaghelgApiProtocol?
    
    //Ayhan push test
    func getProgram() {
        var jsonDict: NSDictionary?
        Alamofire.request(.GET, "http://faghelg.herokuapp.com/program")
            .responseJSON {(request, response, JSON, error) in
                // TODO: actually handle the response
                //println(request)
                //println(response)
                //println(JSON)
                //println(error)
                
                var error: NSError?
                jsonDict = JSON as? NSDictionary
                
                //let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
                
                //println(jsonDict!["numberOfEvents"])
                //println(jsonDict)
                
                
                
                var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
                
                var program = Program(entity: NSEntityDescription.entityForName("Program", inManagedObjectContext: managedObjectContext!)!, insertIntoManagedObjectContext: managedObjectContext)
                program.setData(jsonDict!)
                NSNotificationCenter.defaultCenter().postNotificationName(Notifications.programNotificationId, object: program)       }
    }
    
    // returns a promise of a list of employees
    func getEmployees() -> Future<[Person]> {
        let promise = Promise<[Person]>()
        Alamofire.request(.GET, "http://faghelg.herokuapp.com/persons")
            .responseJSON{(request, response, JSON, error) in
                
                // handle errors
                if error != nil {
                    promise.error(error!)
                    return
                }
                
                // success: convert from JSON object to list of persons
                var personsArr = JSON as NSArray
                var persons:[Person] = []
                for value in personsArr {
                    var jsonDict = value as NSDictionary
                    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
                    let person = Person(entity: NSEntityDescription.entityForName("Person", inManagedObjectContext: context)!, insertIntoManagedObjectContext: context)
                    person.setData(jsonDict)
                    persons.append(person)
                }
                promise.success(persons)
        }
        return promise.future
    }
}

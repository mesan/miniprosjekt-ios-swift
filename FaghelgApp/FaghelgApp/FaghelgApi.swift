import UIKit
import Alamofire
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
                
                
                
                NSNotificationCenter.defaultCenter().postNotificationName(Notifications.programNotificationId, object: Program(dict: jsonDict!))
        }
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
                    persons.append(Person(dict: jsonDict));
                }
                promise.success(persons)
        }
        return promise.future
    }
}

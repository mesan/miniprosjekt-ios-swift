import UIKit
import Alamofire

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
    
    // get a list of employees
    func getEmployees() {
        
        Alamofire.request(.GET, "http://faghelg.herokuapp.com/persons")
            .responseJSON{(request, response, JSON, error) in
                
                var error: NSError?
                var personsArr = JSON as NSArray
                
                var persons:[Person] = []
                for value in personsArr {
                    var jsonDict = value as NSDictionary
                    persons.append(Person(dict: jsonDict));
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(Notifications.employeesNotificationId, object: persons)
                
        }
    }
}

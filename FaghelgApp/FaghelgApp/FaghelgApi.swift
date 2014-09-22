import UIKit
import Alamofire
import CoreData

protocol FaghelgApiProtocol {
    func didRecieveResponse(results: NSDictionary)
}

class FaghelgApi : NSObject, NSFetchedResultsControllerDelegate{
    var data: NSMutableData = NSMutableData()
    var delegate: FaghelgApiProtocol?
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultController : NSFetchedResultsController = NSFetchedResultsController()
    var fetchedProgramController : NSFetchedResultsController = NSFetchedResultsController()
    var fetchedEventController : NSFetchedResultsController = NSFetchedResultsController()
    var fetchedPersonController : NSFetchedResultsController = NSFetchedResultsController()

    
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
                
                self.fetchedProgramController = self.getProgramResultsController()
                self.fetchedProgramController.delegate = self
                self.fetchedProgramController.performFetch(nil)
                
                if jsonDict == nil{

                    var fetchedProgram: Program? = self.fetchedProgramController.fetchedObjects?.first as? Program
                    NSNotificationCenter.defaultCenter().postNotificationName(Notifications.programNotificationId, object: fetchedProgram)
                    
                } else{
                    
                    var program = Program(entity: NSEntityDescription.entityForName("Program", inManagedObjectContext: managedObjectContext!)!, insertIntoManagedObjectContext: managedObjectContext)
                    program.setData(jsonDict!)
                    NSNotificationCenter.defaultCenter().postNotificationName(Notifications.programNotificationId, object: program)
                }
        }
    }
    
    
    func getProgramResultsController() -> NSFetchedResultsController{
        fetchedProgramController = NSFetchedResultsController(fetchRequest: programTaskRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedProgramController
    }
    
    func programTaskRequest() -> NSFetchRequest {
        let programRequest = NSFetchRequest(entityName: "Program")
        let sortDescriptor = NSSortDescriptor(key: "numberOfEvents", ascending: true)
        programRequest.sortDescriptors = [sortDescriptor]
        return programRequest
    }
    
    func getEventsResultsController() -> NSFetchedResultsController{
        fetchedEventController = NSFetchedResultsController(fetchRequest: eventsTaskRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedEventController
    }
    
    func eventsTaskRequest() -> NSFetchRequest {
        let eventRequest = NSFetchRequest(entityName: "Event")
        let sortDescriptor = NSSortDescriptor(key: "start", ascending: true)
        eventRequest.sortDescriptors = [sortDescriptor]
        return eventRequest
    }
    
    func getPersonResultsController() -> NSFetchedResultsController{
        fetchedPersonController = NSFetchedResultsController(fetchRequest: personTaskRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedPersonController
    }
    
    func personTaskRequest() -> NSFetchRequest {
        let personRequest = NSFetchRequest(entityName: "Person")
        let sortDescriptor = NSSortDescriptor(key: "shortName", ascending: true)
        personRequest.sortDescriptors = [sortDescriptor]
        return personRequest
    }
}

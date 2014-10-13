import UIKit
import Alamofire
import CoreData
import BrightFutures

protocol FaghelgApiProtocol {
    func didRecieveResponse(results: NSDictionary)
}

class FaghelgApi : NSObject, NSFetchedResultsControllerDelegate {
    
    let HOST = "http://faghelg.herokuapp.com";
    
    var data: NSMutableData = NSMutableData()
    var delegate: FaghelgApiProtocol?
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultController = NSFetchedResultsController()
    var fetchedProgramController = NSFetchedResultsController()
    var fetchedEventController = NSFetchedResultsController()
    var fetchedPersonController = NSFetchedResultsController()

    func getProgram() -> Future<Program?> {
        let promise = Promise<Program?>()
        Alamofire.request(.GET, HOST + "/program")
            .responseJSON {(request, response, JSON, error) in
                
                // handle errors
                if error != nil {
                    promise.error(error!)
                    return
                }
                
                let jsonDict: NSDictionary? = JSON as? NSDictionary

                var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
                
                self.fetchedProgramController = self.getProgramResultsController()
                self.fetchedProgramController.delegate = self
                self.fetchedProgramController.performFetch(nil)
                
                var program: Program?
                if jsonDict == nil {
                    program = self.fetchedProgramController.fetchedObjects?.first as? Program
                } else {
                    program = Program(entity: NSEntityDescription.entityForName("Program", inManagedObjectContext: managedObjectContext!)!, insertIntoManagedObjectContext: managedObjectContext)
                    program!.setData(jsonDict!)
                }
                
                promise.success(program)
        }
        
        return promise.future;
    }
    
    // returns a promise of a list of employees
    func getEmployees() -> Future<[Person]> {
        let promise = Promise<[Person]>()
        Alamofire.request(.GET, HOST + "/persons")
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

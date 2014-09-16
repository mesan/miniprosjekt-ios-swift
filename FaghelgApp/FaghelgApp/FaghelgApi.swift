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
        Alamofire.request(.GET, "http://faghelg.herokuapp.com/program")
            .responseJSON {(request, response, JSON, error) in
                // TODO: actually handle the response
                println(request)
                println(response)
                println(JSON)
                println(error)
        }
    }
    
    // get a list of employees
    func getEmployees() -> [String] {
        let employees: [String] = ["Patrick", "Dag", "Anders", "Ayhan", "Randi", "Kaja", "Gorm", "Señor Reed"]
        return employees
    }
}

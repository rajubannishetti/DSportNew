
import Foundation
import UIKit

class DsportsViewModel {
    var dSportValues = [Events]()
    weak var vc: DetailListViewController?
    weak var utility: CommonUtility?
    
    /*
     This method help us to getting the all list from the server
     */
    func getDSportDetails() {
        dSportValues.removeAll()
        
        DispatchQueue.main.async {
            self.vc?.activityIndicator.isHidden = false
            self.vc?.activityIndicator.startAnimating()
        }
        let params = ["client_id": "MjIyMTg2OTV8MTYyMzQ4MzQ4OS4yNzMwNzc3"]
        let urlComp = NSURLComponents(string: "https://api.seatgeek.com/2/events")!

            var items = [URLQueryItem]()

            for (key,value) in params {
                items.append(URLQueryItem(name: key, value: value))
            }

            items = items.filter{!$0.name.isEmpty}

            if !items.isEmpty {
              urlComp.queryItems = items
            }

            var urlRequest = URLRequest(url: urlComp.url!)
            urlRequest.httpMethod = "GET"
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            print("checking")
            if error == nil {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let res = try decoder.decode(DSportsData.self, from: data)
                        //print("Response data :\(res)")
                        if let resultVal = res.events {
                            self.dSportValues.append(contentsOf: resultVal)
                            
                            DispatchQueue.main.async {
                                self.vc?.detailTableView.reloadData()
                                self.vc?.activityIndicator.stopAnimating()
                                self.vc?.activityIndicator.isHidden = true
                            }
                            
                        }
                        //print("After result data is:\(self.dSportValues)")
                        
                    } catch DecodingError.keyNotFound(let key, let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                    } catch DecodingError.valueNotFound(let type, let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.typeMismatch(let type, let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.dataCorrupted(let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                    } catch let error as NSError {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    }
                }
            } else {
                CommonUtility.alertMessage(message: "Please try again Later", title: "Error")
            }
        }.resume()

    }
    
    func getSearchItem(searchText: String) {
        vc?.activityIndicator.isHidden = false
        dSportValues.removeAll()
        DispatchQueue.main.async {
            self.vc?.activityIndicator.startAnimating()
        }
        let params = ["client_id": "MjIyMTg2OTV8MTYyMzQ4MzQ4OS4yNzMwNzc3", "q": searchText]
        let urlComp = NSURLComponents(string: "https://api.seatgeek.com/2/events")!

            var items = [URLQueryItem]()

            for (key,value) in params {
                items.append(URLQueryItem(name: key, value: value))
            }

            items = items.filter{!$0.name.isEmpty}

            if !items.isEmpty {
              urlComp.queryItems = items
            }

            var urlRequest = URLRequest(url: urlComp.url!)
            urlRequest.httpMethod = "GET"
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            print("checking")
            if error == nil {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let res = try decoder.decode(DSportsData.self, from: data)
                        //print("Response data :\(res)")
                        if let resultVal = res.events {
                            self.dSportValues.append(contentsOf: resultVal)
                            
                            DispatchQueue.main.async {
                                self.vc?.detailTableView.reloadData()
                                self.vc?.activityIndicator.stopAnimating()
                                self.vc?.activityIndicator.isHidden = true
                            }
                            
                        }
                        //print("After result data is:\(self.dSportValues)")
                        
                    } catch DecodingError.keyNotFound(let key, let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                    } catch DecodingError.valueNotFound(let type, let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.typeMismatch(let type, let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.dataCorrupted(let context) {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                    } catch let error as NSError {
                        CommonUtility.alertMessage(message: "Parsing failed please try one more time", title: "Error")
                        NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    }
                }
            } else {
                CommonUtility.alertMessage(message: "Please try again Later", title: "Error")
            }
        }.resume()
    }
}

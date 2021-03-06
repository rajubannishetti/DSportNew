

import UIKit

class DetailListViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var detailTableView: UITableView!
    var dataModel = DsportsViewModel()
    
    @IBOutlet var searchField: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = .none
        searchField.delegate = self
        self.apiCall()
    }
    
    /* This method help us to call getdetailList.
     */
    func apiCall() {
        dataModel.getDSportDetails()
        dataModel.vc = self
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
    }
    
}

/*Table View delegate methods*/
extension DetailListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.dSportValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        print("Values ARe:\(dataModel.dSportValues[indexPath.row])")
        cell.dataModel = dataModel
        cell.indexVal = indexPath.row
        activityIndicator.startAnimating()
        cell.updateCOnfiguration()
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.dataModel = dataModel
        vc.dataIndex = indexPath.row
        self.present(vc, animated: false, completion: nil)
    }
    
}

extension DetailListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search Text is:\(searchText)")
        dataModel.getSearchItem(searchText: searchText)
    }
}

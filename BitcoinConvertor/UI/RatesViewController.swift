import UIKit

class RatesViewController: UIViewController {
  
  @IBOutlet weak var emptyView: UIView?
  @IBOutlet weak var tableView: UITableView?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
  
  fileprivate let ratesPresenter = RatesPresenter(rateService: RatesInteractor(service: NetworkService(),
                                                                               repository: Repository()))
  fileprivate var ratesToDisplay = [RateViewData]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView?.dataSource = self
    activityIndicator?.hidesWhenStopped = true
    
    ratesPresenter.attachView(self)
    ratesPresenter.fetchRates()
  }
  
}

extension RatesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ratesToDisplay.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "RateCell")
    let ratesViewData = ratesToDisplay[indexPath.row]
    cell.textLabel?.text = "€ \(ratesViewData.rate)"
    cell.detailTextLabel?.text = ratesViewData.date
    return cell
  }
}

extension RatesViewController: RateView {
  
  func startLoading() {
    activityIndicator?.startAnimating()
  }
  
  func finishLoading() {
    activityIndicator?.stopAnimating()
  }
  
  func setRates(_ rates: [RateViewData]) {
    ratesToDisplay = rates
    tableView?.reloadData()
  }
  
  func updateViewFor(emptyState: Bool) {
    tableView?.isHidden = emptyState
    emptyView?.isHidden = !emptyState
  }
  
}


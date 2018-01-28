
import Foundation

struct RateViewData{
  let rate: Double
  let date: String
}

protocol RateView: class {
  func startLoading()
  func finishLoading()
  func setRates(_ rates: [RateViewData])
  func updateViewFor(emptyState: Bool)
}

class RatesPresenter {
  fileprivate let rateService: RatesInteractorAdaptor!
  weak fileprivate var rateView : RateView?
  
  init(rateService:RatesInteractorAdaptor){
    self.rateService = rateService
  }
  
  func attachView(_ view:RateView){
    rateView = view
  }
  
  func detachView() {
    rateView = nil
  }
  
  func fetchRates() {
    self.rateView?.startLoading()
    
    rateService.getRates{ [weak self] (rates, error) in
      
      self?.rateView?.finishLoading()
      
      if let error = error {
        self?.rateView?.updateViewFor(emptyState: true)
        print("Opps! Something went wrong:\(error.localizedDescription)")
      }
      
      guard let rates = rates, rates.count > 0 else {
        self?.rateView?.updateViewFor(emptyState: true)
        return
      }
      let mappedTrends = rates.flatMap( {
        return RateViewData(rate: ($0.rate), date: "\($0.date)")
      })
      self?.rateView?.setRates(mappedTrends)
      self?.rateView?.updateViewFor(emptyState: false)
    }
  }
}

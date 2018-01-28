import Foundation

protocol RatesInteractorAdaptor {
  func getRates(_ callBack:@escaping ([Rate]?, Error?) -> Void)
}

struct RatesInteractor: NetworkRequest, RatesInteractorAdaptor {
  
  let service: NetworkAdaptor
  let repository: Repository
  
  func getRates(_ callBack: @escaping ([Rate]?, Error?) -> Void) {
    
    let uri = apiUri
    service.request(uri) { (response, error) in
      guard let response = response as? [String : Any],
        let rates = self.parse(response: response) else {
          callBack(nil, error)
          return
      }
      self.repository.save(rates: rates)
      DispatchQueue.main.async {
        callBack(self.repository.rates, error)
      }
    }
  }
  
  func parse(response: [String : Any]?) -> [Rate]? {
    guard let info = response?["bpi"] as? [String : Double] else {
      return nil
    }
    return info.flatMap( {Rate( date: $0.key, rate: $0.value)})
  }
}

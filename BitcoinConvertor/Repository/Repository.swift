import Foundation

protocol RepositoryAdaptor {
  
  var rates: [Rate]? { get set }
  func save(rates: [Rate]?)
}

class Repository {
  
  var rates: [Rate]?
  
  func save(rates: [Rate]?) {
    self.rates = rates
  }
}

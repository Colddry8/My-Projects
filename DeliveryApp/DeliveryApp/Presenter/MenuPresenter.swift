//
//  MainPresenter.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 13/1/2567 BE.
//

import Foundation

protocol MenuViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MenuViewPresenterProtocol  : AnyObject {
    init(view: MenuViewProtocol, networkService: NetworkServiceProtocol)
    func getPizzas()
    var pizzas: [Pizza]? { get set }
}

class MenuPresenter: MenuViewPresenterProtocol {
    weak var view: MenuViewProtocol?
    let networkService: NetworkServiceProtocol!
    var pizzas: [Pizza]?
    
    required init(view: MenuViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getPizzas()
    }
    
    func getPizzas() {
        networkService.getPizzas { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let pizzas):
                    self.pizzas = pizzas
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

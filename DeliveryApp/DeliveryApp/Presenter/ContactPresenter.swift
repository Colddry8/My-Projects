//
//  ContactPresenter.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 14/1/2567 BE.
//

import UIKit

protocol ContactViewProtocol: AnyObject {
}

protocol ContactPresenterProtocol {
    init(view: ContactViewProtocol)
}

class ContactPresenter {
    weak var view: ContactViewProtocol?
    required init(view: ContactViewProtocol) {
        self.view = view
    }
}

extension ContactPresenter: ContactPresenterProtocol {
    
}

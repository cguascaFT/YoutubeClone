//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by Cesar Guasca on 18/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var presenter = HomePresenter(delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await presenter.getHomeObjects()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    func getData(list: [[Any]]) {
        print("list", list)
    }
}

//
//  MenuView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/29/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class MenuView:UIViewController {
//    fileprivate lazy var rootFlexContainer:UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        self.view.addSubview(view)
//        return view
//    }()
    
    enum ExampleTypes {
        case PinLayout
        case SnapKit
    }
    
    private let examples:[ExampleTypes] = [.PinLayout, .SnapKit]
    
    fileprivate lazy var menuTable:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.REUSE_ID)
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuTable.pin.top().left().right().bottom()
    }
}

extension MenuView:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuCell = tableView.dequeueReusableCell(withIdentifier: MenuCell.REUSE_ID, for: indexPath) as? MenuCell else {return UITableViewCell()}
        let example = examples[indexPath.row]
        switch example {
        case .PinLayout:
            menuCell.configure(with: "Pin layout example Pin layout example Pin layout example Pin layout example Pin layout example Pin layout example Pin layout example Pin layout example Pin layout example Pin layout example ")
        case .SnapKit:
            menuCell.configure(with: "SnapKit Example")
        }
        return menuCell
    }
}

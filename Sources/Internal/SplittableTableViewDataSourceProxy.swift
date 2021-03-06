//
//  SplittableTableViewDataSourceProxy.swift
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/22.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import UIKit

protocol _SplittableTableViewDataSource: AnyObject {
    func proxy(tableView: UITableView, cellForRowAt indexPath: IndexPath, cell: UITableViewCell) -> UITableViewCell
}

final class SplittableTableViewDataSourceProxy: _NSObjectProxy, SplittableTableViewDataSource {

    var dataSource: SplittableTableViewDataSource? {
        set {
            _object = newValue
        }
        get {
            return _object as? SplittableTableViewDataSource
        }
    }

    private weak var proxy: _SplittableTableViewDataSource?

    init(proxy: _SplittableTableViewDataSource) {
        self.proxy = proxy
    }

    func splittableContainerViewFor(topView: UIView, layoutType: LayoutType) -> UIView{
        return dataSource?.splittableContainerViewFor(topView: topView, layoutType: layoutType) ?? Undefined.object()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataSource?.tableView(tableView, cellForRowAt: indexPath) ?? Undefined.object()
        return proxy?.proxy(tableView: tableView, cellForRowAt: indexPath, cell: cell) ?? Undefined.object()
    }
}

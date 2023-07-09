//
//  UITableView+.swift
//  
//
//  Created by Eddy on 2023/06/08.
//

import UIKit

public extension UITableView {

    /// UITableViewHeaderFooterView 등록
    /// - Parameters:
    ///   - type: 등록할 header, footer 클래스 (예: MyHealthCareAndRoutineTableViewHeader.self)
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        let headerFooterID = String(describing: type)
        self.register(type, forHeaderFooterViewReuseIdentifier: headerFooterID)
    }

    /// UITableViewCell 등록
    /// - Parameters:
    ///   - type: 등록할 cell 클래스 (예: MyHealthCareTableViewCell.self)
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        let cellID = String(describing: type)
        self.register(type, forCellReuseIdentifier: cellID)
    }

    /// header, footer 재사용
    /// - Parameter type: 사용할 header, footer 클래스(입력한 클래스 이름으로 identifier 만듦)
    /// - Returns: UITableViewHeaderFooterView?
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
        let identifier = String(describing: type)
        guard let v = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("identifier: \(String(describing: type)) can not dequeue header, footer cell")
        }

        return v
    }

    /// cell 재사용
    /// - Parameters:
    ///   - type: 사용할 cell 클래스(입력한 클래스 이름으로 identifier 만듦)
    ///   - indexPath: cell의 indexPath
    /// - Returns: UITableViewCell?
    func dequeueCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("identifier: \(String(describing: type)) can not dequeue cell")
        }

        return cell
    }
}


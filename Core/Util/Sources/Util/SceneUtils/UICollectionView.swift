//
//  UICollectionView.swift
//  
//
//  Created by Eddy on 2023/06/08.
//

import UIKit

public extension UICollectionView {

    /// UICollectionView header 등록
    /// - Parameters:
    ///   - type: 등록할 UICollectionReusableView 클래스 (예: UserHealthInfoCollectionViewHeader.self)
    func registerHeader<T: UICollectionReusableView>(_ type: T.Type) {
        let supplementaryViewID = String(describing: type)
        self.register(
            type,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: supplementaryViewID
        )
    }

    /// UICollectionView footer 등록
    /// - Parameters:
    ///   - type: 등록할 UICollectionReusableView 클래스 (예: UserHealthInfoCollectionViewHeader.self)
    func registerFooter<T: UICollectionReusableView>(_ type: T.Type) {
        let supplementaryViewID = String(describing: type)
        self.register(
            type,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: supplementaryViewID
        )
    }

    /// UICollectionViewCell 등록
    /// - Parameter type: 등록할 UICollectionViewCell 클래스 (예: UserHealthInfoCollectionViewCell.self)
    func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        let cellID = String(describing: type)
        self.register(type, forCellWithReuseIdentifier: cellID)
    }

    /// UICollectionView header 재사용
    /// - Parameters:
    ///   - type: 사용할 UICollectionReusableView 클래스(입력한 클래스 이름으로 identifier 만듦)
    ///   - indexPath: header or footer의 indexPath
    /// - Returns: UICollectionReusableView?
    func dequeueHeader<T: UICollectionReusableView>(
        type: T.Type,
        indexPath: IndexPath
    ) -> T {
        guard let header = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier:
                type.identifier,
            for: indexPath
        ) as? T else {
            fatalError("identifier: \(String(describing: type)) can not dequeue header cell")
        }

        return header
    }

    /// UICollectionView footer 재사용
    /// - Parameters:
    ///   - type: 사용할 UICollectionReusableView 클래스(입력한 클래스 이름으로 identifier 만듦)
    ///   - indexPath: header or footer의 indexPath
    /// - Returns: UICollectionReusableView?
    func dequeueFooter<T: UICollectionReusableView>(
        type: T.Type,
        indexPath: IndexPath
    ) -> T {
        guard let footer = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier:
                type.identifier,
            for: indexPath
        ) as? T else {
            fatalError("identifier: \(String(describing: type)) can not dequeue footer cell")
        }

        return footer
    }

    /// UICollectionViewCell 재사용
    /// - Parameters:
    ///   - type: 사용할 UICollectionViewCell 클래스(입력한 클래스 이름으로 identifier 만듦)
    ///   - indexPath: cell의 indexPath
    /// - Returns: UICollectionViewCell?
    func dequeueCell<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: type)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("identifier: \(String(describing: type)) can not dequeue cell")
        }

        return cell
    }
}


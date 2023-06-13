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
    ///   - supplementaryViewClass: 등록할 UICollectionReusableView 클래스 (예: UserHealthInfoCollectionViewHeader.self)
    func registerHeader(_ supplementaryViewClass: UICollectionReusableView.Type) {
        let supplementaryViewID = String(describing: supplementaryViewClass)
        self.register(
            supplementaryViewClass,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: supplementaryViewID
        )
    }

    /// UICollectionView footer 등록
    /// - Parameters:
    ///   - supplementaryViewClass: 등록할 UICollectionReusableView 클래스 (예: UserHealthInfoCollectionViewHeader.self)
    func registerFooter(_ supplementaryViewClass: UICollectionReusableView.Type) {
        let supplementaryViewID = String(describing: supplementaryViewClass)
        self.register(
            supplementaryViewClass,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: supplementaryViewID
        )
    }

    /// UICollectionViewCell 등록
    /// - Parameter cellClass: 등록할 UICollectionViewCell 클래스 (예: UserHealthInfoCollectionViewCell.self)
    func registerCell(_ cellClass: UICollectionViewCell.Type) {
        let cellID = String(describing: cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: cellID)
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
            fatalError("잘못된 header입니다.")
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
            fatalError("잘못된 footer입니다.")
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
            fatalError("잘못된 cell입니다.")
        }

        return cell
    }
}


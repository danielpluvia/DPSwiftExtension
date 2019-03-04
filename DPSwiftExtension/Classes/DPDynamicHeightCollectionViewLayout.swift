//
//  DPDynamicHeightCollectionViewLayout.swift
//  Feed
//
//  Created by Xueqiang Ma on 26/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

open class DPDynamicHeightCollectionViewLayout: UICollectionViewLayout {
    open var numberOfColumns: Int = 2   // total columns in a row
    open var interItemSpacing: CGFloat = 10
    open var contentInsets: UIEdgeInsets = .zero {
        didSet {
            collectionView?.contentInset = contentInsets
        }
    }
    
    fileprivate var layoutMap = [IndexPath: UICollectionViewLayoutAttributes]() // cache
    fileprivate var columnsXOffsets: [CGFloat] = []
    fileprivate var columnsYOffsets: [CGFloat] = []  // contains max yOffset for each column
    fileprivate var contentSize: CGSize = .zero
    open override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    // MARK: Abstract Methods
    func columnIndexForItem(at indexPath: IndexPath) -> Int {
        return indexPath.item % numberOfColumns
    }
    
    func calculateItemSize() {
        
    }
}

// MARK: - Override Methods
extension DPDynamicHeightCollectionViewLayout {
    open override func prepare() {
        guard let collectionView = collectionView else { return }
        let sectionIndex = 0
        let totalItems = collectionView.numberOfItems(inSection: sectionIndex)
        guard numberOfColumns > 0, totalItems > 0 else { return }
        // Reset
        layoutMap.removeAll()
        columnsXOffsets = []
        columnsYOffsets = Array(repeating: contentInsets.top, count: numberOfColumns)
        
        // xOffsets
        let contentWidthWithoutIndents = collectionView.bounds.width - contentInsets.left - contentInsets.right
        let totalInterSpacing = interItemSpacing * (CGFloat(numberOfColumns) - 1)
        let itemWidth = (contentWidthWithoutIndents - totalInterSpacing) / CGFloat(numberOfColumns)
        columnsXOffsets = []
        for columnIndex in 0..<numberOfColumns {
            columnsXOffsets.append(CGFloat(columnIndex) * (itemWidth + interItemSpacing) + contentInsets.left)
        }
        
        // yOffsets & layoutMap
        var maxHeight: CGFloat = 0
        for itemIndex in 0..<totalItems {
            let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
            let columnIndex = columnIndexForItem(at: indexPath)
            let attributeFrame = CGRect(x: columnsXOffsets[columnIndex],
                                        y: columnsYOffsets[columnIndex],
                                        width: itemWidth, height: itemWidth * CGFloat.random(in: 1.5..<1.9))
            let targetLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            targetLayoutAttributes.frame = attributeFrame
            maxHeight = max(attributeFrame.maxY, maxHeight)
            columnsYOffsets[columnIndex] = attributeFrame.maxY + interItemSpacing
            layoutMap[indexPath] = targetLayoutAttributes
        }
        contentSize = CGSize(width: collectionView.bounds.size.width - contentInsets.left - contentInsets.right, height: maxHeight + contentInsets.top + contentInsets.bottom)
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributesArray: [UICollectionViewLayoutAttributes] = []
        for (_, layoutAttributes) in layoutMap {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        return layoutAttributesArray
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutMap[indexPath]
    }
}

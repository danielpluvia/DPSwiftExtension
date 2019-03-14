//
//  DPDynamicHeightCollectionViewLayout.swift
//  Feed
//
//  Created by Xueqiang Ma on 26/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//
//  Inspired by: https://www.raywenderlich.com/392-uicollectionview-custom-layout-tutorial-pinterest
//

import UIKit

extension DPDynamicHeightCollectionViewLayout {
    open func resetLayout() {
        layoutMap.removeAll()
        prepare()
    }
}

open class DPDynamicHeightCollectionViewLayout: UICollectionViewLayout {
    open var numberOfColumns: Int = 2   // total columns in a row
    open var interItemSpacing: CGSize = CGSize(width: 10, height: 10)
    
    fileprivate var layoutMap = [IndexPath: UICollectionViewLayoutAttributes]() // This is an array to cache the calculated attributes. When you call prepare(), you’ll calculate the attributes for all items and add them to the cache. When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
    fileprivate var columnsXOffsets: [CGFloat] = []
    fileprivate var columnsYOffsets: [CGFloat] = []  // contains max yOffset for each column
    fileprivate var contentSize: CGSize = .zero
    
    // MARK: Abstract Methods
    func columnIndexForItem(at indexPath: IndexPath) -> Int {
        return indexPath.item % numberOfColumns
    }
}

// MARK: - Override Methods
extension DPDynamicHeightCollectionViewLayout {
    // This variable returns the width and height of the collection view’s contents. You must override it. Then return the height and width of the entire collection view’s content — not just the visible content. The collection view uses this information internally to configure its scroll view’s content size.
    open override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    // This method is called whenever a layout operation is about to take place. It’s your opportunity to prepare and perform any calculations required to determine the collection view’s size and the positions of the items.
    open override func prepare() {
        guard layoutMap.isEmpty == true, let collectionView = collectionView else { return }
        let sectionIndex = 0
        let totalItems = collectionView.numberOfItems(inSection: sectionIndex)
        guard numberOfColumns > 0, totalItems > 0 else { return }
        // Reset
        layoutMap.removeAll()
        columnsXOffsets = []
        columnsYOffsets = Array(repeating: 0, count: numberOfColumns)
        
        // xOffsets
        let contentWidthWithoutIndents = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let totalInterWidthSpacing = interItemSpacing.width * (CGFloat(numberOfColumns) - 1)
        let itemWidth = (contentWidthWithoutIndents - totalInterWidthSpacing) / CGFloat(numberOfColumns)
        print(contentWidthWithoutIndents, totalInterWidthSpacing, itemWidth)
        
        for columnIndex in 0..<numberOfColumns {
            columnsXOffsets.append(CGFloat(columnIndex) * (itemWidth + interItemSpacing.width))
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
            columnsYOffsets[columnIndex] = attributeFrame.maxY + interItemSpacing.height
            layoutMap[indexPath] = targetLayoutAttributes
        }
        contentSize = CGSize(
            width: contentWidthWithoutIndents,
            height: maxHeight + collectionView.contentInset.top + collectionView.contentInset.bottom)
    }
    
    // In this method you need to return the layout attributes for all the items inside the given rectangle. You return the attributes to the collection view as an array of UICollectionViewLayoutAttributes.
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributesArray: [UICollectionViewLayoutAttributes] = []
        for (_, layoutAttributes) in layoutMap {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        return layoutAttributesArray
    }
    
    // This method provides on demand layout information to the collection view. You need to override it and return the layout attributes for the item at the requested indexPath.
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutMap[indexPath]
    }
}

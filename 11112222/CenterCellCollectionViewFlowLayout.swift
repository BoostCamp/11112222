//
//  CenterCellCollectionViewFlowLayout.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 12..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        print("start=====================================================================")
//        print("velocity: \(velocity)")
        if let cv = self.collectionView {
            let cvBounds = cv.bounds
//            print("cvBounds: \(cvBounds.size.width)")
            let halfWidth = cvBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
//            print("proposedContentOffset: \(proposedContentOffset.x)  halfWidth: \(halfWidth)")
            
//            print("proposedContentOffsetCenterX: \(proposedContentOffsetCenterX)")

            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    // == Skip comparison with non-cell items (headers and footers) == //
//                    print("==========attribute 속성============") // 각각의 셀
//                    print("attribute.center.x \(attributes.center.x)")
//                    print("cv.contentOffset.x \(cv.contentOffset.x)")
//                    print("halfWidth \(halfWidth)")

                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
//                    if (attributes.center.x == 0) || (attributes.center.x > (cv.contentOffset.x + halfWidth) && velocity.x < 0) {
//                        print("right -> left")
//                        continue
//                    }
                    
                    // == First time in the loop == //
                    guard let candAttrs = candidateAttributes else {
//                        print("== First time in the loop ==")
                        candidateAttributes = attributes
                        continue
                    }
                    
                    let a = attributes.center.x - proposedContentOffsetCenterX // 내가 가야할 content cell의 center - 예상된
                    let b = candAttrs.center.x - proposedContentOffsetCenterX // 제공된 center x - 그 예상된 x
//                    print("a : \(a)  b: \(b)")
                    if fabsf(Float(a)) < fabsf(Float(b)) {
//                        print("if문 들어감")
                        candidateAttributes = attributes;
                    }
//                    else if fabsf(Float(a)) > fabsf(Float(b)) && velocity.x < -.5 {
//                        print("if문 들어감2")
//
//                        candidateAttributes = attributes;
//
//                    }

//                    print("candidateAttribute : \(candidateAttributes?.center.x)")
                    
//                    print("============the end of for문===============")
                }
                
                
                // Beautification step , I don't know why it works!
                if(proposedContentOffset.x == -(cv.contentInset.left)) && velocity.x < -4.5 {
//                    print("proposedContentOffset.x : \(proposedContentOffset.x)  cv.contentInset.left: \(-(cv.contentInset.left))")
//                    print("1=====================================================================")

                    return proposedContentOffset
                }
//                print("2=====================================================================")
                
//                print("return x : \(floor(candidateAttributes!.center.x - halfWidth))")

                return CGPoint(x: floor(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)

            }
        }
//        print("3=====================================================================")

        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)

    }
    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attr = super.layoutAttributesForItem(at: indexPath)
//        let cellFrame = CGRect.init(origin: (attr?.center)!, size: CGSize.init(width: (attr?.frame.size.width)! * 1.2, height: (attr?.frame.size.height)! * 1.2))
//        
//        attr?.frame = cellFrame
//        
//        return attr
//    }
    
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        return super.layoutAttributesForElements(in: rect)
//    }
    
}

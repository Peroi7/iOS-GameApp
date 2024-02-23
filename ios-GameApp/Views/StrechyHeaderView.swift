//
//  StrechyHeaderView.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 22/02/2024.
//

import Foundation
import PureLayout
import SDWebImage

//MARK: - StretchyImageView

class StrechyHeaderView: UIView {
    
    var imageView: UIImageView!
    private var containerView: UIView!
    private var imageViewHeight: NSLayoutConstraint!
    private var imageViewBottom: NSLayoutConstraint!
    private var scrollView: UIScrollView!
    private var containerViewHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: - Setup
    
    private func setup() {
        containerView = UIView()
        addSubview(containerView)
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        autoMatch(.width, to: .width, of: containerView)
        autoAlignAxis(.horizontal, toSameAxisOf: containerView)
        autoMatch(.height, to: .height, of: containerView)
        containerView.autoMatch(.width, to: .width, of: imageView)
        containerViewHeight = containerView.autoMatch(.height, to: .height, of: self)
        imageViewBottom = imageView.autoPinEdge(.bottom, to: .bottom, of: containerView)
        imageViewHeight = imageView.autoMatch(.height, to: .height, of: containerView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY, scrollView.contentInset.top)
    }
}

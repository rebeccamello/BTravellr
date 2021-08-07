//
//  FullImageCell.swift
//  BTravellr
//
//  Created by Rebecca Mello on 30/07/21.
//

import UIKit

class FullImageCell: UICollectionViewCell, UIScrollViewDelegate{
    
    var scrollImg: UIScrollView!
    var imgView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(zoomTap(recognizer: )))
        doubleTap.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTap)
        
        self.addSubview(scrollImg)
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "collectionBg")
        scrollImg.addSubview(imgView!)
        imgView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func zoomTap(recognizer: UITapGestureRecognizer){
        if scrollImg.zoomScale == 1{
            scrollImg.zoom(to: zoomRect(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else{
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect{
        var zoomRect = CGRect.zero
        zoomRect.size.height = imgView.frame.size.height/scale
        zoomRect.size.width = imgView.frame.size.width/scale
        let newCenter = imgView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width/2)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height/2)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{
        return self.imgView
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollImg.frame = self.bounds
        imgView.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollImg.setZoomScale(1, animated: true)
    }
}

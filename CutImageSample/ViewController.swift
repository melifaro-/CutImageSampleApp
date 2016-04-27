import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectionView: DrawingSelectionAreaView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectionView.callback = { (points) in
            
            let path = UIBezierPath()
            
            for point in points {
                
                if points.first == point {
                    
                    path.moveToPoint(point)
                    
                } else {
                    
                    path.addLineToPoint(point)
                    
                }
            }
            
            path.closePath()
            
            let layer = CAShapeLayer()
            layer.path = path.CGPath
            
            self.imageView.layer.mask = layer
            
            UIGraphicsBeginImageContext(self.imageView.bounds.size)
            
            self.imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            let croppedCGImage =  CGImageCreateWithImageInRect(image.CGImage!, CGPathGetPathBoundingBox(path.CGPath));

            let croppedImage = UIImage(CGImage: croppedCGImage!)
        
            self.imageView.image = croppedImage
            
            self.imageView.layer.mask = nil
            
        }
        
    }

}


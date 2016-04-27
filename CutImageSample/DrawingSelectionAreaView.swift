import UIKit


class DrawingSelectionAreaView: UIView, UIAlertViewDelegate {
    
    var lastPoint: CGPoint = CGPointZero
    var points = [CGPoint]()
    var curves = [[CGPoint]]()
    var plusPath: UIBezierPath!
    
    var isSelectionFinished = false
    
    var callback: ((points: [CGPoint]) -> Void)?
    
    override func drawRect(rect: CGRect) {
        
        let path = drawPath(points)

        path.stroke()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        points = [CGPoint]()
        
        if let touch = touches.first {
            lastPoint = touch.locationInView(self)
            points.append(lastPoint)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let newPoint = touch.locationInView(self)
            points.append(newPoint)
            
            lastPoint = newPoint
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let alert = UIAlertView.init(title: "Is it ok?", message: "", delegate: self, cancelButtonTitle: "Again", otherButtonTitles: "Ok")
        alert.show()
    }
    
    func drawPath(curve: [CGPoint]) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        UIColor.greenColor().setStroke()
        UIColor.redColor().setFill()
        
        path.lineWidth = 10.0
        
        if curve.count > 0 {
            path.moveToPoint(curve.first!)
            for point in curve {
                path.addLineToPoint(point)
            }
        }
        
        return path
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if alertView.cancelButtonIndex != buttonIndex {
        
            callback?(points: points)

        }
        points = [CGPoint]()
        setNeedsDisplay()
    }
}
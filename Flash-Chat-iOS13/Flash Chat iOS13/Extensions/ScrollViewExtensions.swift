import Foundation
import UIKit

extension UIScrollView{
    func scrollToBottom(){
        if self.contentSize.height < self.bounds.size.height { return }
             let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
             self.setContentOffset(bottomOffset, animated: true)
    }
}

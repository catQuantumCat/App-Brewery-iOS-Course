import Foundation


struct News : Identifiable, Hashable{
    let id: String
    let title: String
    let url: URL?
    let points : Int
    
    
    init(id: String, title: String, url: String?, points: Int) {
        
        self.id = id
        self.title = title
        self.url = url != nil ? URL(string: url!) : nil
        self.points = points
    }
}

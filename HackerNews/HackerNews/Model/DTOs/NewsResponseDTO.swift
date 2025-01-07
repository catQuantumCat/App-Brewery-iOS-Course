import Foundation

struct NewsResponseDTO : Decodable{
    let hits: [NewsDTO]
    
    func toModel() -> [News]{
        
        hits.map { rawNews in
            News(id: rawNews.objectID, title: rawNews.title, url: rawNews.url, points: rawNews.points)
        }
    }
}

struct NewsDTO : Decodable{
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}



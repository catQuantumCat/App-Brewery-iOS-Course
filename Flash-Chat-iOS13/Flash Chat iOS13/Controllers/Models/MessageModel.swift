import Foundation

struct MessageModel
{
    let sender: String
    let body: String
}

extension MessageModel{
    static func toOneMessage(from data: [String: Any]) -> MessageModel?{

        guard let sender = data[Constants.FStore.senderField] as? String,
              let body = data[Constants.FStore.bodyField] as? String else {
            return nil
        }
        
        return MessageModel(sender: sender, body: body)
    }
    
    static func toListMessage(from dataList: [[String: Any]?]) -> [MessageModel]{
        
        var toReturn: [MessageModel] = []
        
        for data in dataList{
            guard let data else {
                continue
                
            }
            guard let tmp = toOneMessage(from: data) else{
                continue
            }
            
            toReturn.append(tmp)
        }
        return toReturn;
    }

}

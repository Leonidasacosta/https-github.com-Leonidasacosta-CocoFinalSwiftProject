//
//  Childs.swift
//  Coco
//
//  Created by Leonidas Acosta on 12/1/21.
//

import Foundation
import Firebase
import FirebaseAuth

class Childs{
    var childArray: [Children] = []
    func loadData(completed: @escaping ()->() ) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("childs").appendingPathExtension("json")

        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            childArray = try jsonDecoder.decode(Array<Children>.self, from: data)
        } catch {
            print("😡 ERROR: Could not load data \(error.localizedDescription)")
        }
        completed()
    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("childs").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(childArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
}

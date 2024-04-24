//
//  BaseViewController.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 24.04.2024.
//

import UIKit
import FirebaseDatabase

class BaseViewController: UIViewController {
    
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func addNewEntryInFirebase(productId: String, count: Int) {
        database.child("products").child(productId).setValue(count)
    }
    
    func fetchDataToFirebase() {
        database.child("products").observeSingleEvent(of: .value) { snapshot in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                print(rest)
            }
        }
    }
    
    func removeData(id: String) {
        let ref = database.database.reference().child("products").child(id)
        ref.removeValue()
    }
    
    func removeAllData() {
        database.child("products").removeValue()
    }
}

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}

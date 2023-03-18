//
//  FirebaseReference.swift
//  GroupNote
//
//  Created by Noah Cordova on 3/18/23.
//

import Firebase

enum FCollectionReference: String {
    case Game
    
}



func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}

//
//  WalksFirestore.swift
//  sai
//
//  Created by Николай Попов on 22.08.2023.
//

import FirebaseFirestoreSwift
import FirebaseFirestore


class WalksFirestore: WalksDaoProtocol {
    let db = Firestore.firestore()
    
    func get(by id: String) async throws -> Walk {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Walk, Error>) -> Void in
            db.collection(collection).document(id).getDocument { (document, error) in
                if let error = error {
                    continuation.resume(throwing: DaoError.notFound)
                } else {
                    do {
                        let walk = try document!.data(as: Walk.self)
                        continuation.resume(returning: walk)
                    }
                    catch {
                        continuation.resume(throwing: DaoError.somethingWrong)
                    }
                }
            }
        })
    }
    
    func get(from fromDate: Date, to toDate: Date) async throws -> [Walk] {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[Walk], Error>) -> Void in
            db.collection(collection).whereField("startedAt", isLessThan: toDate).whereField("finishedAt", isGreaterThan: fromDate).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    continuation.resume(throwing: DaoError.somethingWrong)
                } else {
                    var walks: [Walk] = []
                    for document in querySnapshot!.documents {
                        do {
                            let walk = try document.data(as: Walk.self)
                            walks.append(walk)
                        }
                        catch {
                            continuation.resume(throwing: DaoError.somethingWrong)
                        }
                    }
                    continuation.resume(returning: walks)
                }
            }
        })
    }
    
    func save(_ walk: Walk) async throws -> Walk {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Walk, Error>) -> Void in
            if let result = try? db.collection(collection).addDocument(from: walk) {
                continuation.resume(returning: walk)
            } else {
                continuation.resume(throwing: DaoError.somethingWrong)
            }
        })
    }
    
    func delete(_ walk: Walk) async throws {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Void, Error>) -> Void in
            db.collection(collection).document(walk.id!).delete() { err in
                if let err = err {
                    continuation.resume(throwing: DaoError.somethingWrong)
                } else {
                    print("Document successfully removed!")
                }
            }
        })
    }
    
    func getAll() async throws -> [Walk] {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<[Walk], Error>) -> Void in
            db.collection(collection).whereField("user", isEqualTo: "default").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    continuation.resume(throwing: DaoError.somethingWrong)
                } else {
                    var walks: [Walk] = []
                    for document in querySnapshot!.documents {
                        do {
                            let walk = try document.data(as: Walk.self)
                            walks.append(walk)
                        }
                        catch {
                            continuation.resume(throwing: DaoError.somethingWrong)
                        }
                    }
                    continuation.resume(returning: walks)
                }
            }
        })
    }
    
    let collection = "walks"
    
    private init() {}
    static let shared = WalksFirestore()
}

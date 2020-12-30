//
//  SparseMatrix.swift
//  
//
//  Created by Stefan Jaindl on 23.12.20.
//

import Foundation

open class SparseMatrix {
    
    public init() { }
    
    open func similarity(of documents: [SparseDocument]) -> [Similarity] {
        guard !documents.isEmpty else {
            return []
        }
        
        //map from words to documents:
        let mapping = buildIntToDocumentMapping(documents: documents)
        
        //intersection count for each document pair:
        let intersections = intersectionCounts(of: mapping)
        
        //calculate union and intersection counts of documents where an intersection exists
        let documentDict = buildDocumentIdDict(documents: documents)
        
        return calculateSimilarities(documentDict: documentDict, intersectionCounts: intersections)
    }
    
    private func intersectionCounts(of mapping: [Int: [DocumentId]]) -> [DocumentPair: Int] {
        var counts = [DocumentPair: Int]()
        
        for documents in mapping.values {
            for (index, firstDoc) in documents.enumerated() {
                var secondIndex = index + 1
                while secondIndex < documents.count {
                    let pair = DocumentPair(firstId: firstDoc, secondId: documents[secondIndex])
                    
                    if let count = counts[pair] {
                        counts[pair] = count + 1
                    } else {
                        counts[pair] = 1
                    }
                    
                    secondIndex += 1
                }
            }
        }
        
        return counts
    }
    
    private func buildIntToDocumentMapping(documents: [SparseDocument]) -> [Int: [DocumentId]] {
        var mapping = [Int: [Int]]() //dict from word to docId's
        
        for document in documents {
            for word in document.words {
                if var docs = mapping[word] {
                    docs.append(document.id)
                    mapping[word] = docs
                } else {
                    let docs = [document.id]
                    mapping[word] = docs
                }
            }
        }
        
        return mapping
    }
    
    private func buildDocumentIdDict(documents: [SparseDocument]) -> [DocumentId: SparseDocument] {
        var documentDict = [DocumentId: SparseDocument]()
        
        for document in documents {
            documentDict[document.id] = document
        }
        
        return documentDict
    }
    
    private func calculateSimilarities(documentDict: [DocumentId: SparseDocument], intersectionCounts: [DocumentPair: Int]) -> [Similarity] {
        var similarities = [Similarity]()
        
        for (documentPair, intersectionCount) in intersectionCounts {
            guard let firstTotal = documentDict[documentPair.firstId]?.words.count,
                  let secondTotal = documentDict[documentPair.secondId]?.words.count else {
                continue
            }
            
            let totalCount = firstTotal + secondTotal
            let unionCount = totalCount - intersectionCount //intersection counted twice
            let similarity = Similarity(documents: documentPair, similarity: Double(Double(intersectionCount) / Double(unionCount)))
            
            similarities.append(similarity)
        }
        
        return similarities
    }
}

public struct SparseDocument {
    let id: DocumentId
    let words: [Int]
}

public struct Similarity: Equatable {
    let documents: DocumentPair
    let similarity: Double
    
    public static func == (lhs: Similarity, rhs: Similarity) -> Bool {
        return lhs.documents.firstId == rhs.documents.firstId &&
            lhs.documents.secondId == rhs.documents.secondId &&
            lhs.similarity == rhs.similarity
    }
}

public struct DocumentPair: Hashable {
    let firstId: DocumentId
    let secondId: DocumentId
}

typealias DocumentId = Int

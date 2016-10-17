/*:
 1.8 Tranform an MxN matrix such that if an element is 0 its column and row are zeroed
 */

func zeroedMatrix(matrix: [[Int]]) -> [[Int]] {
    var zeroed = matrix
    for (i, row) in matrix.enumeratedIndices() {
        for (k, col) in row.enumeratedIndices() {
            if col == 0 {
                zeroedRowAndColumn(row: i, col: k, matrix: &zeroed)
            }
        }
    }
    return zeroed
}

func zeroedRowAndColumn(row rowI: Int, col colI: Int, matrix: inout [[Int]]) -> [[Int]] {
    
    let zeroedRow = matrix[rowI].map { _ in 0 }
    matrix[rowI] = zeroedRow
    for (i, row) in matrix.enumeratedIndices() {
        var row = row
        row[colI] = 0
        matrix[i] = row
    }
    return matrix
}

let matrix = [[1, 2, 3, 4],  [5, 0, 7, 8],  [9, 10, 0, 12],  [13, 14, 15, 16]]
let zeroed = zeroedMatrix(matrix: matrix)
let verify = [[1, 0, 0, 4],  [0, 0, 0, 0],  [0, 0, 0, 0],  [13, 0, 0, 16]]

assert(zeroed.elementsEqual(verify) { $0 == $1 })
print(zeroed)

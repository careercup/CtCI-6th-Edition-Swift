/*:
 1.8 Tranform an MxN matrix such that if an element is 0 its column and row are zeroed
 */

func zeroedMatrix(_ matrix: [[Int]]) -> [[Int]] {
    var zeroedMatrix = matrix
    let zeros = Array(repeating: 0, count: matrix.first?.count ?? 0)
    for (i, row) in matrix.indicesElements() {
        guard let column = row.firstIndex (where: { $0 == 0 }) else { continue }
        zeroColumns(col: column, matrix: &zeroedMatrix)
        zeroedMatrix[i] = zeros
    }
    return zeroedMatrix
}

func zeroedMatrixInPlace(_ matrix: inout [[Int]]) {
    var zeroedColumns = [Int: Int]()
    for (i, row) in matrix.indicesElements() {
        guard let column = row.firstIndex (where: { $0 == 0 }) else { continue }
        zeroedColumns[i] = column
    }
    let zeros = Array(repeating: 0, count: matrix.first?.count ?? 0)
    for (rowI, col) in zeroedColumns {
        matrix[rowI] = zeros
        zeroColumns(col: col, matrix: &matrix)
    }
}

func zeroColumns(col: Int, matrix: inout [[Int]]) {
    
    for (i, row) in matrix.indicesElements() {
        var row = row
        row[col] = 0
        matrix[i] = row
    }
}

let matrix = [[1, 2, 3, 4],  [5, 0, 7, 8],  [9, 10, 0, 12],  [13, 14, 15, 16]]
let zeroed = zeroedMatrix(matrix)
let verify = [[1, 0, 0, 4],  [0, 0, 0, 0],  [0, 0, 0, 0],  [13, 0, 0, 16]]

assert(zeroed.elementsEqual(verify, by: ==))
print(zeroed)

var copy = matrix
zeroedMatrixInPlace(&copy)
assert(copy.elementsEqual(verify, by: ==))

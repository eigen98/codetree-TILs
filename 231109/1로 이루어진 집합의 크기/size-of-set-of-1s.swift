let nm = readLine()!.split(separator: " ").map{Int(String($0))!}
let n = nm[0] 
let m = nm[1]
var arr = [[Int]]()

var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)

let dir = [[1,0], [0,1], [-1,0], [0, -1]]
var zeroPosition = [[Int]]()
for i in 0..<n{
    var col = 0
    let input = readLine()!.split(separator: " ").map{Int(String($0))!}
    arr.append(input)
}
for i in 0..<n{
    for j in 0..<m{
        var num = arr[i][j]
        if num == 0 {
            zeroPosition.append([i, j])
        }
    }
}

var maxCount = 0
var preRow = -1
var preCol = -1
//전부다 1인 경우?
if n * m == zeroPosition.count { 
    print(n * m) 
}else if zeroPosition.count == 0{
    print(1)
}else{


    for info in zeroPosition{
        if preRow >= 0 {
            arr[preRow][preCol] = 0
        }
        var r = info[0]
        var c = info[1]

        arr[r][c] = 1
        preRow = r
        preCol = c 

        for i in 0..<n{
            for j in 0..<m{
                visited[i][j] = false
            }
        }
        
        for i in 0..<n{
            for j in 0..<m{
                if visited[i][j] { continue }
                if arr[i][j] == 0 { continue }
                let count = bfs(row: i, col: j)
                maxCount = max(count, maxCount)
            }
        }
        
    }
    print(maxCount)
}

func bfs(row: Int, col: Int) -> Int{
    var count = 0
    var queue = [[Int]]()
    queue.append([row, col])
    visited[row][col] = true

    while queue.count > 0 {
        let now = queue.removeFirst()
        count += 1
        let nowR = now[0]
        let nowC = now[1]

        for i in 0..<dir.count {
            let nr = nowR + dir[i][0]
            let nc = nowC + dir[i][1]

            if nr < 0 || nr >= n || nc < 0 || nc >= m {
                continue
            }
            if visited[nr][nc] || arr[nr][nc] == 0 {
                continue
            }
            queue.append([nr,nc])
            visited[nr][nc] = true
        }
    }
    return count
}
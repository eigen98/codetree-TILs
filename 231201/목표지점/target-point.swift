var nm = readLine()!.split(separator: " ").map{Int(String($0))!}
var n = nm[0]
var m = nm[1]
var arr = [[Int]]()
var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
var dir = [[1,0], [-1, 0], [0, 1], [0, -1]]
var answerArr = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
for i in 1...n{
    var input = readLine()!.split(separator: " ").map{Int(String($0))!}
    arr.append(input)
}

for i in 0..<n{
    for j in 0..<m{
        if arr[i][j] == 1{
            answerArr[i][j] = -1
        }
    }
}

for i in 0..<n{
    for j in 0..<m{
        if arr[i][j] == 2{
            bfs(r: i, c: j)
        }
    }
}

for i in 0..<n{
    var strArr = [String]()
    for j in 0..<m{
        strArr.append("\(answerArr[i][j])")
    }
    print(strArr.joined(separator: " "))
}


func bfs(r: Int, c: Int){
    var queue = [[Int]]()
    var idx = 0
    queue.append([r,c])
    visited[r][c] = true
    
    while(queue.count > idx){
        var now = queue[idx]
        idx += 1
        var nowR = now[0]
        var nowC = now[1]

        for i in 0...3{
            var nr = nowR + dir[i][0]
            var nc = nowC + dir[i][1]
            if nr < 0 || nr >= n || nc < 0 || nc >= m{ continue }
            if visited[nr][nc] { continue }
            if arr[nr][nc] == 0 { continue }
            if arr[nr][nc] == 2 { continue }

            answerArr[nr][nc] = answerArr[nowR][nowC] + 1
            queue.append([nr, nc])
            visited[nr][nc] = true
        }
    }
}
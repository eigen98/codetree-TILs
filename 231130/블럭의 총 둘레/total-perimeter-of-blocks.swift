var N = Int(readLine()!)!
var arr = [[Int]](repeating: [Int](repeating: 0, count : 102), count: 102)
var dir = [[1,0], [0,1], [-1,0], [0,-1]]
var isOutDoor = [[Bool]](repeating: [Bool](repeating: false, count : 102), count: 102)
var visitedMap = [String: Bool]()
var visited = [[Bool]](repeating: [Bool](repeating: false, count : 102), count: 102)
var answer = 0

for i in 1...N{
    var rc = readLine()!.split(separator: " ").map{Int(String($0))!}
    var r = rc[0]
    var c = rc[1]
    arr[r][c] = 1
}

findOutDoor(r: 0, c: 0)
bfs(r: 0, c: 0)
print(answer)

func findOutDoor(r: Int, c: Int){
    if isOutDoor[r][c] || arr[r][c] == 1{
        return
    }
     isOutDoor[r][c] = true

     for i in 0...3{
        var nr = r + dir[i][0]
        var nc = c + dir[i][1]
        if nr < 0 || nr >= 102 || nc < 0 || nc >= 102{ continue }
        if isOutDoor[r][c] { continue }
        if arr[nr][nc] == 1 { continue }
        findOutDoor(r: nr, c: nc)

     }
    
}

func bfs(r: Int, c: Int){
    if !isOutDoor[r][c] {
        return
    } 
    var queue = [[Int]]()
    var idx = 0
    queue.append([r,c])
    visited[r][c] = true
    visitedMap["\(r),\(c),0"] = true
    visitedMap["\(r),\(c),1"] = true
    visitedMap["\(r),\(c),2"] = true
    visitedMap["\(r),\(c),3"] = true

    while(queue.count > idx){
        var now = queue[idx]
        var nowR = now[0]
        var nowC = now[1]
        
        for i in 0...3{
            var nr = nowR + dir[i][0]
            var nc = nowC + dir[i][1]
            if nr < 0 || nc < 0 || nr >= 102 || nc >= 102 { continue }
            if visited[nr][nc] { continue }
            if visitedMap["\(nr),\(nc),\(i)"] != nil { continue }
            if arr[nr][nc] == 1{
                visitedMap["\(nr),\(nc),\(i)"] = true
                answer += 1
                continue
            }
            if arr[nr][nc] == 0{
                visited[nr][nc] = true
            }
            queue.append([nr,nc])
        }
        idx += 1
        
    }

}
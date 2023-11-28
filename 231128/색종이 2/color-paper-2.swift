var n = Int(readLine()!)!
var answer = 0
var arr = [[Int]](repeating: [Int](repeating: 0, count: 501), count: 501)
var visited = [[Bool]](repeating: [Bool](repeating: false, count: 501), count: 501)

var dir = [[1,0], [0,1], [0,-1], [-1,0]]
for i in 1...n{
    var xy = readLine()!.split(separator: " ").map{Int(String($0))!}
    var row = 500 - xy[1]
    var col = xy[0]
    for i in (row - 10)...row{
        for j in col...(col + 10){
            arr[i][j] = 1
        }
    }
}

for i in 0...500{
    for j in 0...500{
        if arr[i][j] == 1 && !visited[i][j]{
            dfs(r: i, c: j)
        }
    }
}

func dfs(r: Int, c: Int){
    if visited[r][c] {
        return
    }
    visited[r][c] = true

    for i in 0...3 {
        let nr = r + dir[i][0]
        let nc = c + dir[i][1]

        if nr < 0 || nr > 500 || nc < 0 || nc > 500 {
            answer += 1
            continue
        }

        if arr[nr][nc] == 0 {
            answer += 1
        } else if !visited[nr][nc] {
            dfs(r: nr, c: nc)
        }
    }
}


print(answer)
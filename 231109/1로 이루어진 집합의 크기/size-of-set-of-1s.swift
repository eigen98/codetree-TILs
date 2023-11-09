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
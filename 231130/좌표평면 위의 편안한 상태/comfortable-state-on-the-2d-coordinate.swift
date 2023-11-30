var dir = [[1,0], [0,1], [-1,0],[0,-1]]
var map = [String: Bool]()
var completed = [[Bool]](repeating: [Bool](repeating: false, count: 1001), count: 1001)
var arr = [[Int]](repeating: [Int](repeating: 0, count: 1001), count: 1001)
var totalCount = 0
func solution(){
    var N = Int(readLine()!)!
    for i in 1...N{
        var xy = readLine()!.split(separator: " ").map{Int(String($0))!}
        var row = xy[1]
        var col = xy[0]
        arr[row][col] = 1
        find(r: row, c: col)

    }
}

solution()

func find(r: Int, c: Int){
    if arr[r][c] != 1{
        return 
    }
    var count = 0
     for i in 0...3{
        var nr = r + dir[i][0]
        var nc = c + dir[i][1]
        if nr < 0 || nr > 1000 || nc < 0 || nc > 1000{ continue }
        if arr[nr][nc] == 1{ 
            count += 1 
        }else{
            continue
        }
        if isCompleted(r: nr, c: nc){
            if map["\(nr),\(nc)"] == nil ||  map["\(nr),\(nc)"] == false{
                totalCount += 1
            }
            map["\(nr),\(nc)"] = true
            
        }else{
            if map["\(nr),\(nc)"] != nil &&  map["\(nr),\(nc)"] == true{
                totalCount -= 1
            }
           map["\(nr),\(nc)"] = false
        }

    }
    if count == 3{
        if map["\(r),\(c)"] == nil ||  map["\(r),\(c)"] == false{
                totalCount += 1
        }
        map["\(r),\(c)"] = true
    }

    print(totalCount)
}

func isCompleted(r: Int, c: Int) -> Bool{
    if arr[r][c] != 1{
        return false
    }
    var count = 0

    for i in 0...3{
        var nr = r + dir[i][0]
        var nc = c + dir[i][1]
         if nr < 0 || nr > 1000 || nc < 0 || nc > 1000{ continue }
        if arr[nr][nc] == 1 {
            count += 1
        }
    }

    if count == 3{
        return true
    }else{
        return false
    }
}
var nm = readLine()!.split(separator: " ").map{Int(String($0))!}
var n = nm[0]
var m = nm[1]
var visited = [Bool](repeating: false, count : 1001)
var possibleCount = [[Int]](repeating: [Int](repeating: 0, count: 2), count : 1001)
var adjArr = [[Int]](repeating: [Int](), count : 1001)

if n == 1{
    print(1)
}else{
    for i in 1...m{
        var input = readLine()!.split(separator: " ").map{Int(String($0))!}
        var from = input[0]
        var to = input[1]
        adjArr[from].append(to)
    }


    for node in 1...n{
        possibleCount[node][0] = node
        if !visited[node]{
            dfs(start: node)
        }
    }

    var answerArr = [String]()


    possibleCount = possibleCount.sorted{
        if $0[1] != $1[1] {
            return $0[1] > $1[1]
        }else{
            return $0[0] < $1[0] 
        }

    }
    var prev = -1

    for xy in possibleCount{

        if prev != -1 && prev != xy[1]{
            break
        }

        answerArr.append("\(xy[0])")
        prev = xy[1]
    }
    print(answerArr.joined(separator: " "))

}

func dfs(start: Int) -> Int{
    var result = 1
    visited[start] = true
    for next in adjArr[start]{
        if visited[next]{
            result += possibleCount[next][1]
            continue
        }
        
        var plusCount = dfs(start: next)
        result += plusCount
        
    }
    possibleCount[start][1] = result
    return result
}
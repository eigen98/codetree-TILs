var NQ = readLine()!.split(separator: " ").map{Int(String($0))!}
var N = NQ[0] // 채팅방수
var Q = NQ[1] // 명령 수
var parentArr = [0]
var authorityArr = [0]
var adjArr = [[Int]](repeating: [Int](), count: N + 1)
var alarmArr = [Bool](repeating: true, count : N + 1)
var alarmPossibleCount = 0

for i in 1...Q{
    var input = readLine()!.split(separator: " ").map{Int(String($0))!}
    switch input[0]{
        case 100 : //채팅방 준비
            ready(arr : input)
            break
        case 200 :
            alarmSet(arr :input)
            break
        case 300 : 
            authoritySet(arr : input)
            break
        case 400 : 
            changeParent(arr : input)
            break
        case 500 : 
            getCount(arr : input)
            break
        default: 
            break
    }
}

func ready(arr: [Int]){
    for i in 1...N{
        var num = arr[i]
        parentArr.append(num)
        var child = i
        var parent = num
        adjArr[parent].append(child)
    }

    for i in 1...N{
        var num = arr[N + i]
        authorityArr.append(num)
    }
}

func alarmSet(arr :[Int]){
    var c = arr[1]
    alarmArr[c] = !alarmArr[c] 
}

func authoritySet(arr :[Int]){
    var c = arr[1]
    var power = arr[2]
    authorityArr[c] = power
}

func changeParent(arr :[Int]){
    var c1 = arr[1]
    var c2 = arr[2]

    for i in 0..<adjArr[parentArr[c1]].count{
       if adjArr[parentArr[c1]][i] == c1 {
        adjArr[parentArr[c1]][i] = c2
        break
       }
    }
    for i in 0..<adjArr[parentArr[c2]].count{
       if adjArr[parentArr[c2]][i] == c2 {
        adjArr[parentArr[c2]][i] = c1
        break
       }
    }

    var tempParent = parentArr[c1]
    parentArr[c1] = parentArr[c2]
    parentArr[c2] = tempParent
}

func getCount(arr :[Int]){
    alarmPossibleCount = 0
    var c = arr[1]
    dfs(start: c, dist: 1)

    print(alarmPossibleCount)
}
//dist: 타겟과의 거리
func dfs(start: Int, dist: Int){
     //print("가능한 타겟: \(start)")
    if !alarmArr[start] { return }

    for next in adjArr[start]{
        if authorityArr[next] < dist { continue }
        if !alarmArr[next] { continue }
        alarmPossibleCount += 1
        dfs(start: next, dist: dist + 1)
    }
}
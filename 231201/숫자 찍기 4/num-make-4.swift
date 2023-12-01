var N = Int(readLine()!)!
var arr = [[Int]](repeating: [Int](repeating: 0, count : N), count : N)

var step = 1
var limit = N / 2
if N % 2 != 0{
    limit = N / 2 + 1 
}

var nowNum = 1
while(step < limit){
    //상

    for col in (step - 1)...(N - 1 - step){
        if nowNum > N * N { break}
        arr[step - 1][col] = nowNum
        nowNum += 1
    }
 
    if nowNum > N * N { break}
    //우
    for row in (step - 1)...(N - 1 - step){
        if nowNum > N * N { break}
            arr[row][N - step] = nowNum
            nowNum += 1
    }
    
     if nowNum > N * N { break}
    //하

    for col in stride(from: (N - step) , through: step, by: -1){
         if nowNum > N * N { break}

        arr[N - step][col] = nowNum
        nowNum += 1
    }
     if nowNum > N * N { break}

    //좌
    for row in stride(from: (N - step) , through: step, by: -1){
         if nowNum > N * N { break}

        arr[row][step - 1] = nowNum
        nowNum += 1
    }
    step += 1
}

//홀일 때
if N % 2 != 0 {
    arr[N / 2][N / 2] = nowNum
}else{
    //짝일 때
    arr[N/2 - 1][N/2 - 1] = nowNum
    nowNum += 1
    arr[N/2 - 1][N/2] = nowNum
    nowNum += 1
    arr[N/2][N/2] = nowNum
    nowNum += 1
    arr[N/2][N/2 - 1] = nowNum

}


for i in 0..<N{
    var strArr = [String]()
    for j in 0..<N{
        strArr.append("\(arr[i][j])")
    }
    print(strArr.joined(separator: " "))
}
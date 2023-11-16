import Foundation

// 전역 변수 선언
var L: Int = 0
var Q: Int = 0

// Query 구조체: 각 쿼리의 정보를 저장
struct Query {
    var cmd: Int
    var t: Int
    var x: Int
    var n: Int
    var name: String
}

// 쿼리와 관련된 다양한 컬렉션들
var queries = [Query]()
var names = Set<String>()
var p_queries = [String: [Query]]()
var entry_time = [String: Int]()
var position = [String: Int]()
var exit_time = [String: Int]()

// 두 쿼리를 비교하는 함수
func cmp(_ q1: Query, _ q2: Query) -> Bool {
    if q1.t != q2.t {
        return q1.t < q2.t
    }
    return q1.cmd < q2.cmd
}

// 메인 함수
func main() {
    // 입력 처리
    var input =  readLine()!.split(separator: " ").map { Int(String($0))! }
    L = input[0]
    Q = input[1]

    for _ in 0..<Q {
        let parts = readLine()!.split(separator: " ").map { String($0) }
        let cmd = Int(parts[0])!
        var t = -1, x = -1, n = -1
        var name = ""

        // 쿼리 타입에 따른 데이터 처리
        if cmd == 100 {
            t = Int(parts[1])!
            x = Int(parts[2])!
            name = parts[3]
        } else if cmd == 200 {
            t = Int(parts[1])!
            x = Int(parts[2])!
            name = parts[3]
            n = Int(parts[4])!
        } else {
            t = Int(parts[1])!
        }

        // 쿼리 추가
        let query = Query(cmd: cmd, t: t, x: x, n: n, name: name)
        queries.append(query)

        //쿼리 타입에 따른 추가 데이터 처리
        if cmd == 100 {
            p_queries[name, default: []].append(query)
        } else if cmd == 200 {
            names.insert(name)
            entry_time[name] = t
            position[name] = x
        }
    }

    // 각 이름에 대한 처리
    for name in names {
        exit_time[name] = 0

        if let pQuery = p_queries[name] {
            for q in pQuery {
                var time_to_removed = 0
                // 초밥이 사람이 등장하기 전에 주어진 경우
                if q.t < entry_time[name]! {
                    let t_sushi_x = (q.x + (entry_time[name]! - q.t)) % L
                    let additional_time = (position[name]! - t_sushi_x + L) % L

                    time_to_removed = entry_time[name]! + additional_time
                } else {
                    // 초밥이 사람이 등장한 이후에 주어진 경우
                    let additional_time = (position[name]! - q.x + L) % L
                    time_to_removed = q.t + additional_time
                }

                // 퇴장 시간 업데이트
                exit_time[name] = max(exit_time[name]!, time_to_removed)
                // 111번 쿼리 추가
                queries.append(Query(cmd: 111, t: time_to_removed, x: -1, n: -1, name: name))
            }
        }
    }

    //222번 쿼리 추가
    for name in names {
        queries.append(Query(cmd: 222, t: exit_time[name]!, x: -1, n: -1, name: name))
    }

    // 쿼리 정렬
    queries.sort { cmp($0, $1) }

    // 사람 수와 초밥 수 계산
    var people_num = 0, sushi_num = 0
    for query in queries {
        switch query.cmd {
        case 100: // 초밥 추가
            sushi_num += 1
        case 111: // 초밥 제거
            sushi_num -= 1
        case 200: // 사람 추가
            people_num += 1
        case 222: // 사람 제거
            people_num -= 1
        case 300: // 사진 촬영 시 출력
            print("\(people_num) \(sushi_num)")
        default:
            break
        }
    }
}

main()
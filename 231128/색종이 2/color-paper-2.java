import java.util.Scanner;

public class Main {
    public static final int MAX_SIZE = 100;

    public static int n;
    public static int[][] a = new int[MAX_SIZE][MAX_SIZE];

    // 방향을 표현하기 위한 배열입니다. 아래, 오른쪽, 위, 왼쪽 순서입니다.
    public static int[] dx = {1, 0, -1, 0};
    public static int[] dy = {0, 1, 0, -1};

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // 사각형의 개수를 입력받습니다.
        n = sc.nextInt();

        int x, y;
        // 각 사각형의 왼쪽 위 좌표를 입력받아, 해당 영역을 1로 표시합니다.
        for (int i = 0; i < n; i++) {
            y = sc.nextInt();
            x = sc.nextInt();
            for (int j = y; j < y + 10; j++) {
                for (int k = x; k < x + 10; k++) {
                    a[j][k] = 1;
                }
            }
        }

        int s = 0;
        // 100*100 격자를 탐색하면서, 각 칸에서의 외곽선 개수를 셉니다.
        for (int i = 0; i < MAX_SIZE; i++) {
            for (int j = 0; j < MAX_SIZE; j++) {
                if (a[i][j] == 0) continue;
                // 각 칸에서 4방향을 확인하며, 외곽선을 카운트합니다.
                for (int k = 0; k < 4; k++) {
                    int ny = i + dy[k];
                    int nx = j + dx[k];
                    // 경계를 벗어나거나, 인접한 칸이 0일 경우 외곽선으로 카운트합니다.
                    if (ny < 0 || nx < 0 || ny >= MAX_SIZE || nx >= MAX_SIZE || a[ny][nx] == 0) {
                        s++;
                    }
                }
            }
        }

        // 결과를 출력합니다.
        System.out.println(s);
    }
}
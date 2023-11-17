import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static final int MAX_N = 100001;
    public static final int MAX_D = 22;

    public static int n, q;
    public static int[] a = new int[MAX_N];
    public static int[] p = new int[MAX_N];
		////val[i]는 i번째 채팅방에서 발생할 수 있는 유효한 알림의 수
    public static int[] val = new int[MAX_N];
    public static boolean[] noti = new boolean[MAX_N];
//nx[i][j]는 i번째 채팅방에서 j단계 위의 부모 채팅방까지 도달할 수 있는 채팅방의 수
    public static int[][] nx = new int[MAX_N][MAX_D];

    // 초기 설정 값을 받아옵니다.
    public static void init(Scanner sc) {
        // 부모 채팅과 채팅의 권한 정보를 입력받습니다.
        for (int i = 1; i <= n; i++) {
            p[i] = sc.nextInt();
        }
        for (int i = 1; i <= n; i++) {
            a[i] = sc.nextInt();
            // 채팅의 권한이 20을 초과하는 경우 20으로 제한합니다.
            if (a[i] > 20) a[i] = 20;
        }
        
        // nx 배열과 val 값을 초기화합니다.
        for (int i = 1; i <= n; i++) {
            int cur = i;
            int x = a[i];
            nx[cur][x]++;
            // 상위 채팅으로 이동하며 nx와 val 값을 갱신합니다.
						
            while (p[cur] != 0 && x != 0) {
                cur = p[cur];
                x--;
								// i번째 채팅방에서 j단계 위의 부모 채팅방까지 도달할 수 있는 채팅방의 수
                if (x != 0) nx[cur][x]++;
                val[cur]++;
            }
        }
    }

    // 채팅의 알림 상태를 토글합니다.
    public static void toggle_noti(int chat) {
        if (noti[chat]) {
            int cur = p[chat];
            int num = 1;
            // 상위 채팅으로 이동하며 noti 값에 따라 nx와 val 값을 갱신합니다.
            while (cur != 0) {
                for (int i = num; i <= 21; i++) {
                    val[cur] += nx[chat][i];
                    if (i > num) nx[cur][i - num] += nx[chat][i];
                }
                if (noti[cur]) break;
                cur = p[cur];
                num++;
            }
            noti[chat] = false;
        } else {
            int cur = p[chat];
            int num = 1;
            // 상위 채팅으로 이동하며 noti 값에 따라 nx와 val 값을 갱신합니다.
            while (cur != 0) {
                for (int i = num; i <= 21; i++) {
										//val[i]는 i번째 채팅방에서 발생할 수 있는 유효한 알림의 수
                    val[cur] -= nx[chat][i];
                    if (i > num) nx[cur][i - num] -= nx[chat][i];
                }
                if (noti[cur]) break;
                cur = p[cur];
                num++;
            }
            noti[chat] = true;
        }
    }

    // 채팅의 권한의 크기를 변경합니다.
    public static void change_power(int chat, int power) {
        int bef_power = a[chat];
        power = Math.min(power, 20);  // 권한의 크기를 20으로 제한합니다.
        a[chat] = power;

        nx[chat][bef_power]--;
        if (!noti[chat]) {
            int cur = p[chat];
            int num = 1;
            // 상위 채팅으로 이동하며 nx와 val 값을 갱신합니다.
            while (cur != 0) {
                if (bef_power >= num) val[cur]--;
                if (bef_power > num) nx[cur][bef_power - num]--;
                if (noti[cur]) break;
                cur = p[cur];
                num++;
            }
        }

        nx[chat][power]++;
        if (!noti[chat]) {
            int cur = p[chat];
            int num = 1;
            // 상위 채팅으로 이동하며 nx와 val 값을 갱신합니다.
            while (cur != 0) {
                if (power >= num) val[cur]++;
                if (power > num) nx[cur][power - num]++;
                if (noti[cur]) break;
                cur = p[cur];
                num++;
            }
        }
    }

    // 두 채팅의 부모를 교체합니다.
    public static void change_parent(int chat1, int chat2) {
        boolean bef_noti1 = noti[chat1];
        boolean bef_noti2 = noti[chat2];

        if (!noti[chat1]) toggle_noti(chat1);
        if (!noti[chat2]) toggle_noti(chat2);

        int temp = p[chat1];
        p[chat1] = p[chat2];
        p[chat2] = temp;

        if (!bef_noti1) toggle_noti(chat1);
        if (!bef_noti2) toggle_noti(chat2);
    }

    // 해당 채팅의 val 값을 출력합니다.
    public static void print_count(int chat) {
        System.out.println(val[chat]);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        
        n = sc.nextInt();
        q = sc.nextInt();
        
        while (q-- > 0) {
            int query = sc.nextInt();
            if (query == 100) {
                init(sc);
            } else if (query == 200) {
                int chat = sc.nextInt();
                toggle_noti(chat);
            } else if (query == 300) {
                int chat = sc.nextInt();
                int power = sc.nextInt();
                change_power(chat, power);
            } else if (query == 400) {
                int chat1 = sc.nextInt();
                int chat2 = sc.nextInt();
                change_parent(chat1, chat2);
            } else if (query == 500) {
                int chat = sc.nextInt();
                print_count(chat);
            }
        }
    }
}
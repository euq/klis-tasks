/* Sample6 */
public class Sample6 {
    public static void main(String[] args) {
        int numbers[] = new int[10];   // 配列の宣言と確保

        try {                                         // ここから
            numbers[20] = 0;  //  エラー発生
        } catch (ArrayIndexOutOfBoundsException e) {  // ここまでの例外を捕捉
            System.out.println("Exception occured: " + e);  // 例外処理
        }

        System.out.println("Finish!");  // 終了メッセージの表示
    }
}

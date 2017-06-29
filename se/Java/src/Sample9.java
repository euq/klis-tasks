/* Sample9 */

import java.io.*;

public class Sample9 {
    public static void main(String[] args) {

        try {
            BufferedReader br = new BufferedReader(
              new InputStreamReader(System.in));  // 入力ストリームの作成

            	System.out.print("お名前は？");
		String str = br.readLine();
		System.out.println("こんにちは，" + str + "さん！");

        } catch (IOException e) {
            System.out.println("Exception in IO.");
            System.exit(1);  // プログラムの終了
        }
    }
}

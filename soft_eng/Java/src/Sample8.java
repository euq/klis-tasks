/* Sample8 */
import java.io.*;

public class Sample8 {
    public static void main(String[] args) {
        String filename = "test8.txt";

        try {
            PrintWriter pw = new PrintWriter(
					     new BufferedWriter(  // バッファを挿入
								new FileWriter(filename)));  // 出力ストリームの作成
            pw.println("Java");
            pw.println("Programming");  // 文字列を書き出す
            pw.println("Language");
            pw.close();  // 出力ストリームのクローズ

        } catch (IOException e) {
            System.out.println("Cannot write: " + filename);
            System.exit(1);  // プログラムの終了
        }

        try {
            BufferedReader br = new BufferedReader(  // バッファを挿入
            		new FileReader(filename));  // 入力ストリームの作成

            String line;
            while ((line = br.readLine()) != null) {  // 文字列を読み込む
                System.out.println(line);
            }
            br.close();  // 入力ストリームのクローズ

        } catch (FileNotFoundException e) {
            System.out.println("File Not Found: " + filename);

        } catch (IOException e) {
            System.out.println("Cannot read: " + filename);
            System.exit(1);  // プログラムの終了
        }
    }
}

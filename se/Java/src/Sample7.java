/* Sample7 */
public class Sample7 {
    public static void main(String[] args) {
        try {
            Manual manual = new Manual();
            manual.setTitle("");  // 文字数0の題名を設定

        } catch (NoTitleException e) {  // 例外の捕捉
            System.out.println("No title");
        }
    }
}

class Manual {
    String title;

    public void setTitle(String t) throws NoTitleException {  // 例外の送出
        if (t.length() == 0) {
            throw new NoTitleException();  // 例外の送出
        }
        title = t;
    }
}

class NoTitleException extends Exception {  //  例外の定義

}

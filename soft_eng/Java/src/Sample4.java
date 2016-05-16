/* Sample4 */
public class Sample4 {
    public static void main(String[] args) {
        BookInLibrary book = new BookInLibrary("Test", 45);
        book.setBorrower("Taro Tezuka");
        System.out.println("Title = " + book.getTitle());
        System.out.println("Borrower = " + book.getBorrower());
    }
}


class BookInLibrary {
    private Book book;        // Bookクラスのインスタンスへの参照
    private String borrower;  // 借用者

    BookInLibrary(String t, int p) {
        book = new Book(t, p);  // Bookクラスのインスタンスの生成
        borrower = null;
    }

    public void setBorrower(String name) {  // 借用者の設定
        borrower = name;
    }

    public String getBorrower() {  // 借用者の取得
        return borrower;
    }

    public String getTitle() {   // 題名の取得
        return book.getTitle();  // インスタンスbookへ転送
    }
}

/* Sample2 */
public class Sample2 {
    public static void main(String[] args) {

        /* Bookクラスからインスタンスを生成 */
        Book book1 = new Book("Learn to cook sushi", 55);
        System.out.println("My book title = " + book1.getTitle());
        System.out.println("My book title = " + book1.title);
        System.out.println("My book price = " + book1.getPrice());

        /* Bookクラスからインスタンスを生成 */
        Book book2 = new Book("How to sail", 40);
        System.out.println("Your book title = " + book2.getTitle());
        System.out.println("Your book price = " + book2.getPrice());
        
        // 基本課題1 test
        System.out.println(book2.getYenPrice());
        
        // 基本課題2 test
        book2.setPrice(100);
        System.out.println(book2.getPrice());
        
        // 基本課題4 test
        Book book3 = new Book("How to sail", 40, 1995);
        System.out.println("Your book title = " + book3.getTitle());
        System.out.println("Your book price = " + book3.getPrice());
        
        // 基本課題3 test
        System.out.println(book3.getYear());
        book3.setYear(2010);
        System.out.println(book3.getYear());
        
        // 基本課題5 test
        System.out.println(book3.isCheaperThan(100));
        book3.setPrice(1000);
        System.out.println(book3.isCheaperThan(100));
	
        // 基本課題7 test
        String[] keywords = {"key", "word"};
        Book book4 = new Book("Test book", 100, 1995, keywords);
        // book4.getYear();
        
        // 基本課題9 test
        // 本当はqueryはString[] argsから呼びます
        if (book4.containsKeywords("key")){
        	System.out.println("key is contained");
        }
        
        if (book4.containsKeywords("nyan")){
        	System.out.println("nyan is not contained");
        }
        
        // 基本課題10
        Book[] books = new Book[3];
        for(int i = 0; i < 3; i++){
        	books[i] = new Book("hoge", 10, 2010, keywords);
        	System.out.println(books[i].getPrice());
        }
        
        // 基本課題11
        for(int i = 0; i < books.length; i++){
        	if (books[i].containsKeywords("key")){
        		System.out.println(books[i].getTitle());
        	}
        }
    }
}



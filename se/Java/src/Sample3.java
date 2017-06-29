/* Sample3 */
public class Sample3 {
    public static void main(String[] args) {
        Book book = new Book("Learn to cook sushi", 55);
        System.out.println("Title = " + book.getTitle());
        System.out.println("Price = " + book.getPrice());

        OnlineBook obook = new OnlineBook(
					  "The Java Virtual Machine Specification", 0,
					  "http://java.sun.com/docs/books/vmspec/index.html");
        
        System.out.println("Title = " + obook.getTitle());
        System.out.println("Price = " + obook.getPrice());
        System.out.println("Website = " + obook.getWebsite());
        
        
        // 基本課題12
        OnlineMagazine omagazine = new OnlineMagazine(
					  "The Java Virtual Machine Specification", 0,
					  "http://java.sun.com/docs/books/vmspec/index.html",
					  1995, 12, 3);        
        
        System.out.println(omagazine.getPublicationDate());
        
    }
}

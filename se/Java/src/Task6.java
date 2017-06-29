
public class Task6 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Book[] books = new Book[3];
		
        books[0] = new Book("Learn to cook sushi", 55);
        books[1] = new Book("How to sail", 40);
        books[2] = new Book("How to sail", 40, 1995);

        int query = Integer.parseInt(args[0]);
        for (int i = 0; i < books.length; i++){
        	if (books[i].isCheaperThan(query)){
        		System.out.println(books[i].getTitle());
        	}
        }
	}
}

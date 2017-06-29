
// 基本課題8
public class Task8 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Book[] books = new Book[3];
		
        books[0] = new Book("Learn to cook sushi", 55);
        books[1] = new Book("How to sail", 40);
        books[2] = new Book("How to sail", 40, 1995);

        String query = args[0];
        for (int i = 0; i < books.length; i++){
        	if(books[i].getTitle().indexOf(query) != -1){
        		System.out.println(books[i].getTitle());
        	}
        }
        
	}

}

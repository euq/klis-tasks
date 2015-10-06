// Sample1.java

// main class
class SampleUntil7{

  public static void main(String[] args){
    
    // create instance
    String[] kwds = {"japanese", "counsin", "sushi", "fish"};

    Book book = new Book("book", 2, 19990229, kwds);
    
    // check price
    if (book.isCheaperThan(50)){
      System.out.println(book.getTitle());
    }

    Book[] books = new Book[10];
    books[0] = new Book("book", 2, 19990229, kwds);
    books[1] = new Book("sushi", 40, 19990229, kwds);
    books[2] = new Book("ebi", 60, 19990229, kwds);
    books[3] = new Book("soba", 100, 19990229, kwds);

    for (Book nowBook: books){
      try{
        if (nowBook.getPrice() > Integer.parseInt(args[0])){
          System.out.println(nowBook.getTitle());
          System.out.println(nowBook.getKeyWords().length);
        }
      }catch(NullPointerException e){
        System.out.println("ぬるぽ");
        break;
      }
    }

  }
}


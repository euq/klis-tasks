class Sample{

  public static void main(String[] args){

    // create instance
    String[] kwds = {"japanese", "counsin", "sushi", "fish"};

    Book[] books = new Book[10];
    books[0] = new Book("book", 2, 19990229, kwds);
    books[1] = new Book("sushi", 40, 19990229, kwds);
    books[2] = new Book("ebi", 60, 19990229, kwds);
    books[3] = new Book("soba", 100, 19990229, kwds);

    String searchTitle = args[0];
    if (books[0].containsInKeywords(searchTitle)){
      System.out.println("contain");
    }
  }
}

public class Book{

  // member variables
  private String title;
  private double price;
  private int year;
  private String[] keywords;

  // constructor
  Book(String t, double p, int y, String[] k){
    title = t;
    price  = p;
    year  = y;
    keywords = k;
  }

  public double getYenPrice(){
    return price * 92.70;
  }

  public void setPrice(int y){
    price = y;
  }

  public double getPrice(){
    return price;
  }

  public void setYear(int y){
    year = y;
  }

  public int getYear(){
    return year;
  }

  public String getTitle(){
    return title;
  }

  public String[] getKeyWords(){
    return keywords;
  }

  public boolean isCheaperThan(int x){
    return price > x;
  }

  public boolean containsInKeywords(String query){
    for(String keyword: keywords){
      if(query.equals(keyword)){
        return true;
      }
    }
    return false;
  }
}

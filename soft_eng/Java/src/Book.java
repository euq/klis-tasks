
class Book {  // クラスBookの宣言
    String title;       // 題名
    private int price;  // 価格(ドル)
    
    // 基本課題3
    public int year;
    
    // 基本課題7
    public String[] keywords;

    Book(String t, int p) {  // コンストラクタ
        title = t;  // 題名の設定
        price = p;  // 価格の設定
    }
    
    // 基本課題4
    Book(String t, int p, int y){
    	title = t;
    	price = p;
    	year  = y;
    }

    // 基本課題7
    Book(String t, int p, int y, String[] k){
    	title = t;
    	price = p;
    	year  = y;
    	keywords = k;
    }
    
    public String getTitle() {  // 題名の取得
        return title;
    }

    public int getPrice() {  // 価格の取得
        return price;
    }
    
    // 基本課題1
    public double getYenPrice(){
    	return 120.47 * price;
    }
    
    // 基本課題2
    public void setPrice(int p){
    	price = p;
    }
    
    // 基本課題3
    public int getYear(){
    	return year;
    }
    
    // 基本課題3
    public void setYear(int y){
    	year = y;
    }
    
    // 基本課題5
    public boolean isCheaperThan(int x){
    	return price > x;
    }
    
    // 基本課題9
    public boolean containsKeywords(String query){
    	for (int i = 0; i < keywords.length; i++){
    		if (query.equals(keywords[i])){
    			return true;
    		}
    	}
    	return false;
    }
}
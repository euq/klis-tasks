
class Article extends Publication{  // クラスPublicationを継承
//class Article implements Publication{
	private String journal;  // 雑誌名

    Article(String t, String j) {
        super(t);
        journal = j;
    }
    
    public void showInfo() {  // showInfoの()実装
        System.out.println("Journal article: " + title + ", in " + journal);
    }
    
    // 基本課題13
    public boolean searchBiblio(String query){
    	if (title.indexOf(query) != -1 || journal.indexOf(query) != -1){
    		return true;
    	}
    	return false;
    }
}
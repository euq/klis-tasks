
class TechReport extends Publication{  // クラスPublicationを継承
    private String institution;  // 発行機関

    TechReport(String t, String i) {
        super(t);
        institution = i;
    }

    public void showInfo() {  // showInfoの()実装
        System.out.println("Tech report: " + title + ", by " + institution);
    }
    
    // 基本課題13
    public boolean searchBiblio(String query){
    	if (title.indexOf(query) != -1 || institution.indexOf(query) != -1){
    		return true;
    	}
    	return false;
    }
}
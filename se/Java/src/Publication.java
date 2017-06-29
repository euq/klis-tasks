

abstract class Publication{  // 抽象クラスの宣言
    protected String title;  // 題名

    Publication(String t) {
        title = t;
    }
    
    abstract public boolean searchBiblio(String query);
    abstract public void showInfo();  // 抽象メソッドの宣言
}


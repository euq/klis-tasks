
class OnlineBook extends Book {  // クラスBookを継承
    public String website;  // URL

    OnlineBook(String t, int p, String website) {
        super(t, p);             // スーパークラスのコンストラクタの呼び出し
        this.website = website;  // URLの設定
    }

    public String getWebsite() {  // URLの取得
        return website;
    }

    public String getTitle() {
        return "Online: " + title;
    }
}
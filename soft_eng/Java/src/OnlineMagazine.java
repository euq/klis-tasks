

// 基本課題12
public class OnlineMagazine extends OnlineBook {
	int publishYear;
	int publishMonth;
	int publishDate;
	
	// constructer
	OnlineMagazine(String t, int p, String website, int py, int pm, int pd) {
		super(t, p, website);
		// TODO Auto-generated constructor stub
		publishYear = py;
		publishMonth = pm;
		publishDate = pd;
	}
	
	public void setMonth(int m){
		publishMonth = m;
	}
	
	public void setDate(int d){
		publishMonth = d;
	}
	
	public String getPublicationDate(){
		return publishYear + "/" + publishMonth + "/" + publishDate;
	}
	
}

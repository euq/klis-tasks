/* Sample5 */
public class Sample5 {
    public static void main(String[] args) {

	Publication[] pub = new Publication[4];

        pub[0] = new Article("Java Compiler", "IEEE Software");
        pub[1] = new TechReport("Research on Software Engineering",
				"University of Tsukuba");
        pub[2] = new Article("An apple a day", "Nature");
        pub[3] = new TechReport("Research on Global Warming", 
				"University of World");

	for(int i = 0; i < pub.length; i++){
	    pub[i].showInfo();
	    // 基本課題13 test
	    System.out.println(pub[i].searchBiblio("Software"));
	}

    }
}
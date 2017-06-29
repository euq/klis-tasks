import java.io.*;

public class Advance1 {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
//		String filename = "../data/bib.csv";
		String filename = "../data/bib.csv";
		File file = new File(filename);

		FileReader filereader = new FileReader(file);
		BufferedReader br = new BufferedReader(filereader);

		String line;
		while ((line = br.readLine()) != null) {
            String[] elems = line.split(",");
            System.out.println(line.replaceAll(",", "\t"));
            
            System.out.println(elems[0]);
            System.out.println(elems[1]);
            System.out.println(elems[2]);
        }


	}

}

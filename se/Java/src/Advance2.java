import java.io.*;
import java.util.Scanner;

public class Advance2 {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		String filename = "../data/townpage.csv";
		File file = new File(filename);
		FileWriter filewriter = new FileWriter(file);
		Scanner in = new Scanner(System.in);

		filewriter.write(in.next());
		filewriter.close();


	}

}

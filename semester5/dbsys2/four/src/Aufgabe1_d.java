/**
 * Licensee: Lars(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class Aufgabe1_d {
	private static final int ROW_COUNT = 100;
	
	public void listTestData() throws PersistentException {
		System.out.println("Listing Vorlesung...");
		Vorlesung[] vorlesungs = Vorlesung.listVorlesungByQuery(null, null);
		int length = Math.min(vorlesungs.length, ROW_COUNT);
		for (int i = 0; i < length; i++) {
			System.out.println(vorlesungs[i].getStudiengangs().getName() + ": " + vorlesungs[i].getName() + ", ETCS:  " + vorlesungs[i].getEcts());
		}
		System.out.println(length + " record(s) retrieved.");
		
		// System.out.println("Listing Studiengang...");
		// Studiengang[] studiengangs = Studiengang.listStudiengangByQuery(null, null);
		// length = Math.min(studiengangs.length, ROW_COUNT);
		// for (int i = 0; i < length; i++) {
		// 	System.out.println(studiengangs[i]);
		// }
		// System.out.println(length + " record(s) retrieved.");
		
	}
	
	public static void main(String[] args) {
		try {
			Aufgabe1_d listAufgabe11Data = new Aufgabe1_d();
			try {
				listAufgabe11Data.listTestData();
			}
			finally {
				Aufgabe11PersistentManager.instance().disposePersistentManager();
			}
		}
		catch (Exception e) {
			return;
		}
	}
}

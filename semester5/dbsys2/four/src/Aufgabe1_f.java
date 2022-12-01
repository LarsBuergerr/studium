/**
 * Licensee: Lars(HTWG Konstanz)
 * License Type: Academic
 */
import java.util.Set;


import org.orm.*;
public class Aufgabe1_f {	
	public void listTestData() throws PersistentException {
		System.out.println("Listing Vorlesung...");

        Vorlesung[] vorlesungs = Vorlesung.listVorlesungByQuery(null, null);
        
        Set<String> ain_vorlesungen = new java.util.HashSet<String>();
        Set<String> win_vorlesungen = new java.util.HashSet<String>();

        for (int i = 0; i < vorlesungs.length; i++) { 
            if (vorlesungs[i].getStudiengangs().getName().equals("Angewandte Informatik")) {
                ain_vorlesungen.add(vorlesungs[i].getName());
            } else if (vorlesungs[i].getStudiengangs().getName().equals("Wirtschaftsinformatik")) {
                win_vorlesungen.add(vorlesungs[i].getName());
            }
        }

        Set<String> schnittmenge = new java.util.HashSet<String>(ain_vorlesungen);
        schnittmenge.retainAll(win_vorlesungen);

        System.out.println("Schnittmenge :");
        for (String vorlesung : schnittmenge) {
            System.out.println(vorlesung);
        }
	}
	
	public static void main(String[] args) {
		try {
			Aufgabe1_f listAufgabe11Data = new Aufgabe1_f();
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

/**
 * Licensee: Lars(HTWG Konstanz)
 * License Type: Academic
 */
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;


import org.orm.*;
public class Aufgabe1_e {
	private static final int ROW_COUNT = 100;
	
	public void listTestData() throws PersistentException {
		System.out.println("Listing Vorlesung...");

        Vorlesung[] vorlesungs = Vorlesung.listVorlesungByQuery(null, null);
        
        System.out.println("test 4");
        Map<String,Integer> map = new HashMap<String,Integer>();
        for (int i = 0; i < vorlesungs.length; i++) { 
            if (map.containsKey(vorlesungs[i].getStudiengangs().getName())) {
                map.put(vorlesungs[i].getStudiengangs().getName(), map.get(vorlesungs[i].getStudiengangs().getName()) + vorlesungs[i].getEcts());
            } else {
                map.put(vorlesungs[i].getStudiengangs().getName(), vorlesungs[i].getEcts());
            }
        }
		
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }	
	}
	
	public static void main(String[] args) {
		try {
			Aufgabe1_e listAufgabe11Data = new Aufgabe1_e();
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

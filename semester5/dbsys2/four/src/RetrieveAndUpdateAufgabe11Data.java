/**
 * Licensee: Lars(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class RetrieveAndUpdateAufgabe11Data {
	public void retrieveAndUpdateTestData() throws PersistentException {
		PersistentTransaction t = Aufgabe11PersistentManager.instance().getSession().beginTransaction();
		try {
			Vorlesung vorlesung = Vorlesung.loadVorlesungByQuery(null, null);
			// Update the properties of the persistent object
			vorlesung.save();
			Studiengang studiengang = Studiengang.loadStudiengangByQuery(null, null);
			// Update the properties of the persistent object
			studiengang.save();
			t.commit();
		}
		catch (Exception e) {
			t.rollback();
		}
		
	}
	
	public static void main(String[] args) {
		try {
			RetrieveAndUpdateAufgabe11Data retrieveAndUpdateAufgabe11Data = new RetrieveAndUpdateAufgabe11Data();
			try {
				retrieveAndUpdateAufgabe11Data.retrieveAndUpdateTestData();
			}
			finally {
				Aufgabe11PersistentManager.instance().disposePersistentManager();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}

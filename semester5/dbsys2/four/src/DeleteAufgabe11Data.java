/**
 * Licensee: Lars(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class DeleteAufgabe11Data {
	public void deleteTestData() throws PersistentException {
		PersistentTransaction t = Aufgabe11PersistentManager.instance().getSession().beginTransaction();
		try {
			Vorlesung vorlesung = Vorlesung.loadVorlesungByQuery(null, null);
			vorlesung.delete();
			Studiengang studiengang = Studiengang.loadStudiengangByQuery(null, null);
			studiengang.delete();
			t.commit();
		}
		catch (Exception e) {
			t.rollback();
		}
		
	}
	
	public static void main(String[] args) {
		try {
			DeleteAufgabe11Data deleteAufgabe11Data = new DeleteAufgabe11Data();
			try {
				deleteAufgabe11Data.deleteTestData();
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

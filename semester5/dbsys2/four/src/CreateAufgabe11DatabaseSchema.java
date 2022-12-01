/**
 * Licensee: Lars(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class CreateAufgabe11DatabaseSchema {
	public static void main(String[] args) {
		try {
			ORMDatabaseInitiator.createSchema(Aufgabe11PersistentManager.instance());
			Aufgabe11PersistentManager.instance().disposePersistentManager();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}

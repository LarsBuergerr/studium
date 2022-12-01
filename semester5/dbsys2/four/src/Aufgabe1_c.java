/**
 * Licensee: Lars(HTWG Konstanz)
 * License Type: Academic
 */
import org.orm.*;
public class Aufgabe1_c {
	public void createStudiengangAndVorlesungen() throws PersistentException {
		PersistentTransaction t = Aufgabe11PersistentManager.instance().getSession().beginTransaction();
		try {
			//-----------------Studiengang-----------------
			Studiengang studiengangAIN = Studiengang.createStudiengang();
			studiengangAIN.setName("Angewandte Informatik");
			studiengangAIN.setKuerzel("AIN");
			studiengangAIN.setAbschluss("Bachelor");
			studiengangAIN.save();

			Studiengang studiengangWIN = Studiengang.createStudiengang();
			studiengangWIN.setName("Wirtschaftsinformatik");
			studiengangWIN.setKuerzel("WIN");
			studiengangWIN.setAbschluss("Bachelor");
			studiengangWIN.save();

			//-----------------Vorlesungen AIN-----------------
			Vorlesung prog1 = Vorlesung.createVorlesung();
			prog1.setName("Programmiertechnik_1");
			prog1.setEcts(6);
			prog1.setSws(6);
			prog1.setStudiengangs(studiengangAIN);
			prog1.save();

			Vorlesung sysprog = Vorlesung.createVorlesung();
			sysprog.setName("Systemprogrammierung");
			sysprog.setEcts(6);
			sysprog.setSws(6);
			sysprog.setStudiengangs(studiengangAIN);
			sysprog.save();

			Vorlesung prog2 = Vorlesung.createVorlesung();
			prog2.setName("Programmiertechnik_2");
			prog2.setEcts(6);
			prog2.setSws(6);
			prog2.setStudiengangs(studiengangAIN);
			prog2.save();

			Vorlesung digitalt = Vorlesung.createVorlesung();
			digitalt.setName("Digitaltechnik");
			digitalt.setEcts(6);
			digitalt.setSws(6);
			digitalt.setStudiengangs(studiengangAIN);
			digitalt.save();

			Vorlesung dbsys1 = Vorlesung.createVorlesung();
			dbsys1.setName("Datenbanksysteme_1");
			dbsys1.setEcts(6);
			dbsys1.setSws(6);
			dbsys1.setStudiengangs(studiengangAIN);
			dbsys1.save();



			//-----------------Vorlesungen WIN-----------------
			Vorlesung bwl = Vorlesung.createVorlesung();
			bwl.setName("Betriebswirtschaftslehre");
			bwl.setEcts(6);
			bwl.setSws(6);
			bwl.setStudiengangs(studiengangWIN);
			bwl.save();

			Vorlesung vwl = Vorlesung.createVorlesung();
			vwl.setName("Volkswirtschaftslehre");
			vwl.setEcts(6);
			vwl.setSws(6);
			vwl.setStudiengangs(studiengangWIN);
			vwl.save();

			Vorlesung mathe1 = Vorlesung.createVorlesung();
			mathe1.setName("Mathematik_1");
			mathe1.setEcts(6);
			mathe1.setSws(6);
			mathe1.setStudiengangs(studiengangWIN);
			mathe1.save();

			Vorlesung prog1win = Vorlesung.createVorlesung();
			prog1win.setName("Programmiertechnik_1");
			prog1win.setEcts(6);
			prog1win.setSws(6);
			prog1win.setStudiengangs(studiengangWIN);
			prog1win.save();

			Vorlesung englisch = Vorlesung.createVorlesung();
			englisch.setName("Englisch");
			englisch.setEcts(6);
			englisch.setSws(6);
			englisch.setStudiengangs(studiengangWIN);
			englisch.save();


			t.commit();
		}
		catch (Exception e) {
			t.rollback();
		}
		
	}
	
	public static void main(String[] args) {
		try {
			Aufgabe1_c Aufgabe1_c = new Aufgabe1_c();
			try {
				Aufgabe1_c.createStudiengangAndVorlesungen();
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

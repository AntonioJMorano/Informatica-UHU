

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class ScriptPraat {
	
	public static void concatenaDif(String audio, ArrayList<String> difonos) {
		try {
			// creamos el fichero dnde escribimos el script para el praat ( para concatenar difonos)
			File f = new File(".\\archivosnecesarios\\concatenaDif.praat");
			//si ya existe borramos y creamos
			if(f.exists()) {
				f.delete();
				f.createNewFile();
			}else // sino creamos
				f.createNewFile();
				
			
			FileWriter w;	// creamos el escritor y lo linkamos al file	
			w = new FileWriter(f);
			
			// va cogiendo difonos de la lista y escribe el comando praat
			//leemos los difonos y los renombramos para tener diferentes ya que si abrimos uno que ya tenemos no se duplica.
			for(int i = 0; i < difonos.size(); i++) {
				String difono = difonos.get(i);
				w.write("Read from file: \".\\difonos\\" + difono + ".wav\"" + System.lineSeparator());
				w.write("select Sound " + difono + System.lineSeparator());
				w.write("Rename... difono_" + (i+1) + System.lineSeparator());
			}
			
			w.write(System.lineSeparator());
			
			// selecciona los sonidos y vamos concatenando
			w.write("select Sound difono_1"+ System.lineSeparator());
			for(int i = 1; i < difonos.size(); i++) {
				w.write("plus Sound difono_" + (i+1) + System.lineSeparator());
			}

			w.write(System.lineSeparator());

			// guarda el resultado
			w.write("Write to WAV file... " + audio);
			
			w.close();
			
			//ejecutamos el script final
			String comando = ".\\archivosnecesarios\\Praat.exe --run " + ".\\archivosnecesarios\\concatenaDif.praat";
			Runtime.getRuntime().exec(comando);
			
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
	
	
}
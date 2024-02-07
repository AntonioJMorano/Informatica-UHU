import java.util.ArrayList;

public class Main {

	public static void main(String[] args) {
		String entrada = " ese meketrefA meketrefe ";
		String salida = "fra.wav";
		
		// elimino espacios delante y detras, pero no los espacios interiores, de la entrada y del archivo salida
		entrada = entrada.trim();
		salida = salida.trim();
		
		//si la entrada cumple las reglas de la gramatica entonces
		if(Gramatica.cumpleReglas( entrada) == true) {
	
			// elimino el punto de fin o la interrogacion
			for (int i = 0; i < entrada.length(); i++) {
				if(entrada.charAt(i)== '?' || entrada.charAt(i)== '.')
				{
					entrada = entrada.substring(0, i);
				}
			}
			//vuelvo a quitar los espacios delante y detras despues de quitar el . o ?
			entrada = entrada.trim();
			// en los espacios intermedios los sustituyo por --, 
			//asi podemos identificar su sonido correspondiente para cuando concatenemos los difonos
			entrada = entrada.replaceAll("( )+", "--");
			
			//Pongo guiones delante y detras de la entrada para ayudarme luego a seleccionar 
			//los difones que no tienen nada delante ni detras.
			entrada = "-" + entrada + "-";
			
			//Voy de dos en dos sacando difonos y añadiendolos a una lista de difonos.
			//al mismo tiempo convierto las mayusculas en mayusculas_ para referirme a las vocales acentuadas
			ArrayList<String> lDifonos = new ArrayList<String>();
			for(int i = 0; i < entrada.length() - 1; i++) {
				String s = entrada.substring(i,i+2);
				s = s.replaceAll("E", "E_");
				s = s.replaceAll("A", "A_");
				lDifonos.add(s);
			}
			//concateno los difonos de la lista y genero el script
			ScriptPraat.concatenaDif(salida, lDifonos);
		}
		
	}
	
}
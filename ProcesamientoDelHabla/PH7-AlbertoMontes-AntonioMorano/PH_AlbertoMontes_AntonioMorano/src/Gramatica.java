import java.util.StringTokenizer;

public class Gramatica {

	public static boolean cumpleReglas(String frase){

            StringTokenizer st = new StringTokenizer(frase, "( )+");
            boolean cumple = true;
            while(st.hasMoreElements() && cumple==true) 
            {
            	String palabra = st.nextToken();
            	if(!cumpleRestriccionesRyS(palabra) || !cumpleAlfabeto(palabra) || !cumpleRestriccionesSilabas(palabra))
            		cumple = false;
            		
            }
            return cumple;
	}


	private static boolean cumpleAlfabeto(String palabra) {
		boolean cumple = true;
		int i = 0;
		while(i <= palabra.length()-1 && cumple == true) {
			
			if(palabra.charAt(i) == 'e' || palabra.charAt(i) == 'E' || palabra.charAt(i) == 'a' || palabra.charAt(i) == 'A' || palabra.charAt(i) == 'm' 
					|| palabra.charAt(i) == 'r' || palabra.charAt(i) == 's' || palabra.charAt(i) == 'k' 
					|| palabra.charAt(i) == 't' || palabra.charAt(i) == 'f' || palabra.charAt(i) == '.' 
					|| palabra.charAt(i) == '?' || palabra.charAt(i) == ' ' )  
				i++;
			else
			{
				cumple = false;
				System.out.println("No cumple el alfabeto de la gramatica");
			}
		}
		return cumple;
	}

	private static boolean cumpleRestriccionesRyS(String palabra) {
		//no puede empezar por  r 
		// una r no puede suceder a una s
		boolean cumple = true;
		int i = 0;
		
		if(palabra.charAt(0) == 'r')
			{
			cumple = false;
			System.out.println("No cumple, empieza por r..");
			}
		
		while(i<palabra.length()-1 && cumple == true) {

			if(palabra.charAt(i) == 'r' && palabra.charAt(i+1) == 's')
			{
				cumple = false;
				System.out.println("No cumple las restricciones, r no puede suceder a una s.");
			}
			i++;
		}
		return cumple;
	}
	private static boolean cumpleRestriccionesSilabas(String palabra) {
		boolean cumple = false;
		String r = palabra.replaceAll("(([aeAE]|([mrs][aeAE](s?))|([kft](r?)[aeAE](s?)))+)", "");
		if (r == "") {
			cumple = true;
		}
		else 
		{
			cumple =false;
			System.out.println("No cumple las restricciones de las silabas");
		}
		
		return cumple;
		
	}
	

}
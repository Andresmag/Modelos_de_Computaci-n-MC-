	/*----- Sección de Declaraciones --------------*/  
%{
#include <iostream>
#include <iomanip>
#include <vector>
#include <string>
using namespace std;

vector<string> nombres;
vector<string> ediciones;
vector<string> precios;

%}

digito	[0-9]
letra		[a-zA-Z]
especial	[:#;]

%%
	/*----- Sección de Reglas ----------------*/  
style=.({especial}|{letra}|{digito})+.>[\b a-zA-Z(),]+<.a><br>			{ bool copia = false; string nombre; for(int i=0; i<yyleng; i++){ if(copia){nombre += yytext[i];} if(isspace(yytext[i])){copia = true;} } nombre.erase(nombre.end()-9,nombre.end()); nombres.push_back(nombre); }
style=.({especial}|{letra}|{digito})+.>[\b a-zA-Z0-9]+<.a>\n		{ bool copia = false; string edicion; for(int i=0; i<yyleng; i++){ if(copia){edicion += yytext[i];} if(yytext[i] == '>'){copia = true;} } edicion.erase(edicion.end()-5,edicion.end()); ediciones.push_back(edicion); }
align=.{letra}+.><strong>[\.,0-9]+				{ bool copia = false; string precio; int coincidencia = 0; for(int i=0; i<yyleng; i++){ if(copia && coincidencia>1){precio += yytext[i];} if(yytext[i] == '>'){copia = true; coincidencia++;} } precios.push_back(precio); }
[^ \t\n]+   { }  
[ \t]+     { }  
\n      { }
  
%%
	/*----- Sección de Procedimientos --------*/  
int main(int argc, char *argv[]){    
	if(argc == 2){          
  		yyin = fopen (argv[1], "rt");          
  		if (yyin == NULL){              
  			printf("El fichero %s no se puede abrir\n", argv[1]);
  			exit (-1);
  		}
  	}
  	else yyin = stdin;
  	  
	yylex();
	for(int i=0; i<nombres.size(); i++){
		cout << left << setw(20) << nombres[i] << "\t" << left << setw(23) << ediciones[i] << "\t" << left << setw(10) << precios[i] << "euros" << endl;
	}
	 
	return 0;  
}

		
		
		
		
		
		

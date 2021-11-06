/*   
 * Creato da Citarella Emanuele - 5°IA
 */
// Import delle librerie principali
import processing.serial.*; 
import java.awt.event.KeyEvent; 
import java.io.IOException;
// Porta seriale
Serial myPort; 
// Angolo e Distanza in "string" per la comunicazione seriale
String angle="";
String distance="";
// Angolo e Distanza convertiti da "string" in "int"
int iAngle, iDistance;
// Dati per la porta seriale
String data=""; 
String noObject;
float pixsDistance;


int motion = 0;                 
int radius = 350;               
int index1=0;
int index2=0;
int radarDist = 0;            
PFont orcFont;
// Impostazione background e comunicazione seriale
void setup() 
{
 // Risoluzione schermo
size (1366, 764); 
 // Bordi anti-aliesed
 smooth();
 // Background nero
 background (0); 
 // Creazione comunicazione seriale
 myPort = new Serial(this,"COM3", 9600); 
 // Lettura dati dalla porta seriale
 myPort.bufferUntil('.'); 
}

void draw() 
{
  fill(0,4); 
  //rect(0, 0, width, height-height*0.065);
  // Funzioni principali
  drawObject();
  drawRadar(); 
  drawText();
}

void serialEvent (Serial myPort) 
{ // Inizio lettura dei dati dalla porta seriale
  // Li legge fino al carattere '.', poi li inserisce nella variabile "data"
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  // Cerca il carattere "," e li inserisce nella variabile "index1"
  index1 = data.indexOf(","); 
  // Legge i dati ricevuti dalla posizione 0 fino alla posizione della "index1"
  angle = data.substring(0, index1);
  // Legge i dati dalla posizione della "index1" fino alla fine
  distance = data.substring(index1+1, data.length()); 
  // Conversione delle variabili "Angle" e "Distance" da String ad integer
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar()
{
  // Salva lo stato delle trasformazioni
  // push e pop consentono di spostare le coordinate facendo in modo
  // che x e y siano uguali a 0
  pushMatrix();
  // Muove le coordinate iniziali fino al nuovo punto
  translate(width/2,height-height*0.074); 
  // Specifica una quantità per piazzare oggetti all'interno dello schermo
  stroke(98,245,31);
  line(-width/2,0,width/2,0);
  // Interfaccia radar
  // Linee
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  //line((-width/2)*cos(radians(30)),0,width/2,0);
  // Richiama le trasformazioni effettuate
  popMatrix();
}

void drawObject()
{
  // Salva lo stato della trasformazione
  pushMatrix();
  // Linea dell'oggetto individuato
  translate(width/2,height-height*0.074); 
  // Colore bianco
  stroke(255,255,255); 
  // Distanza che il sensore rivela in centimetri
  pixsDistance = iDistance*((height-height*0.1666)*0.025); 
  // Limito il range di visualizzazione a 40 cm
  if(iDistance<40)
  {
  // Disegna la linea se viene individuato un oggetto
  line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),(width-width*0.505)*cos(radians(iAngle)),-(width-width*0.505)*sin(radians(iAngle)));
  }
  
  if(iAngle==15)
  {
  // Permette di "pulire" il radar dopo il giro effettuato
  clear();
  }
  // Richiama trasformazioni
  popMatrix();
}

void drawText() 
{ 
  pushMatrix();
  // Verifichiamo se l'oggetto si trova all'interno del range
  if(iDistance>40)
  {
  // Se fuori range, comparirà questo
  noObject = "Fuori Range";
  }
  else 
    {
    // Altrimenti comparirà questo
    noObject = "In Range";
    }
  // Colore
  fill(0,0,0);
  // Attivazione motion blur
  noStroke();
  // Disegna il rettangolo
  rect(0, height-height*0.0648, width, height);
  // Colore
  fill(98,245,31);
  // Dimensione del testo
  textSize(25);
 
  text("Oggetto: " + noObject, width-width*0.875, height-height*0.0277);
  text("Angolo: " + iAngle +" °", width-width*0.48, height-height*0.0277);
  // Ci viene mostrata la distanza attuale dal'oggetto
  text("Distanza: ", width-width*0.26, height-height*0.0277);
  if(iDistance>40)
  {
  text("No Distance ", width-width*0.12, height-height*0.0262);
  }else
  {
  text(iDistance + " cm", width-width*0.12, height-height*0.0277);
  }  
  
  textSize(25);
  //fill(98,245,60);
  translate((width-width*0.4994)+width/2*cos(radians(30)),(height-height*0.0907)-width/2*sin(radians(30)));
  rotate(-radians(-60));
  text("30°",0,0);
  resetMatrix();
  translate((width-width*0.503)+width/2*cos(radians(60)),(height-height*0.0888)-width/2*sin(radians(60)));
  rotate(-radians(-30));
  text("60°",0,0);
  resetMatrix();
  translate((width-width*0.507)+width/2*cos(radians(90)),(height-height*0.0833)-width/2*sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  translate(width-width*0.513+width/2*cos(radians(120)),(height-height*0.07129)-width/2*sin(radians(120)));
  rotate(radians(-30));
  text("120°",0,0);
  resetMatrix();
  translate((width-width*0.5104)+width/2*cos(radians(150)),(height-height*0.0574)-width/2*sin(radians(150)));
  rotate(radians(-60));
  text("150°",0,0);
  popMatrix(); 
}

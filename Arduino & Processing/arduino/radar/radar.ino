// Libreria Servo
#include <Servo.h>
#include <LiquidCrystal.h>
// Pin per il sensore ad ultrasuoni
const int trigPin = 9;
const int echoPin = 10;
// Variabili principali
int distanza;
long durata;
// Variabile per il motore Servo
Servo Servo1;
// Inizializzione dei pin e del servo 
LiquidCrystal lcd(12, 11, 5, 4, 3, 2); 
void setup() 
{
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT);
  // Comunicazione seriale
  Serial.begin(9600);
  // Pin del servo
  Servo1.attach(13); 
  lcd.begin(16, 2);
 
 
// Visualizziamo un messaggio sul display

}

void loop() 
{
  // Rotazione del servo da 15 gradi fino a 165
  for(int i=15;i<165;i++)
  {  
  // Scrittura dei valori
  Servo1.write(i);
    
  delay(50);
  // Funzione per calcolare la distanza
  distanza = calcolaDistanza();
  // Invio dei dati sulla porta seriale
  Serial.print(i);
  Serial.print(","); 
  Serial.print(distanza); 
  Serial.print("."); 
  lcd.setCursor(0, 0); 
    lcd.print("Grado =");
  lcd.print(i);
  lcd.setCursor(0,1);
  lcd.print("Distanza =");
  if(distanza<40)
  {
  lcd.print("Y"); 
  }else {lcd.print("N");}
  }
  // Tempo di attesa prima di rifare il giro al contrario
  delay(2000);
  
  for(int i=165;i>15;i--)
  {  
    
  Servo1.write(i);
 
  delay(50);
  distanza = calcolaDistanza();

  Serial.print(i); 
  Serial.print(","); 
  Serial.print(distanza);
  Serial.print("."); 
   lcd.setCursor(0, 0); 
    lcd.print("Grado =");
  lcd.print(i);
  if(i<=100)
  {
  lcd.setCursor(9,0);
  lcd.print(" ");
  }
  lcd.setCursor(0,1);
  lcd.print("Distanza =");
  if(distanza<40)
  {
  lcd.print("Y"); 
  }else {lcd.print("N");}

 
  
  }
  delay(4000);
}

// Funzione per ottenere la distanza calcolata dal sensore
int calcolaDistanza()
{ 
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  durata = pulseIn(echoPin, HIGH);
  distanza = durata*0.034/2;
  return distanza;
}

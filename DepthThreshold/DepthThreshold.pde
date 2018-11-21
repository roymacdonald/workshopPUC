//Cargamos librerias de kinect
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
// Cargamos librerias de video
import processing.video.*;

Movie mov;
Kinect kinect;

// declaramos una imagen, depthImg, que nos servira para almacenar los pixeles que estan dentro del rango minDepth y maxDepth
PImage depthImg;

//almacenaremos los valores minimo y maximo de profundidad donde queremos interactuar
int minDepth =  690;
int maxDepth = 910;
// almacenamos la distancia minima que lee la kinect dentro de el rango definido por minDepth y maxDepth. 
int distanciaMinima = 2047;

// Almacenamos el indice del pixel que tiene la distancia minima.
int indiceMinimo;

void setup() {
  //tamaño de nuestra ventana.
  size(1280, 900);

  //Iniciamos la kinect
  kinect = new Kinect(this);
  kinect.initDepth();

  // creamos la imagen y definimos que su tamaño sea igual a de la kinect.
  depthImg = new PImage(kinect.width, kinect.height);

  //cargamos el video
  mov = new Movie(this, "transit.mov");
  // pausamos el video y cargamos su primer cuadro
  mov.play();
  mov.jump(0);
  mov.pause();
}

void draw() {
  // Draw the raw image

  image(kinect.getDepthImage(), 0, 0);

  // buscamos el indice en donde la distancia es la menor y que esta dentro de los rangos de minDepth y maxDepth

  int[] rawDepth = kinect.getRawDepth();  
  distanciaMinima = 2047;
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(255);
      if (rawDepth[i] < distanciaMinima) {
        distanciaMinima = rawDepth[i];
        indiceMinimo = i;
      }
      distanciaMinima = min(distanciaMinima, rawDepth[i]);
    } else {
      depthImg.pixels[i] = color(0);
    }
  }

  depthImg.updatePixels();

  image(depthImg, kinect.width, 0);


  //lo siguiente es para encontrar las coordenadas en pixeles del indiceMinimo.
  int x = indiceMinimo%kinect.width;
  int y = (int)indiceMinimo/kinect.width;


  fill(255, 0, 0);
  ellipse(x, y, 30, 30);

  // dibujamos el cuadro del video que corresponde a la distancia minima.
  float movFrame = 0;
  if (mov.available()) {
    mov.read();
    if ( minDepth < maxDepth) { // minDepth y maxDepth no pueden ser iguales
      distanciaMinima = constrain(distanciaMinima, minDepth, maxDepth);
      movFrame = map(distanciaMinima, minDepth, maxDepth, 0, mov.duration());
      mov.play();
      mov.jump(movFrame);
      mov.pause();
      image(mov, 0, kinect.height);
    }
  }  

  // Lo siguiente es texto que se mostrara en la pantalla como ayuda.
  fill(255);
  text("Min THRESHOLD: " + minDepth + " cambiar con teclas a y s", 10, 30);
  text("Max THRESHOLD: " + maxDepth + " cambiar con teclas z y x", 10, 50);  
  text("Distancia Minima: " + distanciaMinima, 10, 70);
  text("movFrame: " +  movFrame, 10, 90);
  text("movDuration: " +  mov.duration(), 10, 110);
}

// Adjust the angle and the depth threshold min and max
void keyPressed() { 
  if (key == 'a') {
    minDepth = constrain(minDepth+10, 0, maxDepth);
  } else if (key == 's') {
    minDepth = constrain(minDepth-10, 0, maxDepth);
  } else if (key == 'z') {
    maxDepth = constrain(maxDepth+10, minDepth, 2047);
  } else if (key =='x') {
    maxDepth = constrain(maxDepth-10, minDepth, 2047);
  }
}

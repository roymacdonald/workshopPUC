import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

Movie[] movs;

void setup() {
  size(1000, 800);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }      

  
   movs = new Movie[2];
  movs[0] = new Movie(this, "fingers.mov");
  movs[1] = new Movie(this, "transit.mov");

  for (int i = 0; i < movs.length; i++) {
    movs[i].loop();
    movs[i].play();
    movs[i].jump(0);
    movs[i].pause();
  }
  


  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  //scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);

  Rectangle[] faces = opencv.detect();

  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  int x = 0;
  for(int i = 0; i < movs.length && i < faces.length; i++){
  if (movs[i].available()) {
      movs[i].read();
      float f = map(faces[0].x, 0, video.width, 0, movs[i].duration());
      movs[i].play();
      movs[i].jump(f);
      movs[i].pause();
  }
  
    image(movs[i], x, video.height);
    x += movs[i].width;
  }
}

void captureEvent(Capture c) {
  c.read();
}

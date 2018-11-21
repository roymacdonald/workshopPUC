import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

Movie mov;

void setup() {
  size(1000, 480);

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

  mov = new Movie(this, "transit.mov");
  mov.play();
  mov.jump(0);
  mov.pause();
  

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
  
  if (mov.available()) {
    if (faces.length > 0) {
      mov.read();
      float f = map(faces[0].x, 0, video.width, 0, mov.duration());
      println(f);
      mov.play();
      mov.jump(f);
      mov.pause();
    }
  }
  image(mov, video.width, 0);
}

void captureEvent(Capture c) {
  c.read();
}

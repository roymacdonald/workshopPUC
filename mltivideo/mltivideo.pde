import processing.video.*;

Movie mov;
Movie mov1;
Movie mov2;
Movie mov3;
Movie mov4;
Movie mov5;
Movie mov6;
Movie mov7;
Movie mov8;


void setup() {
  size(640, 360);
  background(0);

  mov = new Movie(this, "transit.mov");
  mov1 = new Movie(this, "fingers.mov");
  mov2 = new Movie(this, "1.mov");
  mov3 = new Movie(this, "2.mov");
  //mov4 = new Movie(this, "3.mov");
  //mov5 = new Movie(this, "4.mov");
  //mov6 = new Movie(this, "5.mov");
  //mov7 = new Movie(this, "6.mov");
  //mov8 = new Movie(this, "7.mov");



  mov.loop();
  mov1.loop();
  mov2.loop();
  mov3.loop();
  //mov4.loop();
  //mov5.loop(); 
  //mov6.loop();
  //mov7.loop();
  //mov8.loop();

  mov.play();
  mov1.play();
  mov2.play();
  //mov3.play();
  //mov4.play();
  //mov5.play(); 
  //mov6.play();
  //mov7.play();
  //mov8.play();
}

void draw() {

  //if (mousePressed) {
  if (keyPressed) {
    if (key == 'b' ) {
      if (mov.available()) {
        background(0);
        mov.read();
        image(mov, 0, 0);
      }
    }if (key == '1' ) {
       if (mov1.available()) {
         background(0);
         mov1.read();
         image(mov1, 0, 0);
       }
     }else if (key == '2' ) {
      if (mov2.available()) {
        background(0);
        mov2.read();
        image(mov2, 0, 0);
      }
    }else 
    if (key == '3') {
      if (mov3.available()) {
        background(0);
        mov3.read();
        image(mov3, 0, 0);
      }
    } else {
      if (mov1.available()) {
        background(0);
        mov1.read();
        image(mov1, 0, 0);
      }
    }
  } else {
    background(0);
  }
}

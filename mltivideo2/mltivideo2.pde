import processing.video.*;

Movie[] movs;


void setup() {
  size(640, 360);
  background(0);
  movs = new Movie[2];
  movs[0] = new Movie(this, "fingers.mov");
  movs[1] = new Movie(this, "transit.mov");

  for (int i = 0; i < movs.length; i++) {
    //movs[i] = new Movie(this, (i+1)+".mov");
    movs[i].loop();
  }
}

void draw() {
  if (keyPressed) {
    if (key >= '1' && key <= '2' ) {
      int indice = key - '1';
      if (movs[indice].available()) {
        background(0);
        movs[indice].read();
        float f = map(mouseX, 0, width, 0, movs[indice].duration());
        movs[indice].play();
        movs[indice].jump(f);
        movs[indice].pause();
        image(movs[indice], 0, 0);
      }
    }
  } else {
    background(0);
  }
}

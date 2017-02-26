int wormCount = 100;
float speed = 5;
XYZWorm[] worms = new XYZWorm[wormCount];

void setup() {
  fullScreen(P3D);
  
  for (int i = 0; i < worms.length; i++) {
    worms[i] = new XYZWorm(floor(random(-100, 100)), floor(random(-100, 100)), floor(random(-100, 100)));
  }
}

void draw() {
  
  background(0);
  
  translate(width/2, height/2);
  
  for (int i = 0; i < worms.length; i++) {
    worms[i].move();
  }
}

class XYZWorm {
  
  float xpos, ypos, zpos;
  color col;
  
  float[][] body = new float[10][3];
  
  XYZWorm (float x, float y, float z) {
    xpos = x;
    ypos = y;
    zpos = z;
    
    colorMode(HSB, 255);
    col = color(floor(random(255)), 127, 255);
    
    for (int i=0; i < body.length; i++) {
      body[i][0] = x;
      body[i][1] = y;
      body[i][2] = z;
    }
  }
  
  void move() {
    int direction = floor(random(6));
    
    switch(direction) {
      case 0:
        xpos += speed;
        break;
      case 1:
        xpos -= speed;
        break;      
      case 2:
        ypos += speed;
        break;      
      case 3:
        ypos -= speed;
        break;      
      case 4:
        zpos += speed;
        break;      
      case 5:
        zpos -= speed;
        break;
    }
    
     // a linked list could be more efficient here
    //import java.util.*;
    //LinkedList list = new LinkedList();
    
    for (int i = body.length - 1; i > 0; i--) {
      body[i][0] = body[i-1][0];
      body[i][1] = body[i-1][1];
      body[i][2] = body[i-1][2];
    }
    body[0][0] = xpos;
    body[0][1] = ypos;
    body[0][2] = zpos; 
    
    this.draw();
  }
  
  void draw() {
    strokeWeight(2);
    stroke(col);

    for (int i = body.length - 1; i > 0; i--) {
      line(body[i][0], body[i][1], body[i][2], body[i-1][0], body[i-1][1], body[i-1][2]);
    }
  }
}
int wormCount = 100;
float speed = 5;
XYZWorm[] worms = new XYZWorm[wormCount];

float camera_angle = HALF_PI;
float camera_x = 0;
float camera_y = -300;
float camera_z = 0;
float radius = 500;

float subject_x = 0;
float subject_y = 0;
float subject_z = 0;

void setup() {
  fullScreen(P3D);
  
  for (int i = 0; i < worms.length; i++) {
    worms[i] = new XYZWorm(floor(random(-100, 100)), floor(random(-100, 100)), floor(random(-100, 100)));
  }
}

void draw() {
  
  move_camera();
  
  background(0);
  
  for (int i = 0; i < worms.length; i++) {
    worms[i].move();
  }
  
  draw_cube();
}

void move_camera() {
  camera_x = radius * cos(camera_angle);
  camera_z = radius * sin(camera_angle);
  
  camera(camera_x, camera_y, camera_z, // camera position
          subject_x, subject_y, subject_z, // pointing at
          0, 1, 0); // choose 'up'
          
  camera_angle += 0.003;
}

void draw_cube() {
  stroke(255);
  noFill();
  box(200);
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
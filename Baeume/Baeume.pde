Wald wald;
float bx,by;
float xOffset,yOffset;
boolean locked;
float windowX,windowY;

void setup(){
  size(displayWidth/2,displayHeight/2);
  windowX=  displayWidth/2;
  windowY=displayHeight/2;
  
 
  //bx=windowX/2;
  //by=windowY/2;
  xOffset=0.0;
  yOffset=0.0;
  frameRate(5);
  
  wald = new Wald("Baumbestand_Baum1.geojson");
  wald.setCenter(2609987.165,1268536.38); 
  wald.setScale(1.0);
}


void draw(){
  background(220);
  pushMatrix();

  wald.draw();
  popMatrix();
  wald.info();
}

void mousePressed() {
  locked=true;
  xOffset = -mouseX/wald.scale-wald.centerX; 
  yOffset = +mouseY/wald.scale-wald.centerY; 
}

void mouseDragged() {
  if(locked) {
    //bx= mouseX - (mouseX_old-bx)
    //bx = mouseX-xOffset; 
    //by = mouseY-yOffset;
    wald.setCenter(-mouseX/wald.scale-xOffset,+mouseY/wald.scale-yOffset); 
  }
}

void mouseReleased() {
  locked = false;
}


 void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e<0){
    wald.setScale(wald.scale*1.2);
  }else{
    wald.setScale(wald.scale/1.2);
  }
}
 


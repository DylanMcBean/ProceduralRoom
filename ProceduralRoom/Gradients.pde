ArrayList<color[]> Gradients = new ArrayList<color[]>();
color[] gradient_1 = new color[2];
color[] gradient_2 = new color[2];
color[] gradient_transition = new color[2];
float transition_amount = 1;
int gradient_index = 0;

void setGradients(){
  Gradients.add(new color[]{color(#2C5364),color(#0F2027)}); /*Moonlit Asteroid*/
  Gradients.add(new color[]{color(#99f2c8),color(#1f4037)}); /*Harvey*/
  Gradients.add(new color[]{color(#c31432),color(#240b36)}); /*Witching Hour*/
  Gradients.add(new color[]{color(#cc5333),color(#23074d)}); /*Taran Tado*/
  Gradients.add(new color[]{color(#EB5757),color(#000000)}); /*Coal*/
  Gradients.add(new color[]{color(#44A08D),color(#093637)}); /*Orca*/
  Gradients.add(new color[]{color(#34e89e),color(#0f3443)}); /*Pacific Dream*/
  Gradients.add(new color[]{color(#cbb4d4),color(#20002c)}); /*Purplepine*/
  Gradients.add(new color[]{color(#F0C27B),color(#4B1248)}); /*Starfall*/
  Gradients.add(new color[]{color(#FFA17F),color(#00223E)}); /*Predawn*/
}


void background_gradient(){
  
  if (transition_amount >= 1) {
    transition_amount = 0;
    gradient_1 = Gradients.get(gradient_index);
    gradient_2 = Gradients.get((gradient_index+1)%Gradients.size());
    gradient_index = (gradient_index+1)%Gradients.size();
  }
  gradient_transition[0] = color(map(transition_amount,0,1,red(gradient_1[0]),red(gradient_2[0])),map(transition_amount,0,1,green(gradient_1[0]),green(gradient_2[0])),map(transition_amount,0,1,blue(gradient_1[0]),blue(gradient_2[0])));
  gradient_transition[1] = color(map(transition_amount,0,1,red(gradient_1[1]),red(gradient_2[1])),map(transition_amount,0,1,green(gradient_1[1]),green(gradient_2[1])),map(transition_amount,0,1,blue(gradient_1[1]),blue(gradient_2[1])));
  
  transition_amount += 0.01;
  
  setGradient(0, 0, width, height, color(gradient_transition[0]), color(gradient_transition[1]), 1); 
}


void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == 1) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == 2) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}



void underlay_effect(){
  noStroke();
  for(int y = 0; y < height; y += 5){
   color c = color(noise(frameCount)*50,noise(frameCount/(y+1))*50,noise(frameCount%(y+1))*50,noise(frameCount*y)*10);
   fill(c);
   rect(0,y,width,10);
  }
  
  
  loadPixels();
  for(int y = 0; y < height; y ++) {
   for(int x = 0; x < width; x ++) {
     int index = x+y*width;
     float r = red(pixels[index]);
     float g = green(pixels[index]);
     float b = blue(pixels[index]);
     float dist = 1-dist(width/2,height/2,x,y)/(width*2);
     pixels[index] = color((r*dist),(g*dist),(b*dist));
   }
  }
  updatePixels();
}

void overlay_effect(){
  for(int y = 0; y < height; y ++){
   color c = color(map(int(random(0,4)),0,4,0,255),random(200,255));
   stroke(c);
   if (int(random(0,5000))==0) line(random(0,width),y,random(width),y);
  }
  
  PFont font = createFont("data/VPPixel-Simplified.otf",60);
  textSize(60);
  textAlign(CENTER,CENTER);
  textFont(font);
  
  pushMatrix();
  fill(40,170,200,100);
  translate((width/2)+(random(-5,5)/(frameCount%60/20)),50+(random(-5,5)/(frameCount%30/20)));
  rotate(sin(frameCount/10.0)*0.02);
  text("Procedural Generation",0,0);
  popMatrix();
  
  pushMatrix();
  fill(200,90,60,100);
  translate((width/2)+(random(-5,5)/(frameCount%70/20)),50+(random(-5,5)/(frameCount%80/20)));
  rotate(sin(frameCount/11.0)*0.05);
  text("Procedural Generation",0,0);
  popMatrix();
  
  pushMatrix();
  fill(255,150);
  translate(width/2,50);
  rotate(sin(frameCount/9.0)*0.01);
  text("Procedural Generation",0,0);
  popMatrix();
}

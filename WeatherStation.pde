import java.util.Calendar;

WeatherCanvas W;

PGraphics pg;

void setup() {
  size( 1366, 768 );
  W = new WeatherCanvas(width,height);
}


void draw() {
  float factor = 0.000001;
  bgColor = lerpColor( bgColor , hsbColor( 360*6*noise(millis()*factor) , noise(millis()*factor+100) , noise(millis()*factor+20)  ) , 0.1 );
  background( bgColor );
  W.update();
  image( W.buf , 0 , 0 );
  if( frameCount%100 == 0) {
    println( frameRate );
  }
}
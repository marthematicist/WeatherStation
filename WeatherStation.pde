import java.util.Calendar;

WeatherCanvas W;

PGraphics pg;

void setup() {
  size( 1280, 720 );
  W = new WeatherCanvas(width,height);
}


void draw() {
  background(bgColor);
  W.update();
  image( W.buf , 0 , 0 );
}
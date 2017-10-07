class Icons {
  int numIcons = 14;
  int w;
  int h;
  PGraphics[] img;
  color c;
  String[] iconNames = { "clear-day", "clear-night", "rain", "snow", "sleet", "wind", "fog", 
                         "cloudy", "partly-cloudy-day", "partly-cloudy-night" , "hail", "thunderstorm", "tornado" };
  
  Icons( int win , int hin , color cin ) {
    this.w = win;
    this.h = hin;
    this.c = cin;
    float r = red(cin);
    float g = green(cin);
    float b = blue(cin);
    this.img = new PGraphics[numIcons];
    for( int i = 0 ; i < numIcons-1 ; i++ ) {
      this.img[i] = createGraphics( w , h );
      PShape ico = loadShape( "icons/" + iconNames[i] + ".svg" );
      this.img[i].beginDraw();
      this.img[i].tint(0);
      this.img[i].shape( ico, -0.2*w, -0.2*h, 1.40*w, 1.40*h );
      this.img[i].endDraw();
      this.img[i].loadPixels();
      for( int p = 0 ; p < this.img[i].height*this.img[i].width ; p++ ) {
        color c = this.img[i].pixels[p];
        float al = alpha(c);
        c = color( r , g , b , al );
        this.img[i].pixels[p] = c;
      }
      this.img[i].updatePixels();
      this.img[i].endDraw();
    }
    this.img[13] = createGraphics( w , h );
  }
  
  Icons( float win , float hin , color cin ) {
    this.w = round(win);
    this.h = round(hin);
    this.c = cin;
    float r = red(cin);
    float g = green(cin);
    float b = blue(cin);
    this.img = new PGraphics[numIcons];
    for( int i = 0 ; i < numIcons-1 ; i++ ) {
      this.img[i] = createGraphics( w , h );
      PShape ico = loadShape( "icons/" + iconNames[i] + ".svg" );
      this.img[i].beginDraw();
      this.img[i].tint(0);
      this.img[i].shape( ico, -0.2*w, -0.2*h, 1.40*w, 1.40*h );
      this.img[i].endDraw();
      this.img[i].loadPixels();
      for( int p = 0 ; p < this.img[i].height*this.img[i].width ; p++ ) {
        color c = this.img[i].pixels[p];
        float al = alpha(c);
        c = color( r , g , b , al );
        this.img[i].pixels[p] = c;
      }
      this.img[i].updatePixels();
      this.img[i].endDraw();
    }
  }
  
  PGraphics get( String s ) {
    PGraphics out = img[numIcons-1];
    for( int i = 0 ; i < numIcons-1 ; i++ ) {
      if( s.equals( iconNames[i] ) ) {
        out = img[i];
      }
    }
    return out;
  }
  
}
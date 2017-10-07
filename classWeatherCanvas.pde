class WeatherCanvas {
  PGraphics buf;
  WeatherData weather;
  Icons iconsSmall;
  Icons iconsSmallShadow;
  Icons iconsLarge;
  Icons iconsLargeShadow;
  PFont OpenSansLight;
  Calendar nextUpdateTime;

  WeatherCanvas( int w, int h ) {
    buf = createGraphics( w, h );
    OpenSansLight = createFont( "OpenSans-Regular.ttf", 45);
    weather = new WeatherData( "weatherSettings.txt" );
    float wi = 0.06*w;
    iconsSmall = new Icons( wi, wi, drawColor );
    iconsSmallShadow = new Icons( wi, wi, drawColorShadow );
    wi = 0.25*w;
    iconsLarge = new Icons( wi, wi, drawColor );
    iconsLargeShadow = new Icons( wi, wi, drawColorShadow );
    nextUpdateTime = Calendar.getInstance();
  }

  void drawCurrentConditions(float x, float y, float w, float h, color c, Icons ico) {
    buf.image( ico.get(weather.current.icon), x-0.5*iconsLarge.w, y - 0.25*iconsLarge.h );
  }
  
  
  void drawDayForecast( int day, float x, float y, float w, float h, color c, Icons ico ) {
    buf.image( ico.get(weather.weekForecast[day].icon), x-0.5*iconsSmall.w, y - 0.25*h );
    buf.noFill();
    buf.stroke( c );
    buf.noFill();
    float cr = 0.15*w;
    buf.strokeWeight( 0.01*w );
    //buf.rect( x-0.5*ico.w, y-0.25*h, ico.w, ico.h  );
    //buf.rect( x-0.5*w, y-0.5*h, w, h, cr, cr, cr, cr );
    buf.fill(c);
    buf.textFont(OpenSansLight);
    buf.textAlign( CENTER, CENTER );
    buf.textSize( 0.18*h );
    String dayString = DayOfWeekStringsShort[(weather.weekForecast[day].date.get(Calendar.DAY_OF_WEEK))] + "  " + weather.weekForecast[day].date.get(Calendar.DATE) ;
    buf.text( dayString, x, y-0.40*h );
    String tempString = round(weather.weekForecast[day].temperatureHigh) + "\u00B0 " + round(weather.weekForecast[day].temperatureLow) +  "\u00B0" ;
    buf.textSize( 0.15*h );
    buf.text( tempString, x+0.04*w, y+0.175*h );
    tempString = round( 100*weather.weekForecast[day].precipProbability ) + "%" ;
    buf.textSize( 0.12*h );
    buf.text( tempString, x+0.15*w, y+0.37*h );
    buf.noFill();
    buf.strokeWeight( 0.015*w );
    buf.ellipse( x-0.15*w, y+0.39*h, 0.2*w, 0.2*w );
    float ang = weather.weekForecast[day].windBearing/180*PI;
    float r1 = 0.5*0.17*w;
    float r2 = 0.5*0.23*w;
    buf.line( x-0.15*w + r1*cos(ang), y+0.39*h + r1*sin(ang), x-0.15*w + r2*cos(ang), y+0.39*h + r2*sin(ang) );
    buf.textSize( 0.10*h );
    buf.text( round(weather.weekForecast[day].windSpeed), x-0.15*w, y+0.37*h );
  }

  void update() {
    Calendar currentTime = Calendar.getInstance();
    if ( currentTime.after( nextUpdateTime ) ) {
      nextUpdateTime = Calendar.getInstance();
      nextUpdateTime.add( Calendar.SECOND, 5*60 );
      weather.FetchWeather();
      buf.beginDraw();
      buf.clear();
      float w = width/7.0;
      for ( int i = 1; i<7; i++ ) {
        float x = (i)*w;
        drawDayForecast( i, x, 0.8*height, w, 0.3*height, drawColorShadow, iconsSmallShadow );
      }
      drawCurrentConditions( 0.18*width, 0.2*height, 0.15*width, 0.3*height, drawColorShadow, iconsLargeShadow );
      buf.filter(BLUR, 0.003*width );
      for ( int i = 1; i<7; i++ ) {
        float x = (i)*w;
        drawDayForecast( i, x, 0.8*height, w, 0.3*height, drawColor, iconsSmall );
      }
      drawCurrentConditions( 0.18*width, 0.2*height, 0.15*width, 0.3*height, drawColor, iconsLarge );
      buf.endDraw();
      
    }
  }
}
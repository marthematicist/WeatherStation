Boolean logoutWeatherData = true;
Boolean liveData = false;

class WeatherData {
  String APIKey;
  
  
  // Settings Data
  JSONObject settingsJSON;
  float latitude;
  float longitude;
  String API_key;
  String weatherURL;
  
  // Weather Data
  JSONObject weatherJSON;
  Calendar weatherDate;
  HourConditions current;
  DayConditions[] weekForecast;
  
  WeatherData( String settingsFile ) {
    // load settings
    settingsJSON = loadJSONObject( settingsFile );
    latitude = settingsJSON.getFloat( "latitude" );
    longitude = settingsJSON.getFloat( "longitude" ) ;
    API_key = settingsJSON.getString( "API_key" ) ;
    weatherURL = "https://api.darksky.net/forecast/" + API_key + "/" + nf(latitude) + "," + nf(longitude) + "?exclude=minutely" ;
    if( logoutWeatherData ) {
      println( "=================================================================" );
      println( "SETTINGS LOADED..." );
      println( "latitude = " + nf(latitude) + "    longitude = " + longitude + "     API_key = " + API_key );
      println( "weatherURL = " + weatherURL );
    }
    // get and set weather data
    FetchWeather();
    weatherDate = Calendar.getInstance();
    weatherDate.setTimeInMillis((long)weatherJSON.getJSONObject("currently").getInt("time")*1000);
    // get current conditions
    current = new HourConditions( weatherJSON.getJSONObject("currently") );
    // get week forecast
    weekForecast = new DayConditions[7];
    for( int i = 0 ; i < 7 ; i++ ) {
      weekForecast[i] = new DayConditions( weatherJSON.getJSONObject("daily").getJSONArray("data").getJSONObject(i) );
    }
    if( logoutWeatherData ) {
      logout();
    }
  }
  
  void logout() {
    println( "=================================================================" );
    println( "SETTINGS LOADED..." );
    println( "latitude = " + nf(latitude) + "    longitude = " + longitude + "     API_key = " + API_key );
    println( "weatherURL = " + weatherURL );
    println( "Last weather update: " + weatherDate.getTime() );
    println( "=================================================================" );
    println( "CURRENT CONDITIONS..." );
    current.print();
    println( weatherJSON.getJSONObject("daily").getJSONArray("data").getJSONObject(0).getInt("time") );
    println( "=================================================================" );
    println( "WEEK FORECAST..." );
    for( int i = 0 ; i < 7 ; i++ ) {
      weekForecast[i].print();
    }
    
  }
  
  
  void FetchWeather() {
    if( liveData ) {
      try {
        weatherJSON = loadJSONObject( weatherURL );
        saveJSONObject( weatherJSON ,  "mostRecentWeather.json" );
      } catch( Exception e ) {
        weatherJSON = loadJSONObject( "mostRecentWeather.json" );
      }
    } else {
      weatherJSON = loadJSONObject(  "mostRecentWeather.json" );
    }
  }
  
  
  class HourConditions {
    int time;
    Calendar date;
    String summary;
    float precipProbability;
    float visibility;
    float windGust;
    String icon;
    float cloudCover;
    float windBearing;
    float apparentTemperature;
    float pressure;
    float dewPoint;
    float ozone;
    float temperature;
    float humidity;
    float uvIndex;
    float windSpeed;
    
    HourConditions() {
    }
    
    HourConditions( JSONObject w ) {
      this.time = w.getInt("time");
      this.date = Calendar.getInstance();
      this.date.setTimeInMillis((long)this.time*1000);
      this.summary = w.getString("summary");
      this.precipProbability = w.getFloat("precipProbability");
      this.visibility = w.getFloat("visibility");
      this.windGust = w.getFloat("windGust");
      this.icon = w.getString("icon");
      this.cloudCover = w.getFloat("cloudCover");
      this.windBearing = w.getFloat("windBearing");
      this.apparentTemperature = w.getFloat("apparentTemperature");
      this.pressure = w.getFloat("pressure");
      this.dewPoint = w.getFloat("dewPoint");
      this.ozone = w.getFloat("ozone");
      this.temperature = w.getFloat("temperature");
      this.humidity = w.getFloat("humidity");
      this.uvIndex = w.getFloat("uvIndex");
      this.windSpeed = w.getFloat("windSpeed");
    }
    
    void print() {
      println( "Conditions for " + date.getTime() + "  ---------  " +  "summary: " , summary );
      println( "icon: " + icon + "\t temperature: " + temperature + "\t apparentTemperature: " , apparentTemperature + "\t humidity: " + humidity +  "\t precipProbability: " + precipProbability );
      println( "windSpeed: " + windSpeed , "\t windBearing: " + windBearing + "\t windGust: " + windGust );
      println( "cloudCover: " + cloudCover , "\t visibility: " + visibility + "\t pressure: " + pressure + "\t dewPoint: " + dewPoint + "\t ozone: " + ozone + "\t uvIndex: " + uvIndex );
    }
    
    HourConditions copy() {
      HourConditions that = new HourConditions();
      that.time = this.time;
      that.date = (Calendar) this.date.clone();
      that.summary = this.summary;
      that.precipProbability = this.precipProbability;
      that.visibility = this.visibility;
      that.windGust = this.windGust;
      that.icon = this.icon;
      that.cloudCover = this.cloudCover;
      that.windBearing = this.windBearing;
      that.apparentTemperature = this.apparentTemperature;
      that.pressure = this.pressure;
      that.dewPoint = this.dewPoint;
      that.ozone = this.ozone;
      that.temperature = this.temperature;
      that.humidity = this.humidity;
      that.uvIndex = this.uvIndex;
      that.windSpeed = this.windSpeed;
      return that;
    }
    
  } 
  
  class DayConditions {
    int time;
    Calendar date;
    String summary;
    float precipProbability;
    float visibility;
    float windGust;
    String icon;
    float cloudCover;
    float windBearing;
    float pressure;
    float dewPoint;
    float ozone;
    float temperature;
    float humidity;
    float uvIndex;
    float windSpeed;
    
    float temperatureHigh;
    float temperatureLow;
    float precipIntensity;
    float precipAccumulation;
    float moonPhase;
    Calendar temperatureLowTime;
    Calendar temperatureHighTime;
    Calendar sunriseTime;
    Calendar sunsetTime;
    
    DayConditions() {
    }
    
    DayConditions( JSONObject w ) {
      this.time = w.getInt("time");
      this.date = Calendar.getInstance();
      this.date.setTimeInMillis((long)this.time*1000);
      this.summary = w.getString("summary");
      this.precipProbability = w.getFloat("precipProbability");
      this.windGust = w.getFloat("windGust");
      this.icon = w.getString("icon");
      this.cloudCover = w.getFloat("cloudCover");
      this.windBearing = w.getFloat("windBearing");
      this.pressure = w.getFloat("pressure");
      this.dewPoint = w.getFloat("dewPoint");
      this.ozone = w.getFloat("ozone");
      this.humidity = w.getFloat("humidity");
      this.uvIndex = w.getFloat("uvIndex");
      this.windSpeed = w.getFloat("windSpeed");
      
      temperatureHigh = w.getFloat("temperatureHigh");
      temperatureLow = w.getFloat("temperatureLow");
      if( w.isNull("precipAccumulation") ) {
        precipAccumulation = 0;
      } else { 
        precipAccumulation = w.getFloat("precipAccumulation");
      }
      if( w.isNull("precipIntensity") ) {
        precipIntensity = 0;
      } else { 
        precipIntensity = w.getFloat("precipIntensity");
      }
      moonPhase = w.getFloat("moonPhase");
      temperatureLowTime = Calendar.getInstance();
      temperatureHighTime = Calendar.getInstance();
      sunriseTime = Calendar.getInstance();
      sunsetTime = Calendar.getInstance();
      temperatureLowTime.setTimeInMillis((long)w.getInt("temperatureLowTime")*1000);
      temperatureHighTime.setTimeInMillis((long)w.getInt("temperatureHighTime")*1000);
      sunriseTime.setTimeInMillis((long)w.getInt("sunriseTime")*1000);
      sunsetTime.setTimeInMillis((long)w.getInt("sunsetTime")*1000);
    }
    
    void print() {
      println(" ---------------------------------------------------- " );
      println( DayOfWeekStringsLong[date.get(Calendar.DAY_OF_WEEK)] + " " + MonthStringsLong[date.get(Calendar.MONTH)] + " " + DayStringsLong[date.get(Calendar.DATE)] );
      println( DayOfWeekStringsShort[date.get(Calendar.DAY_OF_WEEK)] + " " + MonthStringsShort[date.get(Calendar.MONTH)] + " " + date.get(Calendar.DATE) );
      println( "summary: " , summary );
      println( "icon: " + icon + "\t temperatureLow: " + temperatureLow + "\t temperatureHigh: " , temperatureHigh );
      println( "temperatureLowTime: " + timeStringAMPM(temperatureLowTime) + "    temperatureHighTime: " + timeStringAMPM(temperatureHighTime) );
      println( "humidity: " + humidity + "\t precipProbability: " + precipProbability + "\t precipIntensity: " + precipIntensity + "\t precipAccumulation: " + precipAccumulation );
      println( "windSpeed: " + windSpeed , "\t windBearing: " + windBearing + "\t windGust: " + windGust );
      println( "cloudCover: " + cloudCover , "\t visibility: " + visibility + "\t pressure: " + pressure + "\t dewPoint: " + dewPoint + "\t ozone: " + ozone + "\t uvIndex: " + uvIndex );
      println( "sunriseTime: " + timeStringAMPM(sunriseTime) + "    sunsetTime: " + timeStringAMPM(sunsetTime) + "    moonPhase: " + moonPhase );
    }
    
    DayConditions copy() {
      DayConditions that = new DayConditions();
      that.time = this.time;
      that.date = (Calendar) this.date.clone();
      that.summary = this.summary;
      that.precipProbability = this.precipProbability;
      that.visibility = this.visibility;
      that.windGust = this.windGust;
      that.icon = this.icon;
      that.cloudCover = this.cloudCover;
      that.windBearing = this.windBearing;
      that.pressure = this.pressure;
      that.dewPoint = this.dewPoint;
      that.ozone = this.ozone;
      that.temperature = this.temperature;
      that.humidity = this.humidity;
      that.uvIndex = this.uvIndex;
      that.windSpeed = this.windSpeed;
      
      that.temperatureHigh = this.temperatureHigh;
      that.temperatureLow = this.temperatureLow;
      that.precipAccumulation = this.precipAccumulation;
      that.moonPhase = this.moonPhase;
      that.temperatureLowTime = (Calendar) this.temperatureLowTime.clone();
      that.temperatureHighTime = (Calendar) this.temperatureHighTime.clone();
      that.sunriseTime = (Calendar) this.sunriseTime.clone();
      that.sunsetTime = (Calendar) this.sunsetTime.clone();
      that.precipIntensity  = this.precipIntensity;
      
      return that;
    }
    
  } 
  
}
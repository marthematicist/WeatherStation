
String timeStringAMPM( Calendar d ) {
  return ( d.get(Calendar.HOUR_OF_DAY) + ":"  + nf(d.get(Calendar.MINUTE)) + " " + d.get(Calendar.AM_PM) );
}
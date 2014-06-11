class Baum {

 Famillien family;

 String famillie;
 String gattung;
 
 int    obID;
 String baumNr;
 String art;
 String pflanzDatum;
 String baumAlter;
 int    id_schutz;
 String schutzStatus;
 String strasse;
 String kreis;
 int    idGruppe;
 String gruppe;
 float  lon;
 float  lat;

  private float rot;
 
 Baum(){
 }
 
 Baum(JSONObject baum, String family, String arte){
   
      JSONObject props=baum.getJSONObject("properties");
      obID=props.getInt("OBJID");
      baumNr=props.getString("BAUMNR");
      art=props.getString("ART","unbekannt");
      pflanzDatum=props.getString("PFLANZDATU","unbekannt");
      baumAlter=props.getString("BAUMALTER","unbekannt");
      id_schutz=props.getInt("ID_SCHUTZS",-99);
      schutzStatus=props.getString("SCHUTZSTAT","unbekannt");
      strasse=props.getString("STRASSE","unbekannt");
      kreis=props.getString("KREIS","unbekannt");
      idGruppe=props.getInt("ID_GRUPPE",-99);
      gruppe=props.getString("GRUPPE","unbekannt");
      
      JSONArray coords=baum.getJSONObject("geometry").getJSONArray("coordinates");
      lon=coords.getFloat(1);
      lat=coords.getFloat(0);
      
      
      
      gattung=arte;
      famillie=family;
 }
 
 public void draw(float centerX,float centerY,float scale,float size,color col){
      size/=sqrt(scale);
      noStroke();
      fill(50,200,0);
      pushMatrix();
      translate(displayWidth/4,displayHeight/4);
      scale(scale,-scale);
      translate(-centerX,-centerY);
      fill(col);
      ellipse(lat,lon,size,size);
      popMatrix();
 }
 
 public void info(){
   noStroke();
   fill(128,128,128,64);
   pushMatrix();
   translate(10,30);
   rect(0,-15,600,60);
   fill(0);
   textSize(18);
   fill(255,255,0);
   text(art,0,0);
   fill(200,200,0);
   String[] h=split(art," ");
   text(h[0],0,0);
   textSize(12);
   translate(0,20);
   fill(0,0,0,180);
   if(!baumAlter.equals("-99"))text(baumAlter+" jährig",200,0);
   textSize(18);
   fill(150,150,0);
   text(famillie,0,0);
   fill(0,0,0,180);
   translate(0,20);
   text(gruppe+" ("+strasse+")",200,0);
   popMatrix();
 }   
 
}



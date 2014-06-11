

class Wald {
  Famillien family;
  Baum[] baeume;
  float centerX,centerY;
  float posX,posY;
  float scale;
  
  float minDist;
  int minIndex;
  String selectedArt;
  String selectedGattung;
  String selectedSpecies;
  String selectedFamillie;
  //int artCount;
  int gattungCount;
  int speciesCount;
  int famillienCount;
  
  int cc;
  float[] av;
  
  float xMin,xMax,yMin,yMax;
  
  
  Wald(String geojson){
      JSONObject jsonObj= loadJSONObject(geojson); 
      JSONArray features= jsonObj.getJSONArray("features");
      baeume= new Baum[features.size()]; 
      for(int i=0;i<features.size();i++){
        JSONObject b=features.getJSONObject(i);
        
        JSONObject props=b.getJSONObject("properties");
       
        family=new Famillien();
        family.load();
        String art=props.getString("ART","unbekannt");
 
        String gattung=family.getGattung(art);
        String famillie=family.getFamily(art);
        
        baeume[i]= new Baum(b,famillie,gattung);
      }
     // setCenter(1268536.38,2609987.165); 
      setCenter(2609987.165,1268536.38); 
      setScale(1.0);
     // selectedArt="";
      av= new float[12];
  }
 
 
 private void adjust(){
    float hX=displayWidth/(4*scale);
    float hY=displayHeight/(4*scale);
    xMin=centerX-hX;
    xMax=centerX+hX;
    yMin=centerY-hY;
    yMax=centerY+hY;
 }
 
  void setCenter(float x,float y){
    centerX=x;
    centerY=y;
    adjust();
  }

  
  
  void setScale(float s){
    scale=s;
    adjust();
  }
  
  void draw(){
    
    float size;
    color col;
    
    float minDist=10e20;
    
    posX=map(mouseX,0,displayWidth/2,xMin,xMax);
    posY=map(mouseY,0,displayHeight/2,yMax,yMin);
    
    //translate(posX,posY);
    //scale(0.0001);
    //fill(255,0,0);
    //ellipse(posX,posY,20,20);
//    fill(0,0,255);
//    ellipse(posY,posX,20,20);

    famillienCount=0;
    gattungCount=0;
    //artCount=0;
    speciesCount=0;
    
    selectedSpecies=baeume[minIndex].art;
    //String[] sg=splitTokens(selectedSpecies);
    //selectedGattung=sg[0];
    //selectedFamillie=family.getFamily(selectedGattung);  
    selectedGattung=baeume[minIndex].gattung;
    selectedFamillie=baeume[minIndex].famillie;
    
    for(int i=0;i<10;i++)av[i]=0;
    
    int minI=-1;
    for(int i=0;i<baeume.length;i++){
      Baum b= baeume[i];
    //  if(!((b.lat<xMin)||(b.lat>xMax)||(b.lon<yMin)||(b.lon>yMax))){
       
        //default 
        size=6.0;
        col= color(50,200,0);
       
        //String species=b.art; 
        //String[] tg=splitTokens(species);
        //String gattung=tg[0];
        //String art=tg[1];
       
        //famillie
        //String famillie=family.getFamily(gattung);
        if(b.famillie.equals(selectedFamillie)){
          famillienCount++;
          col=color(150,150,0);
        } 
        //gattung
        if(b.gattung.equals(selectedGattung)){
          gattungCount++;
          famillienCount--;
          col=color(200,200,0);
        }
        //species
        if(b.art.equals(selectedSpecies)){
          speciesCount++;
          gattungCount--;
          col= color(255,255,0);
        }
        //selected
        if(i==minIndex)col= color(255,0,0);
        
        b.draw(centerX,centerY,scale,size,col);

      //}
      float d= (b.lat-posX)*(b.lat-posX)+((b.lon-posY)*(b.lon-posY));
      if(d<minDist){
        minDist=d;
        minI=i;
      }
  
      float ba=float(b.baumAlter);
      if(ba>0.0){
         cc++;
         av[round(ba/10.0)]++;        
      }
    } 
    
    for(int i=0;i<10;i++)av[i]/=cc;
    
    if(minI>0){
      minIndex=minI;
      selectedArt=baeume[minIndex].art;
      baeume[minIndex].info();
    }
    
  }
  
  void info(){
   noStroke();
   fill(128,128,128,128);
   pushMatrix();
   translate(10,10);
   //rect(0,0,200,20);
   fill(0);
   text("S="+speciesCount+" G="+gattungCount+" F="+famillienCount,mouseX+20,mouseY);
   fill(0,255,0);
   translate(0,100);
   for(int i=0;i<10;i++){
     rect(0+i*10,0,av[i]*10,10);
   }
   popMatrix();
 }   
 
 
  
  
} //class


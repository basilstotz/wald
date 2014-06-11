class Famillien{
  
  StringDict fams;
  String line;
 
  
  Famillien(){
    fams= new StringDict();
    line="";
  }

  void load(){
    
    /*
    BufferedReader reader=createReader("gatt.txt");
    while(line!=null){
      try {
        line = reader.readLine();
      } catch (IOException e) {
        //e.printStackTrace();
        line = null;
      }
      if (line != null) {
        String[] pieces = split(line, "|");
        fams.set(pieces[0],pieces[1]);
      }
    }
    */
    
    String lines[] = loadStrings("gattung.txt");
    for(int i=0;i<lines.length;i++){
      String[] pieces = split(lines[i], "|");
      fams.set(pieces[0],pieces[1]);
    }
  }

  String getFamily(String art){
     String gattung=getGattung(art);
     String famillie=fams.get(gattung);
     return(famillie);
  }

  String getGattung(String art){
     String[] sg=splitTokens(art);
     return(sg[0]);
  }
  //  return(fams.get(gattung));  
  //}
  
}

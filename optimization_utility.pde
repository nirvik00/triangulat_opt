



ArrayList<cell> swap(ArrayList<cell> cellObjArr, ArrayList<String> adjArr){
  ArrayList<cell> iniCells=new ArrayList<cell>();
  ArrayList<cell> finCells=new ArrayList<cell>();
  for(int i=0; i<cellObjArr.size();i++){
    finCells.add(cellObjArr.get(i));
  }
  for(int i=0; i<cellObjArr.size();i++){
    iniCells.add(cellObjArr.get(i));
  }
  int u=int(random(finCells.size()-1));
  int v=int(random(finCells.size()-1));  
  String nu=iniCells.get(u).getName();
  String nv=iniCells.get(v).getName();
  int[] cu=iniCells.get(u).getColr();
  int[] cv=iniCells.get(v).getColr();
  
  finCells.get(u).setName(nv);
  finCells.get(v).setName(nu);
  finCells.get(u).setColr(cv);
  finCells.get(v).setColr(cu);
  
  float f0=fitness(ite_iniArr,global_adjArr);
  float f1=fitness(finCells,global_adjArr);
  
  if(f0>f1){
    return finCells;
  }else{
    return iniCells;
  }
}



float fitness(ArrayList<cell>arr, ArrayList<String>adjArr){
  float sum=0;
  for(int i=0; i<arr.size(); i++){
    String nu=arr.get(i).getName();
    pt mp0=arr.get(i).getMP();
    for(int j=0; j<arr.size(); j++){
      String nv=arr.get(j).getName();
      pt mp1=arr.get(j).getMP();
      float d=d(mp0,mp1);
      float val=findAdjVal(nu,nv,adjArr)*d;
      //console.log(nu,nv,val);
      sum+=val;
    }
  }
  return sum;
}

float findAdjVal(String a, String b, ArrayList<String>adjArr){
  //
  // string input 'a' is the first field and 'b' 2nd field
  //  
  float val=10000;
  for(int i=0; i<adjArr.size(); i++){
    String u=adjArr.get(i).split(",")[0];
    String v=adjArr.get(i).split(",")[1];    
    if((u.equals(a) && v.equals(b))||(u.equals(b) && v.equals(a))){      
      val=Float.parseFloat(adjArr.get(i).split(",")[2]);
      break;
    }
  }
  if(val!=10000){
    return val;
  }else{
    return 0;
  }
}
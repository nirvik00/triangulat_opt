
ArrayList<String> constructAdjArr(ArrayList<String> adj){
  ArrayList<String> names=new ArrayList<String>();
  ArrayList<String> adjArr=new ArrayList<String>();
  for(int i=0; i<adj.size(); i++){
    String n0=adj.get(i).split(",")[0];
    names.add(n0);
  }
  for(int i=0; i<adj.size(); i++){
    String[] s=adj.get(i).split(",");
    String n0=adj.get(i).split(",")[0];
    for(int j=1; j<s.length; j++){
      String n1=names.get(j-1);
      String val=s[j];
      adjArr.add(n0+","+n1+","+val);      
    }
  }
  return adjArr;
}
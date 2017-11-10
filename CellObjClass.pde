class cell{
  
  int id;pt P;float a,b;String name;int[] colr=new int[3]; pt[] ptArr;
  
  cell(int id_, pt p_, float a_, float b_, String n_, int[] c_){ id=id_; P=p_; a=a_;b=b_;name=n_;colr=c_; }
  
  cell(int id_, pt[] arr_, String n_, int[] c_){ id=id_;ptArr=arr_;name=n_;colr=c_; }
  
  int getId(){return id;}
  
  pt getPt(){return P;}
  
  float getA(){return this.a;}
  
  float getB(){return this.b;}
  
  pt[] getPtArr(){return ptArr;}
  
  String getName(){return this.name;}
  
  void setName(String name_){name=name_;}

  int[] getColr(){return colr; }
  
  void setColr(int[] c_){colr=c_;}
  
  pt getMPrect(){pt mp=new pt((P.x+a)/2,(P.y+b)/2);return mp;}
  
  pt getMP(){
    float sumx=0,sumy=0;
    int n=ptArr.length; 
    for(int i=0; i<n; i++){
      sumx+=ptArr[i].x; sumy+=ptArr[i].y;
    }
    pt ce=new pt(sumx/n, sumy/n);
    return ce;
  }
  
  void info(){
    println("cell info : ",name, colr[0], colr[1], colr[2]);
  }  
}
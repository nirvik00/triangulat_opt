import java.util.*;


int numofpoints=5;

ArrayList<String> global_adjArr;
ArrayList<String> nameArr;
ArrayList<cell> global_cellObjList;//class -> CellObjClass
float ite_fitness;
ArrayList<cell> ite_iniArr; 
ArrayList<String> funcArr;
float global_fitness=10000;

ArrayList<String> adj; ArrayList<String> obj;


ArrayList<pt>global_ptList;
ArrayList<pt[]>global_tri_ptList;
ArrayList<pt[]>global_quad_ptList;
ArrayList<pt[]>global_poly_li;

boolean voronoiBoolean=false;

boolean lock=false;
int locked_index;
pt locked_pt;

float global_de=20;
float global_wi=10;


void setup(){
  size(1500,900);
  background(255);
  
  global_adjArr=new ArrayList<String>();  nameArr=new ArrayList<String>();  
  global_cellObjList = new ArrayList<cell>();  ite_iniArr = new ArrayList<cell>();  
  adj=new ArrayList<String>(); obj=new ArrayList<String>();
  
  
  adj.add("Entr,0,10,10,10,10");
  adj.add("Eval,0,10,0,0,0");
  adj.add("Nurse,0,0,-50,10,0");
  adj.add("Bath,0,0,0,-50,0");
  adj.add("Stair,0,0,0,0,-50");
  
  obj.add("Entr,5000,1,0,255,0");
  obj.add("Eval,7500,5,0,255,0");
  obj.add("Nurse,6700,2,0,0,255");
  obj.add("Bath,4873,2,10,100,155");
  obj.add("Stair,5454,2,100,155,10");
  
 
  
  global_ptList=new ArrayList<pt>();
  global_tri_ptList=new ArrayList<pt[]>();
  global_quad_ptList=new ArrayList<pt[]>();
  global_poly_li=new ArrayList<pt[]>();
  genPts();
  displayPts();
}

void draw(){
// GOING THROUGH KEYPRESSED AND MOUSEPRESSED
//displayPts();
}


void keyPressed(){  
  
  if(key=='d'){
    genPts();
    displayPts();
    runCode();    
  }
  if(key=='v'){    
    displayPts();
    runCode();    
    voronoiBoolean=true;
    constructVoronoi();
  }
  if(key=='c'){ 
    global_poly_li.clear();  global_poly_li.addAll(constructCells());
    constructVoronoi();
    displayCells(global_poly_li);
    nameArr.clear(); nameArr=getNameList();global_adjArr.addAll(constructAdjArr(adj));    
    global_cellObjList.clear(); global_cellObjList.addAll(assignFuncToCellObj(global_poly_li, nameArr, obj));       
    ite_iniArr.clear();ite_iniArr.addAll(global_cellObjList);displayCellObj(ite_iniArr,global_poly_li,0); 
    float f0=fitness(ite_iniArr,global_adjArr);
    ite_fitness=f0;    
  }
  if(key=='r'){
    int counter=0;
    while(counter<100){
      ArrayList<cell> finCells=swap(ite_iniArr,global_adjArr);
      float f1=fitness(finCells,global_adjArr);
      if(f1<ite_fitness+1 && counter<99){      
        ite_iniArr=finCells;
        ite_fitness=f1;
        break;
      }
      counter++;  
    }
    displayCellObj(ite_iniArr,global_poly_li,counter);
  }
}


void mousePressed(){
  float x=mouseX;
  float y=mouseY;
  float r=50;
  for(int i=0; i<global_ptList.size(); i++){
    pt p0=global_ptList.get(i);
    if(dis(x,y,p0.x,p0.y)<25){
      lock=true;
      locked_pt=p0;
      locked_index=i;  
      stroke(255,255,255);
      fill(255,0,0,50);
      ellipse(p0.x,p0.y,20,20); 
    }
  }
}


public void mouseDragged(){
  if(lock==true){
    pt P=global_ptList.get(locked_index);
    P.x=(mouseX);
    P.y=(mouseY);  
    stroke(255,255,255);
    fill(255,0,0,50);
    ellipse(P.x,P.y,20,20);   
  }
  runCode();  
}
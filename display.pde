void displayPts(){
  stroke(0);
  for(int i=0;i<global_ptList.size(); i++){
    pt P=global_ptList.get(i);
    //text(""+P.x+","+P.y,P.x,P.y);      
    stroke(100,100,100);
    ellipse(P.x,P.y,15,15);
    stroke(0,0,0);
    fill(0);
    ellipse(P.x,P.y,5,5);
    noFill();
  }
  fill(0);
  text("Press d to display departments",20,20);
  text("Press v to display circulation",20,40);
  text("num of points: "+global_ptList.size(),20,60);  
  text("num of triangles: "+global_tri_ptList.size(),20,80);
  text("num of cells: "+global_poly_li.size(),20,100);
  text("this fitness : "+ite_fitness,20,120);
  noFill();
}


void displayDtriangulation(){
  background(255);
  stroke(0,0,0);
  strokeWeight(1);
  for(int i=0; i<global_tri_ptList.size(); i++){
    pt p=global_tri_ptList.get(i)[0]; pt q=global_tri_ptList.get(i)[1]; pt r=global_tri_ptList.get(i)[2]; 
    pt o=CircumCenter(p,q,r);
    float di=d(p,o)*2;
    noFill();
    int re=int(random(255));
    int gr=int(random(255));
    int bl=int(random(255));
    fill(re,gr,bl,25);
    //ellipse(o.x,o.y,di,di);
    beginShape();
    vertex(p.x,p.y);
    vertex(q.x,q.y);
    vertex(r.x,r.y); 
    endShape(CLOSE); 
    
  }
  displayPts();
}

void displayArr(pt[] arr){
  stroke(0,0,0);
  strokeWeight(1);
  noFill();
  beginShape();
  for(int i=0; i<arr.length; i++){
    vertex(arr[i].x,arr[i].y);
  }
  endShape(CLOSE);
  //displayPts();
}

void displayCells(ArrayList<pt[]> li){
  for(int i=0; i<li.size(); i++){    
    displayArr(li.get(i));
  }
}

void displayCellObj(ArrayList<cell> cellObjList, ArrayList<pt[]>poly_li, int counter){
  background(255);    
  displayDtriangulation();  
  displayCells(poly_li);
  for(int i=0; i<cellObjList.size(); i++){
    cell thisCell=cellObjList.get(i);
    pt[] arr=thisCell.getPtArr();
    int[] colr=thisCell.getColr();
    stroke(0,0,0);
    strokeWeight(1);
    int re=colr[0];
    int gr=colr[1];
    int bl=colr[2];
    //thisCell.info();
    fill(re,gr,bl);
    beginShape();
    for(int j=0; j<arr.length; j++){
      vertex(arr[j].x,arr[j].y);
    }
    endShape(CLOSE);
    rect(1200,40*i+100,40,40);    
    fill(0);
    String s=thisCell.getName();
    text("#"+s, 1250,40*i+125);    
    text("this counter : "+counter,20,140); 
    noFill();
  }
  displayPts();constructVoronoi();
  fill(0); text("this counter : "+counter,20,140); noFill();
}

/*
void displayIteration(ArrayList<cell> cellArr, int counter){  
  background(255);
  fill(255);
  rect(0,0,1000,500);
  stroke(0);
  strokeWeight(1);
  ArrayList<cell> arr=cellArr;
  int n=int(arr.size());  
  for(int i=0; i<arr.size(); i++){
    cell ce=arr.get(i);
    int[] colr=ce.getColr();
    fill(colr[0],colr[1],colr[2]);    
    displayArr(ce.getPtArr());
    fill(0);
    strokeWeight(.5);    
    text(ce.getName(),ce.getMP().x,ce.getMP().y);    
    noFill();
  }
  println(counter);
}*/
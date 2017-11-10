



ArrayList<pt[]> constructCells(){  
  ArrayList<pt[]>poly_li=new ArrayList<pt[]>(); 
  ArrayList<pt[]> inp_pts=new ArrayList<pt[]>();
  inp_pts.clear();
  inp_pts.addAll(global_tri_ptList); 
  
  ArrayList<pt[]> ini_poly_pts=new ArrayList<pt[]>();
  
  float di=global_de=50;
  float wi=global_wi=25;
  
  poly_li.clear();
  for(int i=0; i<inp_pts.size(); i++){
    pt[] f_pts=inp_pts.get(i);   
    for(int j=0; j<f_pts.length; j++){
      pt p,q,r,ce;
      if(j==0){ p=f_pts[f_pts.length-1]; q=f_pts[j]; r=f_pts[j+1]; }
      else if(j>0 && j<f_pts.length-1){ p=f_pts[j-1]; q=f_pts[j]; r=f_pts[j+1]; }
      else{p=f_pts[j-1]; q=f_pts[f_pts.length-1]; r=f_pts[0]; }
      ce=new pt((p.x+q.x+r.x)/3,(p.y+q.y+r.y)/3);
      pt p_=getNormalToPtAtDist(p,q,r,di)[0], q_=getNormalToPtAtDist(p,q,r,di)[1];
      pt p_f=getIntersectionPt(p_,q_,p,ce), q_f=getIntersectionPt(p_,q_,q,ce);
      pt[] l={p,q,q_f,p_f};//displayArr(l);
      ini_poly_pts.add(l);
    }
  }   
  
  for(int i=0; i<ini_poly_pts.size(); i++){
    pt[] arr=ini_poly_pts.get(i);
    pt p=arr[0],q=arr[1],q_=arr[2],p_=arr[3];
    pt r=projPtOnLine(p_,p,q),s=projPtOnLine(q_,p,q);
    pt[] start={p,r,p_};pt[] end={q,s,q_};  poly_li.add(start); poly_li.add(end);  
    pt[] div_arr=divSeg(p_,q_,wi);
    for(int j=0; j<div_arr.length; j++){
      if(j>0){
        pt g=div_arr[j], h=projPtOnLine(g,p,q);
        pt g_=div_arr[j-1], h_=projPtOnLine(g_,p,q);
        pt[] i_arr={g,h,h_,g_}; //displayArr(i_arr); 
        poly_li.add(i_arr);
      }
    }
  }  
  return poly_li;
}//end function

/*
*  solver
*/

/*
*  CellObjClass
*/

ArrayList<String> getNameList(){
  ArrayList<String> name=new ArrayList<String>();
  float sum=0;
  for(int i=0; i<obj.size(); i++){
    String[] s=obj.get(i).split(",");
    String n0=obj.get(i).split(",")[0];
    int num=Integer.parseInt(obj.get(i).split(",")[2]);
    for(int j=0; j<num; j++){
      name.add(n0);
      sum++;
    }
  }  
  return name;
}

ArrayList<cell> assignFuncToCellObj(ArrayList<pt[]>poly_li, ArrayList<String> names, ArrayList<String> obj){
  int n=names.size();
  int[] idxPoly=new int[poly_li.size()];
  idxPoly[0]=int(random(poly_li.size()));
  ArrayList<cell> cellObjArr=new ArrayList<cell>();     
  int counter=0;  
  for(int i=0; i<n; i++){   
    int[] colr=new int[3];colr[0]=255; colr[1]=255; colr[2]=255;
    for(int j=0; j<obj.size(); j++){     
      String s=obj.get(j).split(",")[0];
      if(s.equals(names.get(i))){        
        int re=Integer.parseInt(obj.get(j).split(",")[3]);
        int gr=Integer.parseInt(obj.get(j).split(",")[4]);
        int bl=Integer.parseInt(obj.get(j).split(",")[5]);        
        colr[0]=re; colr[1]=gr; colr[2]=bl;
        break;
      }
    } 
    int f=-1,r=-1;
    if(i==0){r=idxPoly[0];}else{      
      for(int k=0; k<100; k++){
        f=rndGen(poly_li.size(), idxPoly);
        if(f!= -1){
          r=f;idxPoly[i]=r;
          break;
        }
      }
      if(r==-1){
        break;
      }
    }
    println(i, names.get(i), colr[0], colr[1], colr[2]);
    cell c=new cell(i, poly_li.get(r), names.get(i), colr);
    cellObjArr.add(c);    
    counter++;
  }
  return cellObjArr;
}

int rndGen(int s, int[] idArr){
 int x=int(random(s)); 
 int sum=0;
 for(int i=0; i<idArr.length; i++){
   if(x==idArr[i]){
     sum++;
   }   
 } 
 if(sum==0){
   return x;
 }else{
   return -1;
 }
}
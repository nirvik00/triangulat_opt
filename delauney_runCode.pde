/*
*  THIS A BIG FUNCTION THAT TRIANGULATES
*/
void runCode(){
  background(255); noFill();
  ArrayList<pt[]>nptList=new ArrayList<pt[]>();
  ArrayList<pt>ptList=new ArrayList<pt>();
  ptList.addAll(global_ptList);  
  nptList.clear();
  /* construct initial set of triangles */
  for(int i=0; i<ptList.size(); i++){
    pt p=ptList.get(i);
    for(int j=0; j<ptList.size(); j++){
      pt q=ptList.get(j);
      if(d(p,q)>0 && i!=j){
        for(int k=0; k<ptList.size(); k++){
          pt r=ptList.get(k); float d0=d(p,r); float d1=d(q,r);
          if(d0>0 && d1>0){
            pt[] ptArr=new pt[3]; ptArr[0]=p; ptArr[1]=q; ptArr[2]=r;
            if(nptList.contains(ptArr)==false){          
                nptList.add(ptArr);   
            }
          }
        }
      }
    }
  }
  
  //println("1. initial set : "+nptList.size());
  /* construct initial set of triangles */
  ArrayList<pt[]>fptList=new ArrayList<pt[]>();
  fptList.clear();
  for(int i=0; i<nptList.size(); i++){
    pt p=nptList.get(i)[0];pt q=nptList.get(i)[1];pt r=nptList.get(i)[2];
    pt o=CircumCenter(p,q,r); float di=d(o,p)*2;
    boolean g=false;int sum=0;
    for(int j=0; j<global_ptList.size(); j++){
      pt t=global_ptList.get(j);   
      float d0=d(p,t); float d1=d(q,t); float d2=d(r,t); float dr=d(o,t)*2;
      if(dr<di && d0>0.1 && d1>0.1 && d2>0.1){
        g=true; sum++;
      }
    }
    if(g==false && sum<1){
      pt[] tPtArr=new pt[3]; tPtArr[0]=p; tPtArr[1]=q; tPtArr[2]=r; 
      if(fptList.contains(tPtArr)==false){          
          fptList.add(tPtArr);
        }
    }    
  } 
  ArrayList<pt[]>tmp=new ArrayList<pt[]>();tmp.clear();tmp.add(fptList.get(0)); nptList.clear();
  for(int i=0; i<fptList.size(); i++){
    pt[] f_pts=fptList.get(i);
    pt p=f_pts[0];
    pt q=f_pts[1];
    pt r=f_pts[2];
    float ar_i=heron(p,q,r);  int sum=0;      
    for(int j=0; j<tmp.size(); j++){      
      pt[] j_pts=tmp.get(j);
      pt a=j_pts[0];
      pt b=j_pts[1];
      pt c=j_pts[2];
      float ar_j=heron(a,b,c);
      if(abs(ar_i-ar_j)<1){
        sum++;
        break;
      }
    }
    if(sum==0){
      tmp.add(f_pts);
    }
  }  
  //println("3. reduced final set : "+fptList.size(), tmp.size());
  fptList.clear();
  global_tri_ptList.clear();
  global_tri_ptList.addAll(tmp);
  displayDtriangulation();
  //constructVoronoi();
 }
 
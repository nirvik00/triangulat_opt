void constructVoronoi(){
  ArrayList<pt[]> duptriList=new ArrayList<pt[]>();
  duptriList.addAll(global_tri_ptList);  
  
  for(int i=0; i<duptriList.size(); i++){
     pt[] parr=duptriList.get(i);
     pt p=parr[0];
     pt q=parr[1];
     pt r=parr[2];
     pt o=CircumCenter(p,q,r);
     pt ce=new pt((p.x+q.x+r.x)/3,(p.y+q.y+r.y)/3);
     boolean t=checkPtTri(o,parr);     
     pt a=new pt((p.x+q.x)/2, (p.y+q.y)/2);
     pt b=new pt((p.x+r.x)/2, (p.y+r.y)/2);
     pt c=new pt((r.x+q.x)/2, (r.y+q.y)/2);
     if(voronoiBoolean==true){
         if(t==true){       
         stroke(255,0,0,70);
         strokeWeight(10);
         line(o.x,o.y,a.x,a.y);
         line(o.x,o.y,b.x,b.y);
         line(o.x,o.y,c.x,c.y);
         stroke(0);
         strokeWeight(1);
       }else{
        stroke(0,255,0,70);
         strokeWeight(10);
         line(ce.x,ce.y,a.x,a.y);
         line(ce.x,ce.y,b.x,b.y);
         line(ce.x,ce.y,c.x,c.y);
         stroke(0);
         strokeWeight(1);
       }
     }
   } 
   displayPts();
}
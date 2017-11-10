




/*

*/




void genPts(){
  global_ptList.clear();
  for(int i=0; i<numofpoints; i++){
    float x=random(1000)+100;
    float y=random(700)+100;
    pt p=new pt(x,y);
    global_ptList.add(p);
  }
}


pt CircumCenter(pt A, pt B, pt C){
  pt H=new pt((A.x+C.x)/2,(A.y+C.y)/2);
  pt M=new pt((A.x+B.x)/2,(A.y+B.y)/2);
  vec AH=V(A,H);
  vec AM=V(A,M);
  vec V=U(R(V(A,B)));
  float s=(dot(AH,AH)-dot(AM,AH))/(dot(V,AH));
  pt P=new pt(M.x,M.y).add(S(s,V));
  return P;
}

boolean isSkinny(pt[] ptArr){
  pt p=ptArr[0]; pt q=ptArr[1]; pt r=ptArr[2];
  vec pq=V(p,q); vec pr=V(p,r);
  vec qr=V(q,r); vec qp=V(q,p);
  vec rp=V(r,p); vec rq=V(r,q);
  float a=(180/PI)*(acos(dot(pq,pr)/(n(pq)*n(pr))));
  float b=(180/PI)*(acos(dot(qp,qr)/(n(qp)*n(qr))));
  float c=(180/PI)*(acos(dot(rp,rq)/(n(rp)*n(rq))));
  if(a<30 || b<30 || c<30){
    return false;
  }else{
    return true;
  }
}


public double dis(float x, float y, float a, float b){
  double d=sqrt(sq(x-a) + sq(y-b));
  return d;
}


float heron(pt a, pt b, pt c){
  float l=d(a,b);
  float m=d(a,c);
  float n=d(c,b);
  float s=(l+m+n)/2;
  float ar=sqrt(s*(s-l)*(s-m)*(s-n));
  return ar;
}


pt[] angBisector(pt p0, pt p1, pt p2, float s){
  float x0=p0.x;
  float y0=p0.y;
  float x1=p1.x;
  float y1=p1.y;
  float x2=p2.x;
  float y2=p2.y;
  float ux=x0-x1;
  float uy=y0-y1;
  float nu=sqrt((ux*ux) + (uy*uy));
  float vx=x2-x1;
  float vy=y2-y1;
  float nv=sqrt((vx*vx) + (vy*vy));
  float a=acos(((ux*vx)+(uy*vy))/(nu*nv));
  float ang=(a/2);
  print("con1",ang*180/PI);
  float x=s*((vx*cos(ang)-vy*sin(ang))/nv) + x1;
  float y=s*((vx*sin(ang)+vy*cos(ang))/nv) + y1;
  pt p=new pt(x,y);  
  pt[] parr={p0,p1,p2};
  boolean t=checkPtTri(p, parr);
  line(p.x,p.y,p1.x,p1.y);
  pt[] ptArr={p1,p};  
  return ptArr;
}



pt projToCentroid(pt p, pt q, pt r, float s){
  pt ce=new pt((p.x+q.x+r.x)/3, (p.y+q.y+r.y)/3 );
  vec v=U(V(q,ce));
  pt q_=new pt(q.x,q.y).add(S(s,v));
  line(q.x,q.y,q_.x,q_.y);
  return q_;
}

pt getCentroid(pt[] arr){
  float sumx=0,sumy=0;
  int n=arr.length; 
  for(int i=0; i<n; i++){
    sumx+=arr[i].x; sumy+=arr[i].y;
  }
  pt ce=new pt(sumx/n, sumy/n);
  return ce;
}


pt projPtOnLine(pt p0, pt p1, pt p2){
  //  p0 is point
  //  p1, p2 first and last points of line
  float x0=p0.x;
  float y0=p0.y;
  float x1=p1.x;
  float y1=p1.y;
  float x2=p2.x;
  float y2=p2.y;
  float ux=x0-x1;
  float uy=y0-y1;  
  float vx=x2-x1;
  float vy=y2-y1;
  float nv=((vx*vx) + (vy*vy));
  //  project u on v
  float x=((vx*ux + vy*uy)/nv)*vx + x1;
  float y=((vx*ux + vy*uy)/nv)*vy + y1;
  pt p=new pt(x,y);
  return p;
}


pt[] divSeg(pt p0,pt p1, float di){
  float x0=p0.x;
  float y0=p0.y;
  float x1=p1.x;
  float y1=p1.y;
  float le=d(p0,p1);
  int n=int(le/di);
  pt[] pts=new pt[n];
  for(int i=0; i<n; i++){
    float x=(x1*i+x0*(n-i))/n;
    float y=(y1*i+y0*(n-i))/n;
    pt p=new pt(x,y);
    pts[i]=p;
  }
  return pts;
 }
 
 
 boolean checkPtTri(pt o, pt[] parr){
  pt p=parr[0];
  pt q=parr[1];
  pt r=parr[2];
  float AR=heron(p,q,r);  
  float sum=0;
  sum+=heron(o,p,q);
  sum+=heron(o,p,r);
  sum+=heron(o,r,q);
  //sum=AR;
  boolean t=false;
  if(abs(sum-AR)<2){
    t=true; //in poly
  }else{
    t=false; //not in poly
  }
  fill(0);
  noFill();
  return t;
}


pt[] getNormalToPtAtDist(pt p, pt q, pt r, float d){
  pt w=new pt((p.x+q.x)/2,(p.y+q.y)/2).add(S(d,(U(R(V(p,q))))));
  //pt e=new pt((p.x+q.x)/2,(p.y+q.y)/2);
  //line(w.x,w.y,e.x,e.y);
  pt[] arr={p,q,r};pt p_,q_;
  if(checkPtTri(w,arr)==false){
    p_=new pt(p.x,p.y).add(S(-d,(U(R(V(p,q))))));
    q_=new pt(q.x,q.y).add(S(-d,(U(R(V(p,q))))));
    //stroke(255,0,0);strokeWeight(5);line(p_.x,p_.y,p.x,p.y);line(q_.x,q_.y,q.x,q.y);line(p_.x,p_.y,q_.x,q_.y);
    pt[] a={p_,q_};
    return a;
  }else{
    p_=new pt(p.x,p.y).add(S(d,(U(R(V(p,q))))));
    q_=new pt(q.x,q.y).add(S(d,(U(R(V(p,q))))));    
    //line(p_.x,p_.y,p.x,p.y);line(q_.x,q_.y,q.x,q.y);line(p_.x,p_.y,q_.x,q_.y);
    pt[] b={p_,q_};
    return b;  
  }  
}

pt getIntersectionPt(pt p, pt q, pt r, pt s){
  float m0=(q.y-p.y)/(q.x-p.x); float c0=q.y-m0*q.x;
  float m1=(r.y-s.y)/(r.x-s.x); float c1=r.y-m1*r.x;
  float x=(c1-c0)/(m0-m1); float y=m0*x + c0; pt w=new pt(x,y);
  //ellipse(x,y,10,10);
  return w;
}

pt[] scaleDown(pt[] arr, float di){
  float sumx=0, sumy=0;
  for(int i=0; i<arr.length; i++){
    sumx+=arr[i].x; sumy+=arr[i].y;
  }
  float x=sumx/arr.length;float y=sumy/arr.length; pt ce=new pt(x,y);
  pt[] f_arr=new pt[arr.length];
  for(int i=0; i<arr.length; i++){
    f_arr[i]=new pt(arr[i].x, arr[i].y).add(S(di, U(V(arr[i],ce))));
  }
  return f_arr;
}
 
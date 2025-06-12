static class Util{
  
  /* GENERAL */
  
  static int locateArr(Object target, Object[] arr) {
     for(int i = 0; i<arr.length; i++) {
       if(target.equals(arr[i])) return i;
     }
     return -1;
  }
  
  static <T> int locateArrL(T target, ArrayList<T> arr) {
    for(int i = 0; i<arr.size(); i++) {
      if(target.equals(arr.get(i))) return i;
    }
    return -1;
  }
  
  /* PATH/FILE MANIPULATION */
  
  int getFileLen(String path) {
    File f = new File(path);
    if(f.isDirectory()) {
      return f.list().length;
    } else return 0;
  }
  
  /* P MANIPULATION */
  
  static PImage blur(PImage img) {
    PImage blurred = img;
    
    final float k = 1.0/9;
    final float[][] kernel = new float[][] {
       {k,k,k}
      ,{k,k,k}
      ,{k,k,k}
    };
    
    /*
    TODO:
     > APPLY A BLUR
    */
    
    return blurred;
  }
  
  static PVector addPVScalar(PVector P1, int scalar) {
    return PVector.add(P1, new PVector(scalar,scalar));
  }
  
  /* COORDINATE PLANE ALGEBRA */
  
  static float quadratic(double x, double a, double b, double c) {
    return (float)(c + b*x + a*x*x);
  }
  
  static float ln(double x, double a, double b, double c) {
    return (float)(c+a*log((float)(b*x))/log((float)(2.71828)));
  }
  
  /* UPGRADE QUADRATICS */
  
  static float brutalityHpMult(PVector stats) {
    return quadratic(stats.x,-0.005,0.67,0.34);
  }
  
  static float tacticsHpMult(PVector stats) {
    return quadratic(stats.y,-0.0114,0.534,0.48);
  }
  
  static float survivalHpMult(PVector stats) {
    return (0.7*stats.z)+0.3;
  }
  
  static float hpMult(PVector stats) {
    return brutalityHpMult(stats)*tacticsHpMult(stats)*survivalHpMult(stats);
  }
  
  static float brutalityDmgMult(PVector stats) {
    return DmgMult(int(stats.x-1));
  }
  
  static float tacticsDmgMult(PVector stats) {
    return DmgMult(int(stats.y-1));
  }
  
  static float survivalDmgMult(PVector stats) {
    return DmgMult(int(stats.z-1));
  }
  
  static float DmgMult(int level) {
    return pow(1.15,level-1);
  }
  
  static float defense(PVector stats) {
    return (float)(stats.z*0.07);
  }
  
  /* COORDINATE PLANE GEOMETRY */
  
  static float distance(PVector A, PVector B) {
    return sqrt(pow(A.x-B.x,2) + pow(A.y-B.y,2));
  }
  
  static boolean incRange(int x, int A, int B) {
    return x>=min(A,B) && x<=max(A,B);
  }
  
  static boolean incRange(float x, float A, float B) {
    return x>=min(A,B) && x<=max(A,B);
  }
  
  static boolean exRange(float x, float A, float B) {
    return x>min(A,B) && x<max(A,B);
  }

  static float areaTri(PVector P1, PVector P2, PVector P3){
    return Math.abs((P1.x*(P2.y-P3.y) + P2.x*(P3.y-P1.y)+P3.x*(P1.y-P2.y))/2.0);
  }
  
  static float cross2D(PVector P1, PVector P2) {
    PVector P1_COPY = P1;
    return P1_COPY.cross(P2).z;
  }
  
  static float slope(PVector L1,PVector L2) {
    return (L1.y-L2.y)/(L1.x-L2.x); // just rise over run
  }
  
  static float yIntercept(PVector L1, PVector L2) {
    return L1.y - slope(L1, L2)*L1.x; // m(x-x1)=(y-y1) -> y = mx + (y1 - m*x1)
  }
  
  static float normalizeAngle(float angle) {
    angle = angle % 360;
    if (angle < 0) {
        angle += 360;
    }
    return angle;
  }
  
  static boolean pointInTri(PVector P1, PVector T1, PVector T2, PVector T3) {
    float A = areaTri(T1,T2,T3); // area of given triangle
     
    // Calculate area of triangles: P1T2T3,T1P1T3,T1T2P1
    float A1 = areaTri(P1, T2, T3);
    float A2 = areaTri(T1, P1, T3);
    float A3 = areaTri(T1, T2, P1);
       
    // If areas of 3 triangles equal are of triangle, then point is in triangle
    return (A == A1 + A2 + A3);
  }
  
  static boolean pointInRect(PVector P1, PVector R1, PVector R2) {
    boolean xRange = incRange(P1.x,R1.x,R2.x); // is P1 inclusively between R1 and R2 for x-component?
    boolean yRange = incRange(P1.y,R1.y,R2.y); // is P1 inclusively between R1 and R2 for y-component?
    return xRange && yRange; // if both, then P1 is within the rectangle formed by R1 and R2
  }
  
  static boolean intersectRectRect(PVector R1_1, PVector R1_2, PVector R2_1, PVector R2_3) {
    PVector[] rect = new PVector[]{
      R2_1, new PVector(R2_3.x,R2_1.y), R2_3, new PVector(R2_1.x,R2_3.y)
    };
    
    for(PVector v : rect) {
      if(pointInRect(v,R1_1,R1_2)) return true;
    }
    
    return false;
  }
  
  static float intersectionPointLine(PVector P1, PVector L1, PVector L2) {
    return cross2D(PVector.sub(L2,L1),PVector.sub(P1,L1));
  }
  
  static boolean intersectLineLine(PVector L1_1, PVector L1_2, PVector L2_1, PVector L2_2) {
    // using y = mx+b would omit edge case of vertical lines
    // thus, we use this method (uses implicit functions, half-spaces, and cross products)
    return (intersectionPointLine(L2_1,L1_1,L1_2)*intersectionPointLine(L2_2,L1_1,L1_2)<=0 && 
      intersectionPointLine(L1_1,L2_1,L2_2)*intersectionPointLine(L1_2,L2_1,L2_2)<=0);
  }
  
  static boolean intersectTriRect(PVector T1, PVector T2, PVector T3, PVector R1, PVector R3) {
    PVector R2 = new PVector(R1.x,R3.y);
    PVector R4 = new PVector(R3.x,R1.y);
    
    //check if rectangle is in triangle
    if(pointInRect(T1,R1,R3) || pointInRect(T2,R1,R3) || pointInRect(T3,R1,R3)) {
      return true;
    }
    
    //check if triangle is in rectangle
    if(pointInRect(T1,R1,R3) || pointInRect(T2,R1,R3) || pointInRect(T3,R1,R3)) {
      return true;
    }
    
    /*
    Lines: ([T1T2,T1T3,T2T3],[R1R2,R2R3,R3R4,R1R4])
    */
    PVector[][] triangleLines = new PVector[][]{
      {T1,T2}
      ,{T1,T3}
      ,{T1,T3}
    };
    
    PVector[][] rectLines = new PVector[][]{
      {R1,R2}
      ,{R2,R3}
      ,{R3,R4}
      ,{R1,R4}
    };
    
    for(int i = 0; i<triangleLines.length; i++) {
      for(int j = 0; j<rectLines.length; j++) {
        if(intersectLineLine(triangleLines[i][0],triangleLines[i][1],rectLines[j][0],rectLines[j][1])) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  static boolean angleInRange(float testAngle, float angleA, float angleB){
    // calc (short for calculate) the diff between A and B
    float directDiff = abs(angleB - angleA);
    float wraparoundDiff = 360 - directDiff; // wrap around refers to
    
    // if using smaller angle sector
    if (directDiff <= wraparoundDiff) {
        // Direct sector (no wraparound needed)
        float minAngle = min(angleA, angleB);
        float maxAngle = max(angleA, angleB);
        return testAngle >= minAngle && testAngle <= maxAngle;
    } else {
        // if using bigger angle sector (crosses boundary of Q1 and Q4)
        float startAngle = max(angleA, angleB);
        float endAngle = min(angleA, angleB);
        
        // Point is in sector if: between startAngle and 360 or Between 0 and endAngle
        return (testAngle >= startAngle && testAngle <= 360) || 
               (testAngle >= 0 && testAngle <= endAngle);
    }
  }
  
  static boolean pointInArc(PVector P1, PVector C0, PVector C1, PVector C2) {
    // C0 is center, C1 and C2 are on circle -> find if P1 is between the arc of C1 to C2
    
    // translates all vectors to origin to simplify
    P1.sub(C0);
    C1.sub(C0);
    C2.sub(C0);
    
    
    // if point is outside circle -> point can not be in arc
    if(!pointInCircle(P1,new PVector(0,0),C1.mag())) {
      return false;
    }
    
    float angP = normalizeAngle(degrees(atan2(P1.y,P1.x)));
    float angA = normalizeAngle(degrees(atan2(C1.y,C1.x)));
    float angB = normalizeAngle(degrees(atan2(C2.y,C2.x)));
    
    return angleInRange(angP,angA,angB);
  }
  
  static boolean pointInCircle(PVector P1, PVector C0, float r) {
    return P1.sub(C0).mag()<=r;
  }
  
  static boolean intersectCircleRect(PVector C0, float radius, PVector R1, PVector R3) { 
    float rectLeft = min(R1.x, R3.x);
    float rectRight = max(R1.x, R3.x);
    float rectTop = min(R1.y, R3.y);
    float rectBottom = max(R1.y, R3.y);
    
    // closest point on rect
    PVector closest = new PVector(constrain(C0.x, rectLeft, rectRight),constrain(C0.y, rectTop, rectBottom));
    
    return pointInCircle(closest,C0,radius);
  }
}

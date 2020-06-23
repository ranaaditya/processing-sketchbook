/**
@author David Burnett
@edited by ranaaditya
*/

int cityNumber = 0;

int penx = 0;
int peny = 0;
int de = 2;
cLista lista = new cLista();
int el0 = 0;
 
int by;
 
// ------------------------------------------------------------
 
void setup() {
  size(800, 600);
//  size(1024, 768);
//  size(screen.width, screen.height);
  smooth();
  frameRate(30);
  colorMode(HSB, 1);
  ellipseMode(CENTER);
  stroke(0, 0, 0, 0.7);
  background(0, 0, 1);
//  strokeWeight(0.3 * de + 1);
strokeWeight(2);
   
  city();
}
 
// ------------------------------------------------------------
 
void draw() {
  int t = 0;
  while((t++ < 50) && (el0 < lista.nr)) {
    lista._draw(el0++);
  }
  if (el0 == lista.nr) {
    noLoop();
  }
}
 
// ------------------------------------------------------------
 
void mouseClicked() {
  lista.nr = 0;
  el0 = 0;
  city();
  background(0, 0, 1);
  loop();
}
 
// ------------------------------------------------------------
 
void keyPressed()
{
  if( key == 's') {
    saveFrame("city"+cityNumber+".jpg");
    cityNumber++;
  }
}
 
// ------------------------------------------------------------
 
void city() {
 
  // cielo nero
//  rettf(0, 0, width, int(0.95*height));
  // luna
  int rag = height / 10;
  lista.agg(0, (int)random(rag, width-rag), (int)random(0.3*height, 0.5*height-rag));
  lista.agg(6, rag, 0);
 
  // strade
  PVector p1;
  PVector p2;
  p1 = proietta(new PVector(-10, 0, 240));
  p2 = proietta(new PVector(-10, 0, -60));
  linea(p1, p2);
  p1 = proietta(new PVector(-20, 0, 240));
  p2 = proietta(new PVector(-20, 0, -60));
  linea(p1, p2);
  p1 = proietta(new PVector(-40, 0, -5));
  p2 = proietta(new PVector(240, 0, -5));
  linea(p1, p2);
  p1 = proietta(new PVector(-40, 0, -15));
  p2 = proietta(new PVector(240, 0, -15));
  linea(p1, p2);
 
  palazzo(new PVector(40, 0, 80));
  palazzo(new PVector(40, 0, 40));
  for(int z=9; z>0; z--) {
    palazzo(new PVector(0, 0, z*40));
  }
  for(int x=6; x>=0; x--) {
    palazzo(new PVector(x*40, 0, 0));
  }
 
  // alberi
  for(int x=220; x>=0; x-=40) {
    albero(new PVector(x, 0, -2));
    albero(new PVector(-2, 0, x));
  }
 
  // semafori
  semaforox(new PVector( 0, 0, 162));
  semaforox(new PVector( 0, 0,  82));
  semaforox(new PVector( 0, 0,   2));
  semaforoz(new PVector(82, 0,   0));
  semaforoz(new PVector( 2, 0,   0));
   
  palazzo(new PVector(0, 0, -53));
}
 
// ------------------------------------------------------------
 
PVector proietta(PVector pt) {
  float d = 60.00;
  float h = 1.50; 
  float alfa = radians(30);
   
  float a = pt.x * sin(alfa) - pt.z * cos(alfa);
  float b = pt.x * cos(alfa) + pt.z * sin(alfa);
  float x = d * a / (b + d);
  float y = d * (pt.y - h) / (b + d);
   
  float sc = height / 90;
  return new PVector(0.63*width + sc*x, 0.95*height - sc*y);
}
 
// ------------------------------------------------------------
 
void palazzo(PVector pt) { 
  int tipo = int(random(10)); 
  int h = int(random(50, 100));
  boolean insegne = false;
  switch (tipo) {
    case 0:
      box3d(new PVector(pt.x+20, h, pt.z+10), new PVector(pt.x+21, h+random(20, 40), pt.z+11));
      box3d(new PVector(pt.x+10, h, pt.z+10), new PVector(pt.x+11, h+random(20, 40), pt.z+11));
      rettangolo_bianco(new PVector(pt.x, h, pt.z), new PVector(pt.x+30, h, pt.z), new PVector(pt.x+30, h, pt.z+30), new PVector(pt.x, h, pt.z+30));
      box3d(new PVector(pt.x, 20, pt.z), new PVector(pt.x+30, h-4, pt.z+30));
      for (int fi=30-3; fi>0; fi-=3) {
        linea(proietta(new PVector(pt.x, 20, pt.z+fi)), proietta(new PVector(pt.x, h-4, pt.z+fi)));
        linea(proietta(new PVector(pt.x+fi, 20, pt.z)), proietta(new PVector(pt.x+fi, h-4, pt.z)));
      }
      box3d(pt, new PVector(pt.x+30, 19, pt.z+30));
      insegne = true;
      break;
    case 1:
      int nr = int(random(5, 20));
      for (int i=nr-1; i>=0; i--) {
        box3d(new PVector(pt.x, i*4+4, pt.z), new PVector(pt.x+30, i*4+6, pt.z+30));
      }
      pilotis(pt, 30, 30, 4);
      insegne = true;
      break;
    case 2:
      box3d(new PVector(pt.x+1, h-10, pt.z+1), new PVector(pt.x+29, h, pt.z+29));
      box3d(new PVector(pt.x+ 2, 10, pt.z+22), new PVector(pt.x+ 4, h-10, pt.z+28));
      box3d(new PVector(pt.x+22, 10, pt.z+ 2), new PVector(pt.x+28, h-10, pt.z+ 4));
      box3d(new PVector(pt.x+ 4, 10, pt.z+ 4), new PVector(pt.x+22, h-10, pt.z+22));
      box3d(new PVector(pt.x+ 2, 10, pt.z+ 2), new PVector(pt.x+ 8, h-10, pt.z+ 8));
      basamento(pt, 10);
      insegne = true;
      break;
    case 3:
      box3d(new PVector(pt.x+14.5, h, pt.z+14.5), new PVector(pt.x+15.5, h+40, pt.z+15.5));
      if (h > 50) box3d(new PVector(pt.x+2, 50, pt.z+2), new PVector(pt.x+28, h, pt.z+28));
      if (h > 50) box3d(new PVector(pt.x+4, 42, pt.z+4), new PVector(pt.x+26, 50, pt.z+26));
      if (h > 42) box3d(new PVector(pt.x+2, 16, pt.z+2), new PVector(pt.x+28, 42, pt.z+28));
      if (h > 16) box3d(new PVector(pt.x+4, 12, pt.z+4), new PVector(pt.x+26, 16, pt.z+26));
      if (h > 12) basamento(pt, 12);
      insegne = true;
      break;
    case 4:
      cilindro3d(new PVector(pt.x, 31, pt.z), h-16, 32, 13, true);
      cilindro3d(new PVector(pt.x, 26, pt.z),    4, 32, 13, true);
      cilindro3d(new PVector(pt.x, 21, pt.z),    4, 32, 13, true);
      cilindro3d(new PVector(pt.x, 16, pt.z),    4, 32, 13, true);
      cilindro3d(new PVector(pt.x, 12, pt.z),    4, 32, 11, true);
      cilindro3d(new PVector(pt.x,  0, pt.z),   12, 32, 15, false);
      break;
    case 5:
      cilindro3d(new PVector(pt.x, h-2, pt.z), 2, 8, 13, true);
      cilindro3d(new PVector(pt.x, h-6, pt.z), 4, 8, 9, true);
      cilindro3d(new PVector(pt.x, 8, pt.z), h-14, 8, 13, true);
      basamento(pt, 8);
      insegne = true;
      break;
    case 6: // giardino
      box3d(pt, new PVector(pt.x+30, pt.y+1, pt.z+30));
      for (int i=0; i<10; i++) {
        float pz = map(i, 0, 10, 0, 22);
        float px = random(0, pz);
        PVector pt0 = new PVector(pt.x+26-px, pt.y+1, pt.z+26-pz+px);
        albero(pt0);
      }
      break;
    case 7:
      box3d(new PVector(pt.x+5, 32, pt.z+5), new PVector(pt.x+25, h, pt.z+25));
      box3d(new PVector(pt.x+10, 26, pt.z+10), new PVector(pt.x+20, 32, pt.z+20));
      box3d(new PVector(pt.x+5, 26, pt.z+24), new PVector(pt.x+5, 32, pt.z+25));
      box3d(new PVector(pt.x+5, 26, pt.z+18), new PVector(pt.x+5, 32, pt.z+19));
      box3d(new PVector(pt.x+5, 26, pt.z+11), new PVector(pt.x+5, 32, pt.z+12));
      box3d(new PVector(pt.x+24, 26, pt.z+5), new PVector(pt.x+25, 32, pt.z+6));
      box3d(new PVector(pt.x+18, 26, pt.z+5), new PVector(pt.x+19, 32, pt.z+6));
      box3d(new PVector(pt.x+11, 26, pt.z+5), new PVector(pt.x+12, 32, pt.z+6));
      box3d(new PVector(pt.x+ 5, 26, pt.z+5), new PVector(pt.x+ 6, 32, pt.z+6));
      cilindro3d(new PVector(pt.x, 6, pt.z), 20, 25, 15, false);
      box3d(new PVector(pt.x+10, 0, pt.z+10), new PVector(pt.x+20, 6, pt.z+20));
      box3d(new PVector(pt.x+5, 0, pt.z+24), new PVector(pt.x+5, 6, pt.z+25));
      box3d(new PVector(pt.x+5, 0, pt.z+18), new PVector(pt.x+5, 6, pt.z+19));
      box3d(new PVector(pt.x+5, 0, pt.z+11), new PVector(pt.x+5, 6, pt.z+12));
      box3d(new PVector(pt.x+24, 0, pt.z+5), new PVector(pt.x+25, 6, pt.z+6));
      box3d(new PVector(pt.x+18, 0, pt.z+5), new PVector(pt.x+19, 6, pt.z+6));
      box3d(new PVector(pt.x+11, 0, pt.z+5), new PVector(pt.x+12, 6, pt.z+6));
      box3d(new PVector(pt.x+ 5, 0, pt.z+5), new PVector(pt.x+ 6, 6, pt.z+6));
      insegne = true;
      break;
    case 8:
      box3d(new PVector(pt.x+2, 6, pt.z+2), new PVector(pt.x+18, h-10, pt.z+18));
      box3d(new PVector(pt.x, 0, pt.z+23), new PVector(pt.x+2, h  , pt.z+28));
      box3d(new PVector(pt.x, 0, pt.z+18), new PVector(pt.x+2, h-5, pt.z+23));
      box3d(new PVector(pt.x, 0, pt.z+ 7), new PVector(pt.x+2, h-5, pt.z+12));
      box3d(new PVector(pt.x, 0, pt.z+ 2), new PVector(pt.x+2, h  , pt.z+ 7));
      box3d(new PVector(pt.x+23, 0, pt.z), new PVector(pt.x+28, h  , pt.z+2));
      box3d(new PVector(pt.x+18, 0, pt.z), new PVector(pt.x+23, h-5, pt.z+2));
      box3d(new PVector(pt.x+ 7, 0, pt.z), new PVector(pt.x+12, h-5, pt.z+2));
      box3d(new PVector(pt.x+ 2, 0, pt.z), new PVector(pt.x+ 7, h  , pt.z+2));
      insegne = true;
      break;
    case 9:
      cilindro3d(new PVector(pt.x, 0, pt.z), h, 32, 11, true);
      box3d(new PVector(pt.x, 0, pt.z+15), new PVector(pt.x+4, h, pt.z+30));
      box3d(new PVector(pt.x+15, 0, pt.z), new PVector(pt.x+30, h, pt.z+4));
      insegne = true;
      break;
  }
   
  if (insegne) {
    float iw = random(1, 1.5);
    float ih = random(2, 10);
    float ipos = random(2, 14);
    rettangolo_bianco(new PVector(pt.x+ipos, 4, pt.z-1), new PVector(pt.x+ipos, 4+ih, pt.z-1), new PVector(pt.x+ipos, 4+ih, pt.z-1-iw), new PVector(pt.x+ipos, 4, pt.z-1-iw));
    iw = random(1, 1.5);
    ih = random(2, 10);
    ipos = random(2, 14) + 15;
    rettangolo_bianco(new PVector(pt.x+ipos, 4, pt.z-1), new PVector(pt.x+ipos, 4+ih, pt.z-1), new PVector(pt.x+ipos, 4+ih, pt.z-1-iw), new PVector(pt.x+ipos, 4, pt.z-1-iw));
    iw = random(1, 1.5);
    ih = random(2, 10);
    ipos = random(2, 14);
    rettangolo_bianco(new PVector(pt.x-1, 4, pt.z+ipos), new PVector(pt.x-1, 4+ih, pt.z+ipos), new PVector(pt.x-1-iw, 4+ih, pt.z+ipos), new PVector(pt.x-1-iw, 4, pt.z+ipos));
    iw = random(1, 1.5);
    ih = random(2, 10);
    ipos = random(2, 14) + 15;
    rettangolo_bianco(new PVector(pt.x-1, 4, pt.z+ipos), new PVector(pt.x-1, 4+ih, pt.z+ipos), new PVector(pt.x-1-iw, 4+ih, pt.z+ipos), new PVector(pt.x-1-iw, 4, pt.z+ipos));
  }
}
 
// ------------------------------------------------------------
 
void basamento(PVector pt, float h) {
  int nr1 = int(random(1, 5));
  int nr2 = int(random(1, 5));
  float inter1 = 27.0 / nr1;
  float inter2 = 27.0 / nr2;
  box3d(pt, new PVector(pt.x+30, h, pt.z+30));
  rettangolo_rigato(new PVector(pt.x, 6, pt.z+2), new PVector(pt.x, h-2, pt.z+2), new PVector(pt.x, h-2, pt.z+28), new PVector(pt.x, 6, pt.z+28));
  for (int i=0; i<nr1; i++) {
    rettangolo_rigato(new PVector(pt.x, 0, pt.z+2+i*inter1), new PVector(pt.x, 4, pt.z+2+i*inter1), new PVector(pt.x, 4, pt.z+1+(i+1)*inter1), new PVector(pt.x, 0, pt.z+1+(i+1)*inter1));
  }
  rettangolo_nero(new PVector(pt.x+2, 6, pt.z), new PVector(pt.x+2, h-2, pt.z), new PVector(pt.x+28, h-2, pt.z), new PVector(pt.x+28, 6, pt.z));
  for (int i=0; i<nr2; i++) {
    rettangolo_nero(new PVector(pt.x+2+i*inter2, 0, pt.z), new PVector(pt.x+2+i*inter2, 4, pt.z), new PVector(pt.x+1+(i+1)*inter2, 4, pt.z), new PVector(pt.x+1+(i+1)*inter2, 0, pt.z));
  }
}
 
// ------------------------------------------------------------
 
void albero(PVector pt0) {
  PVector pt1 = pt0.get();
  pt1.y += 4;
  PVector pt2 = pt1.get();
  pt2.x += 2;
  pt2.z -= 2;
  PVector pp0 = proietta(pt0);
  PVector pp1 = proietta(pt1);
  PVector pp2 = proietta(pt2);
  lista.agg(0, (int)pp1.x, (int)pp1.y);
  lista.agg(6, int(pp2.x-pp1.x), 0);
  dlinea(pp0, pp1);
}
 
// ------------------------------------------------------------
 
void semaforox(PVector pt0) {
  linea(proietta(new PVector(pt0.x -2, 0, pt0.z)), proietta(new PVector(pt0.x -2, 5, pt0.z)));
  linea(proietta(new PVector(pt0.x-28, 0, pt0.z)), proietta(new PVector(pt0.x-28, 5, pt0.z)));
  linea(proietta(new PVector(pt0.x -2, 4, pt0.z)), proietta(new PVector(pt0.x-28, 4, pt0.z)));
  linea(proietta(new PVector(pt0.x -2, 5, pt0.z)), proietta(new PVector(pt0.x-28, 5, pt0.z)));
  rettangolo_bianco(new PVector(pt0.x -4, 4, pt0.z), new PVector(pt0.x -4, 5, pt0.z), new PVector(pt0.x -9, 5, pt0.z), new PVector(pt0.x -9, 4, pt0.z));
  rettangolo_bianco(new PVector(pt0.x-11, 4, pt0.z), new PVector(pt0.x-11, 5, pt0.z), new PVector(pt0.x-19, 5, pt0.z), new PVector(pt0.x-19, 4, pt0.z));
  rettangolo_bianco(new PVector(pt0.x-21, 4, pt0.z), new PVector(pt0.x-21, 5, pt0.z), new PVector(pt0.x-26, 5, pt0.z), new PVector(pt0.x-26, 4, pt0.z));
}
 
// ------------------------------------------------------------
 
void semaforoz(PVector pt0) {
  linea(proietta(new PVector(pt0.x, 0, pt0.z -2)), proietta(new PVector(pt0.x, 5, pt0.z -2)));
  linea(proietta(new PVector(pt0.x, 0, pt0.z-18)), proietta(new PVector(pt0.x, 5, pt0.z-18)));
  linea(proietta(new PVector(pt0.x, 4, pt0.z -2)), proietta(new PVector(pt0.x, 4, pt0.z-18)));
  linea(proietta(new PVector(pt0.x, 5, pt0.z -2)), proietta(new PVector(pt0.x, 5, pt0.z-18)));
  rettangolo_bianco(new PVector(pt0.x, 4, pt0.z -4), new PVector(pt0.x, 5, pt0.z -4), new PVector(pt0.x, 5, pt0.z -9), new PVector(pt0.x, 4, pt0.z -9));
  rettangolo_bianco(new PVector(pt0.x, 4, pt0.z-11), new PVector(pt0.x, 5, pt0.z-11), new PVector(pt0.x, 5, pt0.z-16), new PVector(pt0.x, 4, pt0.z-16));
}
 
// ------------------------------------------------------------
 
void box3d(PVector pt1, PVector pt2) {
  PVector p1 = proietta(new PVector(pt1.x, pt1.y, pt2.z));
  PVector p2 = proietta(new PVector(pt1.x, pt2.y, pt2.z));
  PVector p3 = proietta(new PVector(pt1.x, pt1.y, pt1.z));
  PVector p4 = proietta(new PVector(pt1.x, pt2.y, pt1.z));
  PVector p5 = proietta(new PVector(pt2.x, pt1.y, pt1.z));
  PVector p6 = proietta(new PVector(pt2.x, pt2.y, pt1.z));
  PVector p7 = proietta(new PVector(pt2.x, pt1.y, pt2.z));
 
  lista.agg(3, (int)p1.x, (int)p1.y);
  lista.agg(3, (int)p2.x, (int)p2.y);
  lista.agg(3, (int)p4.x, (int)p4.y);
  lista.agg(3, (int)p6.x, (int)p6.y);
  lista.agg(3, (int)p5.x, (int)p5.y);
  lista.agg(4, (int)p7.x, (int)p7.y);
 
  if (p7.y > p1.y) {
    lista.agg(3, (int)p1.x, (int)p1.y);
    lista.agg(3, (int)p3.x, (int)p3.y);
    lista.agg(3, (int)p5.x, (int)p5.y);
    lista.agg(5, (int)p7.x, (int)p7.y);
  }
   
  _dlinea((int)p1.x, (int)p1.y, (int)p3.x, (int)p3.y);
  _dlinea((int)p1.x, (int)p1.y, (int)p2.x, (int)p2.y);
  _dlinea((int)p2.x, (int)p2.y, (int)p4.x, (int)p4.y);
  _dlinea((int)p3.x, (int)p3.y, (int)p4.x, (int)p4.y);
  _dlinea((int)p3.x, (int)p3.y, (int)p5.x, (int)p5.y);
  _dlinea((int)p5.x, (int)p5.y, (int)p6.x, (int)p6.y);
  _dlinea((int)p4.x, (int)p4.y, (int)p6.x, (int)p6.y);
  if (p7.y > p1.y) {
    _dlinea((int)p1.x, (int)p1.y, (int)p7.x, (int)p7.y);
    _dlinea((int)p5.x, (int)p5.y, (int)p7.x, (int)p7.y);
  }
   
  striscia(pt2.y - pt1.y, p3, p4, p5, p6);
}
 
// ------------------------------------------------------------
 
void cilindro3d(PVector pt, float h, int nrseg, float rad, boolean contorno) {
  PVector [][] pv = new PVector[nrseg][2];
  for (int i=0; i<nrseg; i++) {
    float alfa = map(i, 0, nrseg, 0, TWO_PI);
    pv[i][0] = proietta(new PVector(pt.x+15+rad*cos(alfa), pt.y, pt.z+15-rad*sin(alfa)));
    pv[i][1] = proietta(new PVector(pt.x+15+rad*cos(alfa), pt.y+h, pt.z+15-rad*sin(alfa)));
  }
  for (int i=0; i<nrseg; i++) {
    int j = (i + nrseg - 1) % nrseg;
    if (pv[i][0].x <= pv[j][0].x) {
      if (i > 0) {
        lista.agg(3, (int)pv[j][0].x, (int)pv[j][0].y);
        lista.agg(3, (int)pv[i][0].x, (int)pv[i][0].y);
        lista.agg(3, (int)pv[i][1].x, (int)pv[i][1].y);
        lista.agg(4, (int)pv[j][1].x, (int)pv[j][1].y);
      }
    }
  }
  for (int i=0; i<nrseg; i++) {
    lista.agg(3, (int)pv[i][0].x, (int)pv[i][0].y);
  }
  lista.agg(5, (int)pv[0][0].x, (int)pv[0][0].y);
  for (int i=0; i<nrseg; i++) {
    int j = (i + nrseg - 1) % nrseg;
    float alfa = map(i, 0, nrseg, 0, TWO_PI) + 1;
    if (pv[i][0].x <= pv[j][0].x) {
      if (pv[(i+1)%nrseg][0].x >= pv[i][0].x) {
        linea(pv[i][0], pv[i][1]);
      }
      if (contorno) linea(pv[i][0], pv[i][1]);
      if (i > 0) {
        dlinea(pv[j][0], pv[i][0]);
        dlinea(pv[j][1], pv[i][1]);
        if (sin(alfa) > 0) striscia(h, pv[i][0], pv[i][1], pv[j][0], pv[j][1]);
      }
    }
    else {
      if (pv[(i+1)%nrseg][0].x <= pv[i][0].x) {
        linea(pv[i][0], pv[i][1]);
      }
    }
  }
}
 
// ------------------------------------------------------------
 
void pilotis(PVector pt0, float dex, float dez, float h) {
  int nrx = int((dex - 1) / 6);
  int nrz = int((dez - 1) / 6);
  float delx = (dex-1) / nrx;
  float delz = (dez-1) / nrz;
  for (int i=nrz; i>0; i--) {
    box3d(new PVector(pt0.x, 0, pt0.z+i*delz), new PVector(pt0.x+1, h, pt0.z+i*delz+1));
  }
  for (int i=nrx; i>=0; i--) {
    box3d(new PVector(pt0.x+i*delx, 0, pt0.z), new PVector(pt0.x+i*delx+1, h, pt0.z+1));
  }
}
 
// ------------------------------------------------------------
// striscia tratteggiata in orizzontale
 
void striscia(float del, PVector p1, PVector p2, PVector p3, PVector p4) {
  float r1 = (p1.y - p2.y) / del;
  float r2 = (p3.y - p4.y) / del;
  float pp = 0;
  while (pp < del) {
    _linea(int(p1.x), int(p2.y + pp * r1), int(p3.x), int(p4.y + pp * r2));
    pp += 0.5;
  }
}
 
// ------------------------------------------------------------
 
void rettangolo_bianco(PVector pt1, PVector pt2, PVector pt3, PVector pt4) {
  PVector p1 = proietta(pt1);
  PVector p2 = proietta(pt2);
  PVector p3 = proietta(pt3);
  PVector p4 = proietta(pt4);
  lista.agg(3, (int)p1.x, (int)p1.y);
  lista.agg(3, (int)p2.x, (int)p2.y);
  lista.agg(3, (int)p3.x, (int)p3.y);
  lista.agg(4, (int)p4.x, (int)p4.y);
  linea(p1, p2);
  linea(p2, p3);
  linea(p3, p4);
  linea(p4, p1);
}
 
void rettangolo_rigato(PVector pt1, PVector pt2, PVector pt3, PVector pt4) {
  rettangolo_bianco(pt1, pt2, pt3, pt4);
  striscia(pt2.y - pt1.y, proietta(pt1), proietta(pt2), proietta(pt4), proietta(pt3));
}
 
void rettangolo_nero(PVector pt1, PVector pt2, PVector pt3, PVector pt4) {
  PVector p1 = proietta(pt1);
  PVector p2 = proietta(pt2);
  PVector p3 = proietta(pt3);
  PVector p4 = proietta(pt4);
  lista.agg(3, (int)p1.x, (int)p1.y);
  lista.agg(3, (int)p2.x, (int)p2.y);
  lista.agg(3, (int)p3.x, (int)p3.y);
  lista.agg(5, (int)p4.x, (int)p4.y);
}
 
// ------------------------------------------------------------
 
// rettangolo pieno
void rettf(int sx, int sy, int ex, int ey) {
   
  int dex = ex - sx;
  int dey = ey - sy;
  lista.agg(0, sx, sy);
  for (int i=0; i<min(dex, dey); i+=6) {
    lista.agg(1, sx, sy + i);
    lista.agg(1, sx + i, sy);
  }
  if (dex > dey) {
    for (int i=0; i<dex-dey; i+=6) {
      lista.agg(1, sx + i, ey);
      lista.agg(1, sx + dey + i, sy);
    }
  }
  else {
    for (int i=0; i<dey-dex; i+=6) {
      lista.agg(1, sx, sy + dex + i);
      lista.agg(1, ex, sy + i);
    }
  }
  for (int i=min(dex, dey); i>=0; i-=6) {
    lista.agg(1, ex - i, ey);
    lista.agg(1, ex, ey - i);
  }
}
 
// ------------------------------------------------------------
 
void _linea(int sx, int sy, int ex, int ey) {
  lista.agg(0, sx, sy);
  lista.agg(1, ex, ey);
}
 
void linea(PVector p1, PVector p2) {
  _linea((int)p1.x, (int)p1.y, (int)p2.x, (int)p2.y);
}
 
// ------------------------------------------------------------
 
void _dlinea(int sx, int sy, int ex, int ey) {
  _linea(sx, sy, ex, ey);
  _linea(sx, sy, ex, ey);
}
 
void dlinea(PVector p1, PVector p2) {
  _dlinea((int)p1.x, (int)p1.y, (int)p2.x, (int)p2.y);
}
 
// ------------------------------------------------------------
 
class cLista {
  int mat[][] = new int [100000][3];
  int nr = 0;
  PVector [] pv = new PVector[100];
  int nrv = 0;
 
  cLista() {
    for (int i=0; i<pv.length; i++) {
      pv[i] = new PVector(0, 0);
    }
  }
   
  void agg(int tipo, int px, int py) {
    mat[nr][0] = tipo;
    mat[nr][1] = px + int(random(-de, de));
    mat[nr][2] = py + int(random(-de, de));
    nr++;
  }
   
  void _draw(int el) {
    switch(mat[el][0]) {
      case 0: // move to
        penx = mat[el][1];
        peny = mat[el][2];
        break;
      case 1: // line to
        stroke(0, 0, 0, 0.5);
        noFill();
        line(penx, peny, mat[el][1], mat[el][2]);
        penx = mat[el][1];
        peny = mat[el][2];
        break;
      case 2: // rettangolo pieno
        noStroke();
        fill(0, 0, 1);
        rect(penx, peny, mat[el][1] - penx, mat[el][2] - peny);
        break;
      case 3: // vertice poligono pieno
        pv[nrv].x = mat[el][1];
        pv[nrv].y = mat[el][2];
        nrv++;
        break;
      case 4: // chiusura poligono pieno bianco
        pv[nrv].x = mat[el][1];
        pv[nrv].y = mat[el][2];
        nrv++;
        noStroke();
        fill(0, 0, 1);
        beginShape();
        for (int i=0; i<nrv; i++) {
          vertex(pv[i].x, pv[i].y);
        }
        endShape(CLOSE);
        nrv = 0;
        break;
      case 5: // chiusura poligono pieno nero
        pv[nrv].x = mat[el][1];
        pv[nrv].y = mat[el][2];
        nrv++;
        noStroke();
        fill(0, 0, 0);
        beginShape();
        for (int i=0; i<nrv; i++) {
          vertex(pv[i].x, pv[i].y);
        }
        endShape(CLOSE);
        nrv = 0;
        break;
      case 6: // sfera
        int px0;
        int py0;     
        int px1 = 0;
        int py1 = 0;
        int nrs = height / 6;
        float ra = random(2.1, 2.4);
        noStroke();
        fill(0, 0, 1);
        ellipse(penx, peny, 2*mat[el][1], 2*mat[el][1]);  
        stroke(0, 0, 0, 0.5);
        noFill();
        for (int i=0; i<nrs; i++) {
          float alfa = map(i, 0, nrs, 0, 2 * TWO_PI);
          px0 = px1;
          py0 = py1;
          float rad = mat[el][1] + 2 * de * sin(ra*alfa);
          px1 = penx + int(rad * cos(alfa));
          py1 = peny + int(rad * sin(alfa));
          if (i > 0) {
            line(px0, py0, px1, py1);
          }
        }
        break;
    }
  }
}
 
// ------------------------------------------------------------

player p;
float[] PlayField = new float[2];
ArrayList<food> foods = new ArrayList();
ArrayList<player> players = new ArrayList();
int count;
boolean deadpl = false;
void setup() {
  fullScreen();
  colorMode(HSB);
  PlayField[0] = 2*width;
  PlayField[1] = 2*height;
  for (int i=0; i<20; i++) {
    players.add(new player(count,0));
    count++;
  }
  p = new player(-1,0);
}

void draw() {
  background(0);
  for (int i=0; i<300-foods.size(); i++) {
    foods.add(new food());
  }
  for (int i=0; i<20-players.size(); i++) {
    players.add(new player(count,1));
    count++;
  }
  
  p.show(true);
  p.update();
  
  for (int i = 0; i < players.size(); i++) {
    player pl = players.get(i);
    pl.show(false);
    pl.updateAI();
    if(dist(pl.pos.x,pl.pos.y,p.pos.x,p.pos.y) <= abs(pl.r-p.r) && deadpl == false) {
      if (pl.r<p.r) {
        p.A += pl.A;
        players.remove(i);
      }
      else {
        //noLoop();
        deadpl = true;
        
      }
    }
    if (deadpl==true) {
      textAlign(CENTER);
        textSize(50);
        fill(0);
        text("GAME OVER",p.pos.x, p.pos.y);
    }
    for (int j = 0; j < players.size(); j++) {
      player pl2 = players.get(j);
      if(dist(pl.pos.x,pl.pos.y,pl2.pos.x,pl2.pos.y) <= abs(pl.r-pl2.r) && pl2 != pl) {
        if (pl.r<pl2.r) {
          pl2.A += pl.A;
          players.remove(i);
        }
        else {
          pl.A += pl2.A;
          players.remove(j);
        }
      }
    }
  }
  
  for (int i = foods.size()-1; i >=0 ; i--) {
    food f = foods.get(i);
    f.show();
    boolean dead = false;
    if(dist(p.pos.x,p.pos.y,f.pos.x,f.pos.y) <= (p.r-f.r) && deadpl == false) {
      p.A+=f.A;
      dead=true;
    }
    for (int j = 0; j < players.size(); j++) {
    player pl = players.get(j);
      if(dist(pl.pos.x,pl.pos.y,f.pos.x,f.pos.y) <= (pl.r-f.r)) {
        pl.A+=2*f.A;
        dead=true;
      }
    }
    if(dead) {
      foods.remove(i);
    }
  }
  
}
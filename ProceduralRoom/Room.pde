class Room{
  PVector[] points = new PVector[2];
  ArrayList<PVector> room_positions = new ArrayList<PVector>();
  ArrayList<PVector> room_cracks = new ArrayList<PVector>();
  int id = -1;
  int floorStyle = -1;
  Room(int id) {
    this.id = id;
    this.floorStyle = int(random(0,5));
  }
  
  
  void set_cracks() {
    for(PVector pos : room_positions)
      if (int(random(100)) == 0) room_cracks.add(new PVector(pos.x,pos.y,int(random(0,4))));
  }
  
  
  void add_doors(){
    ArrayList<PVector> doors = new ArrayList<PVector>();
    ArrayList<PVector> connected_walls = new ArrayList<PVector>();
    
    //Top
    for(int x = int(this.points[0].x); x < this.points[0].x+this.points[1].x;x++){
      if(Grid[x-1][int(points[0].y-1)] == 6 && Grid[x+1][int(points[0].y-1)] == 6 && Grid[x][int(points[0].y)] != 6 && Grid[x][int(points[0].y-1)] == 6) connected_walls.add(new PVector(x,int(points[0].y-1)));
      if(Grid[x][int(points[0].y-1)] == 8) doors.add(new PVector(x,int(points[0].y-1)));
    }
    if(doors.size() == 0 && connected_walls.size() > 0){
     int index = int(random(0,connected_walls.size()));
     Grid[int(connected_walls.get(index).x)][int(connected_walls.get(index).y)]= 8;
    }
    
    //Side
    doors = new ArrayList<PVector>();
    connected_walls = new ArrayList<PVector>();
    for(int y = int(this.points[0].y); y < this.points[0].y+this.points[1].y;y++){
      if(Grid[int(points[0].x-1)][y-1] == 6 && Grid[int(points[0].x-1)][y+1] == 6 && Grid[int(points[0].x)][y] != 6 && Grid[int(points[0].x-1)][y] == 6) connected_walls.add(new PVector(int(points[0].x-1),y));
      if(Grid[int(points[0].x-1)][y] == 8) doors.add(new PVector(int(points[0].x-1),y));
    }
    if(doors.size() == 0 && connected_walls.size() > 0){
     int index = int(random(0,connected_walls.size()));
     Grid[int(connected_walls.get(index).x)][int(connected_walls.get(index).y)]= 8;
    }
    
  }
  
  void add_windows(){
    ArrayList<PVector> connected_walls = new ArrayList<PVector>();
    
    //Top
    for(int x = int(this.points[0].x); x < this.points[0].x+this.points[1].x;x++){
      if(points[0].y-2 > 0 && x-2 > 0 && x+2 < Grid.length && Grid[x-2][int(points[0].y-1)] == 3 && Grid[x-1][int(points[0].y-1)] == 3 && Grid[x+2][int(points[0].y-1)] == 3 && Grid[x+1][int(points[0].y-1)] == 3 && Grid[x][int(points[0].y-2)] == 0) connected_walls.add(new PVector(x,int(points[0].y-1)));
      //if(x-2 > 0 && x+2 < Grid.length && Grid[x-2][int(points[0].y-1)] == 3 && Grid[x-1][int(points[0].y-1)] == 3 && Grid[x+2][int(points[0].y-1)] == 3 && Grid[x+1][int(points[0].y-1)] == 3) connected_walls.add(new PVector(x,int(points[0].y-1)));
    }
    if(connected_walls.size() >= 5 && random(0,3) < 1){
     for(PVector d : connected_walls) {
       Grid[int(d.x)][int(d.y)]= 9;
     }
    }
    
    //Bottom
    connected_walls = new ArrayList<PVector>();
    for(int x = int(this.points[0].x); x < this.points[0].x+this.points[1].x;x++){
      if(points[0].y+points[1].y+2 < Grid[0].length && x-2 > 0 && x+2 < Grid.length && Grid[x-2][int(points[0].y+points[1].y)] == 3 && Grid[x-1][int(points[0].y+points[1].y)] == 3 && Grid[x+2][int(points[0].y+points[1].y)] == 3 && Grid[x+1][int(points[0].y+points[1].y)] == 3 && Grid[x][int(points[0].y+points[1].y+1)] == 0) connected_walls.add(new PVector(x,int(points[0].y+points[1].y)));
      //if(x-2 > 0 && x+2 < Grid.length && Grid[x-2][int(points[0].y+points[1].y)] == 3 && Grid[x-1][int(points[0].y+points[1].y)] == 3 && Grid[x+2][int(points[0].y+points[1].y)] == 3 && Grid[x+1][int(points[0].y+points[1].y)] == 3) connected_walls.add(new PVector(x,int(points[0].y+points[1].y)));
    }
    if(connected_walls.size() >= 5 && random(0,3) < 1){
     for(PVector d : connected_walls) {
       Grid[int(d.x)][int(d.y)]= 9;
     }
    }
    
    //LeftSide
    connected_walls = new ArrayList<PVector>();
    for(int y = int(this.points[0].y); y < this.points[0].y+this.points[1].y;y++){
      if(y-2 > 0 && y+2 < Grid[0].length && points[0].x-2 > 0 && Grid[int(points[0].x-1)][y-2] == 3 && Grid[int(points[0].x-1)][y-1] == 3 && Grid[int(points[0].x-1)][y+2] == 3 && Grid[int(points[0].x-1)][y+1] == 3 && Grid[int(points[0].x-2)][y] == 0) connected_walls.add(new PVector(int(points[0].x-1),y));
    }
    if(connected_walls.size() >= 5 && random(0,3) < 1){
     for(PVector d : connected_walls) {
       Grid[int(d.x)][int(d.y)]= 9;
     }
    }
    
    //Right Side
    connected_walls = new ArrayList<PVector>();
    for(int y = int(this.points[0].y); y < this.points[0].y+this.points[1].y;y++){
      if(y-2 > 0 && y+2 < Grid[0].length && points[0].x+points[1].x+1 < Grid.length && Grid[int(points[0].x+points[1].x)][y-2] == 3 && Grid[int(points[0].x+points[1].x)][y-1] == 3 && Grid[int(points[0].x+points[1].x)][y+2] == 3 && Grid[int(points[0].x+points[1].x)][y+1] == 3 && Grid[int(points[0].x+points[1].x+1)][y] == 0) connected_walls.add(new PVector(int(points[0].x+points[1].x),y));
    }
    if(connected_walls.size() >= 5 && random(0,3) < 1){
     for(PVector d : connected_walls) {
       Grid[int(d.x)][int(d.y)]= 9;
     }
    }
    
  }
  
}

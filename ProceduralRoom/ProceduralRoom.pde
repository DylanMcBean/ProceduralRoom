import java.util.Arrays;  //<>// //<>//

int[][] Grid = new int[50][50];
PImage walls, floor_cracks;
ArrayList<Room> rooms = new ArrayList<Room>();
boolean effects = true;

int minimum_rooms = 3;
int maximum_rooms = 20; // Larger numbers may lead to slower generation times


void setup() {
  size(1000, 1000);
  //fullScreen(1);
  setGradients();
  gen_house();
  walls = loadImage("data/walls.png");
  floor_cracks = loadImage("data/floor_cracks.png");
}


void draw() {

  background_gradient();

  //Draw effects or not
  if (effects) underlay_effect();
  pushMatrix();
  translate((width/2)-400, (height/2)-400);
  if (effects) {
    translate(width/2, height/2);
    rotate(sin(frameCount/100.0)*0.03);
    translate(-width/2, -height/2);
  }

  //Draw Floors under walls
  int[][] checkPositions = new int[][]{{1, 0}, {0, 1}, {-1, 0}, {0, -1}, {0, 0}};
  for (int x = 0; x < Grid.length; x++) {
    for (int y = 0; y < Grid[0].length; y++) {
      if (Grid[x][y] > 0) {
        if (x+1 < Grid.length && y+1 < Grid[0].length && (Grid[x+1][y+1]>=20||Grid[x+1][y]>=20||Grid[x][y+1]>=20))image(walls, x*16+8, y*16+8, 8, 8, 280, 8, 288, 15);
        if (x-1 >= 0 && y+1 < Grid[0].length && (Grid[x-1][y+1]>=20||Grid[x-1][y]>=20||Grid[x][y+1]>=20))image(walls, x*16, y*16+8, 8, 8, 272, 8, 280, 15);
        if (x+1 < Grid.length && y-1 >= 0 && (Grid[x+1][y-1]>=20||Grid[x+1][y]>=20||Grid[x][y-1]>=20))image(walls, x*16+8, y*16, 8, 8, 280, 0, 288, 8);
        if (x-1 >= 0 && y-1 >= 0 && (Grid[x-1][y-1]>=20||Grid[x-1][y]>=20||Grid[x][y-1]>=20))image(walls, x*16, y*16, 8, 8, 272, 0, 280, 8);
      }
    }
  }

  //Draw Walls, Doors, Windows
  for (int x = 0; x < Grid.length; x++) {
    for (int y = 0; y < Grid[0].length; y++) {
      if (Grid[x][y] > 0) {
        fill(0);
        checkPositions = new int[][]{{1, 0}, {0, 1}, {-1, 0}, {0, -1}, {0, 0}};
        int[][] data = new int[][]{{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
        for (int[] pos : checkPositions)
          if (x+pos[0] < Grid.length && x+pos[0] >= 0 && y+pos[1] < Grid[0].length && y+pos[1] >= 0 && (Grid[x+pos[0]][y+pos[1]] >= 2 && Grid[x+pos[0]][y+pos[1]] <= 7 || Grid[x+pos[0]][y+pos[1]] == 9)) data[pos[0]+1][pos[1]+1] = 2;

        if (Grid[x][y] >= 2 && Grid[x][y] < 7) {
          if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {0, 2, 0}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 240, 16*(Grid[x][y]-2), 255, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {2, 2, 2}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 0, 16*(Grid[x][y]-2), 15, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {2, 2, 2}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 16, 16*(Grid[x][y]-2), 31, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {2, 2, 0}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 32, 16*(Grid[x][y]-2), 47, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {2, 2, 2}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 48, 16*(Grid[x][y]-2), 63, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {0, 2, 2}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 64, 16*(Grid[x][y]-2), 79, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {0, 2, 2}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 80, 16*(Grid[x][y]-2), 95, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {2, 2, 0}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 96, 16*(Grid[x][y]-2), 111, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {2, 2, 0}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 112, 16*(Grid[x][y]-2), 127, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {0, 2, 2}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 128, 16*(Grid[x][y]-2), 143, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {0, 2, 0}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 144, 16*(Grid[x][y]-2), 159, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {2, 2, 0}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 160, 16*(Grid[x][y]-2), 175, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {0, 2, 0}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 176, 16*(Grid[x][y]-2), 191, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {0, 2, 2}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 192, 16*(Grid[x][y]-2), 207, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {2, 2, 2}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 208, 16*(Grid[x][y]-2), 223, (16*(Grid[x][y]-2))+15);
          else if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {0, 2, 0}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 224, 16*(Grid[x][y]-2), 239, (16*(Grid[x][y]-2))+15);
        }

        data = new int[][]{{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
        for (int[] pos : checkPositions)
          if (x+pos[0] < Grid.length && x+pos[0] >= 0 && y+pos[1] < Grid[0].length && y+pos[1] >= 0 && (Grid[x+pos[0]][y+pos[1]] >= 2 && Grid[x+pos[0]][y+pos[1]] <= 8)) data[pos[0]+1][pos[1]+1] = 2;

        if (Grid[x][y] == 8) {
          if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {0, 2, 0}, {0, 2, 0}})) image(walls, x*16-2, y*16+5, 22, 6, 272, 38, 294, 44);
          else if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {2, 2, 2}, {0, 0, 0}})) image(walls, x*16+5, y*16-2, 6, 22, 272, 16, 278, 38);
        }

        data = new int[][]{{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
        for (int[] pos : checkPositions)
          if (x+pos[0] < Grid.length && x+pos[0] >= 0 && y+pos[1] < Grid[0].length && y+pos[1] >= 0 && (Grid[x+pos[0]][y+pos[1]] <= 5 || Grid[x+pos[0]][y+pos[1]] == 9)) data[pos[0]+1][pos[1]+1] = 2;

        if (Grid[x][y] == 9) {
          if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {2, 2, 0}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 272, 64, 288, 80);
          if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {0, 2, 2}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 272, 48, 288, 64);
          if (Arrays.deepEquals(data, new int[][]{{0, 2, 0}, {2, 2, 2}, {0, 0, 0}})) image(walls, x*16, y*16, 16, 16, 288, 48, 304, 64);
          if (Arrays.deepEquals(data, new int[][]{{0, 0, 0}, {2, 2, 2}, {0, 2, 0}})) image(walls, x*16, y*16, 16, 16, 288, 64, 304, 80);
        }
      }
    }
  }

  //Draw Rooms Floors
  for (Room r : rooms) {
    //Draw Base Room Floor
    for (PVector pos : r.room_positions) {
      if (r.floorStyle == 0) image(walls, pos.x*16, pos.y*16, 16, 16, 256, 0, 271, 15);
      else if (r.floorStyle == 1) image(walls, pos.x*16, pos.y*16, 16, 16, 256, 16, 271, 31);
      else if (r.floorStyle == 2) image(walls, pos.x*16, pos.y*16, 16, 16, 256, 32, 271, 47);
      else if (r.floorStyle == 3) image(walls, pos.x*16, pos.y*16, 16, 16, 256, 48, 271, 63);
      else if (r.floorStyle == 4) image(walls, pos.x*16, pos.y*16, 16, 16, 256, 64, 271, 79);
    }
    
    //Draw Floor Cracks
    for(PVector pos : r.room_cracks)
      image(floor_cracks,pos.x*16,pos.y*16,16,16,0,int(pos.z)*16,16,int(pos.z)*16+16);
  }
  popMatrix();
  if (effects) overlay_effect();
}

void gen_house() {
  PVector[] square = new PVector[2];
  boolean failed = true;
  while (failed) {
    rooms = new ArrayList<Room>();
    failed = false;
    for (int x = 0; x < Grid.length; x++) {
      for (int y = 0; y < Grid[0].length; y++) {
        Grid[x][y] = 0;
      }
    }
    //generate random squares
    for (int i = 0; i < random(minimum_rooms, maximum_rooms); i ++) {
      while (true) {
        square[1] = new PVector(int(random(3, 20)), int(random(3, 20)));
        square[0] = new PVector(int(random(1, Grid.length-square[1].x)), int(random(1, Grid[0].length-square[1].y)));

        while (Grid[int(square[0].x)][int(square[0].y)] != 0 && Grid[int(square[0].x+square[1].x)][int(square[0].y+square[1].y)] != 0) {
          square[1] = new PVector(int(random(3, 20)), int(random(3, 20)));
          square[0] = new PVector(int(random(1, Grid.length-(square[1].x+1))), int(random(1, Grid[0].length-(square[1].y+1))));
        }


        if (!failed && square[1].x*square[1].y <= 100) {  
          //Check if room is overlapping any other room
          if (i==0) break;
          boolean found = false;
          for (int x = 1; x < Grid.length-(square[1].x+1) && !found; x+=1) {
            for (int y = 1; y < Grid[0].length-(square[1].y+1) && !found; y+=1) {
              square[0].y = y;
              square[0].x = x;
              if (can_place_room(square[0], square[1])) {
                found = true;
                break;
              }
            }
          }
          if (!found) failed=true;
          break;
        } else {
          failed=true;
          break;
        }
      }
      //Draw squares on Grid
      if (!failed) {
        Room room = new Room(rooms.size());
        for (int x = int(square[0].x); x < int(square[0].x+square[1].x); x++) {
          for (int y = int(square[0].y); y < int(square[0].y+square[1].y); y++) {
            if (Grid[x][y] == 0) {
              room.room_positions.add(new PVector(x, y));
              Grid[x][y] = 20+rooms.size();
            }
          }
        }
        room.points[0] = square[0];
        room.points[1] = square[1];
        rooms.add(room);
      }
    }
  }

  //Get the edges of the squares
  for (int x = 0; x < Grid.length; x++) {
    for (int y = 0; y < Grid[0].length; y++) {
      int count = 0;
      int[][] checkPositions = new int[][]{{1, 0}, {1, 1}, {0, 1}, {-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {1, -1}};
      for (int[] pos : checkPositions)
        if (x+pos[0] < Grid.length && x+pos[0] > 0 && y+pos[1] < Grid[0].length && y+pos[1] > 0 && Grid[x+pos[0]][y+pos[1]]>=20) count++;
      if (Grid[x][y] == 0 && count >= 1 )
        Grid[x][y] = 3;
    }
  }

  //Detect walls that are between 2 rooms
  for (int x = 0; x < Grid.length; x++) {
    for (int y = 0; y < Grid[0].length; y++) {
      ArrayList<Integer> ids = new ArrayList<Integer>();
      int[][] checkPositions = new int[][]{{1, 0}, {1, 1}, {0, 1}, {-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {1, -1}};
      for (int[] pos : checkPositions)
        if (x+pos[0] < Grid.length && x+pos[0] > 0 && y+pos[1] < Grid[0].length && y+pos[1] > 0 && Grid[x+pos[0]][y+pos[1]] >= 20) { 
          if (!(ids.contains(Grid[x+pos[0]][y+pos[1]])))
            ids.add(Grid[x+pos[0]][y+pos[1]]);
        }
      if (Grid[x][y] == 3 && ids.size()>=2)
        Grid[x][y] = 6;
    }
  }

  for (Room r : rooms) {
    r.add_doors();
    r.add_windows();
    r.set_cracks();
  }
}

boolean can_place_room(PVector square_0, PVector square_1) {
  PVector[] roomCheckPositions = new PVector[]{new PVector(0, 2), new PVector(0, -2), new PVector(2, 0), new PVector(-2, 0)};
  PVector[] airCheckPositions = new PVector[]{new PVector(0, 1), new PVector(0, -1), new PVector(1, 0), new PVector(-1, 0)};
  int roomPositions = 0;
  int airPositions = 0;

  for (int x = int(square_0.x); x < square_0.x+square_1.x; x++) {
    for (int y = int(square_0.y); y < square_0.y+square_1.y; y++) {
      if (Grid[x][y] != 0) {
        return false;
      }

      if (x == int(square_0.x) || x == int(square_0.x+square_1.x) || y == int(square_0.y) || y == int(square_0.y+square_1.y)) {
        for (PVector pos : roomCheckPositions)
          if (x+pos.x < Grid.length && x+pos.x >= 0 && y+pos.y < Grid[0].length && y+pos.y >= 0 && Grid[x+int(pos.x)][y+int(pos.y)]>=20) roomPositions++;
        for (PVector pos : airCheckPositions)
          if (x+pos.x < Grid.length && x+pos.x >= 0 && y+pos.y < Grid[0].length && y+pos.y >= 0 && Grid[x+int(pos.x)][y+int(pos.y)]>=20) airPositions++;
      }
    }
  }

  //Make sure room if 2 spaces from another
  if (!(roomPositions >= 3 && airPositions == 0))
    return false;

  return true;
}

void mousePressed() {
  gen_house();
}

void keyPressed(){
 if(key == 'e') effects = !effects; 
}

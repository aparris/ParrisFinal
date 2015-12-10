class Box { //a class for allyour color boxes so you can keep track of what image is associated with what colors
  float x, y;
  String c;
  PImage p;
  String t;
  Box() {
    
  }
  
  void display() { //display the color box
    rect(x, y, 20, 20);  
  }
  
  void showPhoto() { //show the photo associated with the color on mouse press
    fill(0);
    
    rect(0,280, width, 370);
    p.resize(0, 260);
    imageMode (CENTER);
    image(p, width/2, 425);
    String [] splitTitle = split (t, ",");
    
    
    fill (255);
    textSize (12);
    text (splitTitle [0], 23, 585);
    text (splitTitle [1], 20, 610);
    text (splitTitle [2], 20, 635);

  }
  
  
  
  
}
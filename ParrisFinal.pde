//https://www.rijksmuseum.nl/api/en/collection/BK-1990-1?key=8spjHfbq&format=json
//http://rijksmuseum.github.io/

JSONObject image;
JSONArray colours;
PImage picture;
JSONObject c;
String k;
String V;
float currentX, currentY;
ArrayList<Box> colorValues = new ArrayList<Box>(); //instead of strings, use your class here

String [] numbers = {"SK-C-1368","SK-A-500","SK-A-2815","SK-A-3841", "SK-A-372","SK-A-1405",
"SK-A-1451", "SK-A-3148", "SK-A-128", "SK-A-1718", "SK-A-447", "SK-A-4821", "SK-A-133", "SK-A-180", 
"SK-A-1796", "SK-A-135", "SK-A-4830", "SK-A-799", "SK-C-597", "SK-A-3064", "SK-C-5","SK-A-147", 
"SK-A-5005", "SK-C-2", "SK-C-217", "SK-C-109", "SK-A-4", "SK-A-4118", "SK-A-404", "SK-A-4981", 
"SK-C-149", "SK-A-2860", "SK-A-2344", "SK-A-4050","SK-A-742", "SK-C-6", "SK-C-251", "SK-A-3059",
"SK-C-216", "SK-C-211", "SK-C-229", "SK-A-5003", "SK-A-175", "SK-A-2099", "SK-A-3948", "BK-1976-49", 
"SK-A-4100", "SK-A-4688", "SK-A-1065", "NG-2010-38", "NG-2010-40", "NG-2010-37", "NG-2010-39", "NG-2010-41",
"SK-A-2963", "SK-A-1115", "SK-A-2382", "SK-A-3262", "SK-A-1505", "SK-A-3584", "SK-A-3580"};

void setup () {

  background(0);
  size(540,650);
  currentY = 0;
  currentX = 0;

  for (int z=0; z<numbers.length; z++) {
    
    String link = "https://www.rijksmuseum.nl/api/en/collection/"+numbers[z]+"?key=8spjHfbq&format=json";
    image = loadJSONObject(link);
    JSONObject artObject= image.getJSONObject ("artObject");
    String title=artObject.getString("longTitle");
    println(title);
    JSONObject webImage = artObject.getJSONObject("webImage");
    String y = webImage.getString ("url");
    println (y);
    picture = loadImage(y, "png");

    colours = artObject.getJSONArray ("colorsWithNormalization");
    for (int i=0; i<colours.size(); i++) {
      c = colours.getJSONObject(i);
      k = c.getString("normalizedHex"); 
      //println(k);
      k = k.replace("#", "");
      
      //create a new Box object and add the properties to it
      Box b = new Box();
      b.c = k;
      colorValues.add(b);
      b.p = picture; //set the box's PNG to be the current image
      b.t=title;
    }
  }


  for (Box b : colorValues) { //iterate through all the boxes to display colors
    color a = unhex("FF" + b.c);
    fill(a);
    b.x = currentX;
    b.y = currentY;
    b.display(); 

    if (currentX > width) {
      currentX = 0; 
      currentY += 20;
    } else {
      currentX += 20;
    }
  }
}

void draw () {  
}

void mousePressed() {
  for (Box b : colorValues) { //track the mouse position and display associated photo if clicked on a certain box
    if (mouseX > b.x && mouseX < b.x + 20 && mouseY > b.y && mouseY < b.y + 20) {
      println(b.x, b.y);
      b.showPhoto();
    }
  }
}
void setup(){
    size(400, 400);
}

void draw(){
    color white = color (255, 255, 255);
    color black = color (0, 0 ,0);
    color orange = color (255, 165, 0);
    color blue = color (0, 105, 163);
    background(black);

    //draw sun
    fill(orange);
    stroke(orange);
    ellipse(width / 2, height / 2, 75, 75); 
    noFill();

    //draw earth
    int earthPosX = width / 2;
    int earthPosY = height / 4;
    fill(blue);
    stroke(blue);
    ellipse(earthPosX, earthPosY, 50, 50);
    noFill();

    //draw moon
    int moonPosX = earthPosX + 40;
    int moonPosY = earthPosY - 40;
    fill(white);
    stroke(white);
    ellipse(moonPosX, moonPosY, 25, 25);
    noFill();
}


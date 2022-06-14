void setup(){
    size(400, 400);
}

int x = 40;
int y = 200;
int v_x = 3;
int v_y = 0;

int size = 40;
int space = 50;
int amount = 5;

color white = color (255, 255, 255);
color blue = color (0, 105, 163);

void draw(){
    background(white);
    
    x = x + v_x;
    y = y + v_y;

    fill(blue);
    stroke(blue);

    for(int i = 0; i < amount; i++){
        ellipse(x + i * size, y, size, size);
    }
    
    noFill();
     
    if(x <= size / 2){
        v_x = inversion(v_x);
    }else if (x + (amount - 1) * size >= width - size / 20){
        v_x = inversion(v_x);
    }

    
}

int inversion(int speed){
    return speed * (-1);
}
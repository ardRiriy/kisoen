void setup(){
    size(400, 400);
}

int x = 40;
int y = 110;
int v_x = 5;
int v_y = 5;

void draw(){
    background(255, 255, 255);
    
    x = x + v_x;
    y = y + v_y;

    ellipse(x, y, 20, 20);

    if(x <= 20){
        v_x = inversion(v_x);
    }else if (x >= width-20 ){
        v_x = inversion(v_x);
    }

    if(y <= 20){
        v_y = inversion(v_y);
    }else if (y >= height-20 ){
        v_y = inversion(v_y);
    }
    
}

int inversion(int speed){
    return speed * (-1);
}
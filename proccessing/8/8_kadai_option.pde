void setup(){
    size(400, 400);
}

int x = 40;
int y = 300;
int v_x = 3;
int v_y = 0;

void draw(){
    background(255, 255, 255);
    line(0, 325, width, 325);

    x = x + v_x;
    y = y + v_y;

    ellipse(x, y, 20, 20);

    if(x <= 20){
        v_x = inversion(v_x);
    }else if (x >= width-20 ){
        v_x = inversion(v_x);
    }

    if(y < 300){
        v_y++;
    }else if(y >= 300){
        y = 300;
    }
    
}

void keyPressed(){
    if(key == ' ' && y == 300){
        //spaceでジャンプ．ダブルジャンプを不可に
        v_y = -20;
    }    
}

int inversion(int speed){
    return speed * (-1);
}
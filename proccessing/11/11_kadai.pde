//  グローバル変数

float[] x, y, v_x, v_y;
float angle; 

int size    = 40;
int amount  = 10;

color white = color (255, 255, 255);
color blue  = color (0, 105, 163);


// ---------------------------------------------------//
//setupに関する関数群

void setup(){
    size(400, 400);
    
    x   = new float[amount];
    y   = new float[amount];
    v_x = new float[amount];
    v_y = new float[amount];

    setupPos(amount - 1);

}

void setupPos(int n){

    if(n < 0){
        return;
    }

    angle  = random(360);
    x[n]   = random(size / 2, width - 20);
    y[n]   = random(size / 2, height - 20);
    
    v_x[n] = 2 * cos(2 * PI/360 * angle);
    v_y[n] = 2 * sin(2 * PI/360 * angle);

    setupPos(n - 1);
}

// ---------------------------------------------------//
//  draw関係の関数群

void draw(){
    background(white);
    
    for(int i = 0; i < amount ; i++ ){

        updatePos(i);
        drawChar(i);
        checkInversion(i);

    }
}


//  それぞれの速度に応じて位置を更新
void updatePos(int i){
    x[i] = x[i] + v_x[i];
    y[i] = y[i] + v_y[i];
}


//  速度反転の必要があるかどうかを判定
void checkInversion(int n){
    if(x[n] <= size / 2 || x[n] >= width - size / 2){
        v_x[n] = inversion(v_x[n]);
    }
    
    if(y[n] <= size / 2 || y[n] >= height - size / 2){
        v_y[n] = inversion(v_y[n]);
    }
}


//  向きを反転させて返す
float inversion(float speed){
    
    return speed * (-1);
    
}


void drawChar(int n){
    fill(blue);
    stroke(blue);

    ellipse(x[n], y[n], size, size);
    
    
    noFill();
}

// ---------------------------------------------------//
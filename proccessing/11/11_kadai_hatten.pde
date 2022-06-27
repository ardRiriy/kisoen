float angle; 

int size    = 10;
color white = color (255, 255, 255);
color black = color (0, 0, 0);
color blue  = color (0, 105, 163);
color grey  = color (121, 121, 121);
color red   = color (255, 0, 0);
color green = color (0, 255, 0);

/*
0: start menu
1: in game
2: how to play
3: Congrats
4: game over
*/
int game_statue   = 0;
int menuBerAmount = 2;
String[] texts    = new String[menuBerAmount];

int enemy_amount  = 3;
float[] enemyX, enemyY, enemyVx, enemyVy;

int playerPosX;
int playerPosY;

/*
stats
0: 白色，まだ取られていない
1: 緑色，回収済み
*/
int flagSpace     = 40;
int flagAmount;             
int[] flagX, flagY, stats;


void setup(){
    size(400, 400);
    textSize(20);
    texts[0] = "start";
    texts[1] = "How to play";

    enemyX  = new float[enemy_amount];
    enemyY  = new float[enemy_amount]; 
    enemyVx = new float[enemy_amount];
    enemyVy = new float[enemy_amount];

    //  とりあえず500でおいてるけど良くはない
    //  配列を追加するとかでやったほうがベターだろう
    flagX   = new int[500];
    flagY   = new int[500];
    stats   = new int[500];
}


void draw(){

    if(game_statue == 0){
        start_menu();
    }else if(game_statue == 1){
        in_game();
    }else if(game_statue == 2){
        how2play();
    }else if(game_statue == 3){
        congrats();
    }else if(game_statue == 4){
        gameOver();
    }
    
}


void mousePressed(){
    if(game_statue == 0){
        game_statue = checkMoveStatue(game_statue);
    }else if(game_statue == 3 || game_statue == 4){
        game_statue = 0;
    }
}



int checkMoveStatue(int statue){
    int n;
    switch (statue){
        case 0:
            for(int i = 0; i < menuBerAmount; i++){
                if((mouseX > 50 && mouseX < width-100 ) && 
                    (mouseY > 110 + i*40 && mouseY < 140 + i*40)){

                    if(i == 0){

                        in_game_setup();
                        return 1;

                    }else if(i == 1){
                        return 2;
                    }
                }
            }

            return 0;        
    }

    return 0;

}
// ------------------------------------ //



void start_menu(){
    background(white);
    drawMenuBer(menuBerAmount);
}


//  メニューに置く四角形を表示する関数
void drawMenuBer(int n){
    
    for(int i = 0; i < n; i++){
        fill(grey);
        stroke(black);

        rect(50, 110 + i*40, width-100, 30);

        fill(black);
        //  TODO: 中央ぞろえにしたい
        text(texts[i], width / 2 - 40, 130 + i*40);
        noFill();
    }
}


// ------------------------------------ //

void in_game_setup(){
    setupEnemyPos(enemy_amount - 1);
    flagAmount = setupFlag();
    setupPlayer();
}


void setupEnemyPos(int n){

    if(n < 0){
        return;
    }

    angle       = random(360);
    enemyX[n]   = random(size / 2, width - 20);
    enemyY[n]   = random(size / 2, height - 20);
    
    enemyVx[n] = 2 * cos(2 * PI/360 * angle);
    enemyVy[n] = 2 * sin(2 * PI/360 * angle);

    setupEnemyPos(n - 1);
}


int setupFlag(){
    int n = 0;
    for(int i = 0; 30 + i*flagSpace < width - 30; i++)
        for(int j = 0; 30 + j*flagSpace < height; j++){
            flagX[n]  = 30 + i*flagSpace;
            flagY[n]  = 30 + j*flagSpace;
            stats[n] = 0;

            n++ ;
        }

    return n;
}


void setupPlayer(){
    playerPosX = width / 2;
    playerPosY = height / 2;
}


void in_game(){
    background(white);
    // 旗
    for(int j = 0; j < flagAmount; j++){
        drawFlag(j);
    }

    //  敵
    for(int i = 0; i < enemy_amount ; i++ ){
        updateEnenmyPos(i);
        drawEnemy(i);
        checkInversion(i);
    }

    //  プレイヤー
    playerPosX = mouseX;
    playerPosY = mouseY;
    drawPlayer();

    //  衝突判定
    checkCollapsEnemy();
    checkCollapsFlag();

    checkClear();
    
}


void drawFlag(int n){
    if(stats[n] == 0){
        fill(white);
    }else{
        fill(green);
    }

    stroke(black);

    ellipse(flagX[n], flagY[n], size, size);
    noFill();
    
}


void updateEnenmyPos(int i){
    enemyX[i] = enemyVx[i] + enemyX[i];
    enemyY[i] = enemyVy[i] + enemyY[i];
}


void drawEnemy(int i){
    fill(red);
    stroke(red);

    ellipse(enemyX[i], enemyY[i], size, size);
    
    noFill();
}


//  速度反転の必要があるかどうかを判定
void checkInversion(int n){
    if(enemyX[n] <= size / 2 || enemyX[n] >= width - size / 2){
        enemyVx[n] = inversion(enemyVx[n]);
    }
    
    if(enemyY[n] <= size / 2 || enemyY[n] >= height - size / 2){
        enemyVy[n] = inversion(enemyVy[n]);
    }
}


//  向きを反転させて返す
float inversion(float speed){
    
    return speed * (-1);
}


void drawPlayer(){
    fill(blue);
    stroke(blue);
    ellipse(playerPosX, playerPosY, size, size);

    noFill();
}


//  プレイヤーの座標と任意の座標が衝突しているかを判定
boolean checkCollaps(float x, float y){
    float deltaX = playerPosX - x;
    float deltaY = playerPosY - y;

    if(deltaX < 5 && deltaX > -5 && deltaY < 5 && deltaY > -5){
        return true;
    }

    return false;
}


void checkCollapsEnemy(){
    for(int i = 0; i < enemy_amount; i++){
        if(checkCollaps(enemyX[i], enemyY[i])){
            //ゲームオーバー
            game_statue = 4;
        }
    }
}


void checkCollapsFlag(){
    for(int i = 0; i < flagAmount; i++){
        if(checkCollaps(flagX[i], flagY[i])){
            stats[i] = 1;
        }
    }

}


void checkClear(){
    for(int i = 0; i < flagAmount; i++){
        if(stats[i] == 0){
            return;
        }
    }

    game_statue = 3;
}


void how2play(){
    background(blue);
}


void congrats(){
    background(green);
    fill(black);
    text("CONGRATSRATION!",width/2 ,height/2 );
    
}


void gameOver(){
    background(red);
    fill(black);
    text("GAME OVER!",width/2 ,height/2 );
}
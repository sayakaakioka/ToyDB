import java.awt.*;
import javax.swing.*;

private final int ROWS = 7;
private final int COLUMNS = 7;
private final int CELLWIDTH = 200;
private final int CELLHEIGHT = 50;

private final color bgColor = color(255, 255, 255);
private final color fgColor = color(0, 0, 0);

// 時間割データ
private String[][] subjects = new String [ROWS-2][COLUMNS-2];

// 曜日データ（時間割の描画にも使う）
String days[] = {"", "", "Mon", "Tue", "Wed", "Thu", "Fri"};

// データ入力用ウィンドウパネル
JPanel panel = new JPanel();
JTextField dayOfWeek = new JTextField();
JTextField period = new JTextField();
JTextField subject = new JTextField();

void settings() {
  size(COLUMNS*CELLWIDTH, ROWS*CELLHEIGHT);
}

void setup() {
  // データ入力用のダイアログを用意
  panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

  panel.add(new JLabel("入力"));
  panel.add(dayOfWeek);
  panel.add(period);
  panel.add(subject);
  
  // 時間割データの初期化
  for(int i=0; i<subjects.length; i++){
    for(int j=0; j<subjects[0].length; j++){
      subjects[i][j] = "";
    }
  }

  // 時間割表示用の窓を初期化
  drawEmpty();
}

void draw() {
  // データ入力窓の表示
  int ret = JOptionPane.showConfirmDialog(null, panel, "データ入力",
    JOptionPane.OK_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE);

  String dayStr = dayOfWeek.getText();
  String periodStr = period.getText();
  String subjectStr = subject.getText();
  
  if(ret == JOptionPane.CANCEL_OPTION){
    // キャンセルが押されたのでdraw()のループを止める
    noLoop();
  } else {
    // 何時限目かを整数で取得
    int periodInt = Integer.parseInt(periodStr);
    
    // 該当する曜日に科目名をセット
    for(int j=0; j<subjects[0].length; j++){
      if(days[j+2].equals(dayStr)){
        subjects[periodInt-1][j] = subjectStr;
        break;
      }
    }
  }

  // 空の時間割を描画
  drawEmpty();
  
  // 時間割の中身を描画
  drawSubjects();
}

private void drawEmpty() {
  // 背景の塗りつぶしと線の色の設定
  background(bgColor);
  stroke(fgColor);

  // 縦線と曜日の表示
  int current = CELLWIDTH/2;
  int counter = 0;
  while (current < width) {
    line(current, CELLHEIGHT/2, current, height-CELLHEIGHT/2);

    textAlign(CENTER, CENTER);
    fill(fgColor);
    text(days[counter], current-CELLWIDTH/2, CELLHEIGHT);

    current += CELLWIDTH;
    counter++;
  }

  // 横線と時間の表示
  current = CELLHEIGHT/2;
  counter = -1;
  while (current < height) {
    line(CELLWIDTH/2, current, width-CELLWIDTH/2, current);

    if (counter > 0) {
      textAlign(CENTER, CENTER);
      fill(fgColor);
      text(counter, CELLWIDTH, current-CELLHEIGHT/2);
    }

    current += CELLHEIGHT;
    counter++;
  }
}

private void drawSubjects(){
  // 色と配置の設定
  textAlign(CENTER, CENTER);
  fill(fgColor);
  textSize(36);
  
  // 順番に科目名を描いていく
  for(int i=0; i<subjects.length; i++){
    for(int j=0; j<subjects[0].length; j++){
      text(subjects[i][j] , (j+2)*CELLWIDTH, (i+2)*CELLHEIGHT);
    }
  }
}

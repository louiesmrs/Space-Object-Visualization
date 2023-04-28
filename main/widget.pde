// change widget create back/close button


class Widget
{
  int event;
  int x, y, width, height; //set these up in the constructor please
  String label;
  color widgetColor, labelColor, borderColor, originalColor, strokeColor;
  PFont widgetFont;
  boolean borderless;
  int textSize, textPosy, textPosx;
  boolean drawText;
  boolean display = true;
  boolean selected;
  
  Widget(int x, int y, int width, int height,
  color widgetColor, int event)
  {
    this.x=x; this.y=y; this.width=width; this.height=height; 
    labelColor=color(0);
    this.widgetColor = widgetColor;
    this.event = event;
  }
  Widget(int x, int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event)
  {
    this.x=x; this.y=y; this.width=width; this.height=height; 
    this.label=label; this.widgetColor=widgetColor; this.event=event;
    this.widgetFont=widgetFont;
    labelColor=color(0);
    drawText = true;
     this.strokeColor = color(0);
  }
  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event, int textSize, int textPosx, int textPosy, int labelColor){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont =widgetFont;
    this.textPosx = textPosx; this.textPosy = textPosy;this.textSize = textSize;
    this.labelColor = labelColor;
    borderColor = color(0);
    originalColor = widgetColor;
    drawText = true;
    this.strokeColor = color(0);
  }
  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event, int textSize, int textPosx, int textPosy, int labelColor, int strokeColor){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont =widgetFont;
    this.textPosx = textPosx; this.textPosy = textPosy;this.textSize = textSize;
    this.labelColor = labelColor;
    this.strokeColor = strokeColor;
    borderColor = color(0);
    originalColor = widgetColor;
    drawText = true;
  }
  
  void draw()
  {
    if (display) { 
      fill(widgetColor);
      if (borderless) {
        noStroke();
      }
      rect(x,y,width, height);
      stroke(strokeColor);
      if (drawText) { 
        fill(labelColor);
        if(textPosx != 0 || textPosy != 0){
          
          textSize(textSize);
          text(label, x+textPosx, y+textPosy);
        } else {
          textSize(DEFAULTTEXTSIZE);
          text(label, x+10, y+height-10);  
        }
      }
    }
  }
  
  void setBorderless(boolean borderless) { 
    this.borderless = borderless; 
  }
  
  int getEvent(int mX, int mY)
  {
    if(mX>x && mX < x+width && mY >y && mY <y+height)
    {
       return event;
     }
    return EVENT_NULL;
  }
  
  Widget getWidgetForEvent(int event) { 
    if (event == this.event && event != -1) { 
      return this;
    } else {
      return null;
    }
  }
  
  void setLabel(String label) { 
    this.label = label;
  }
  
   void changeColor(int r, int g, int b){
    widgetColor = color(r, g, b);
  }
  void changeColor(int c){
    widgetColor = color(c);
  }
  void changeBorder(){
      borderColor = color(255);
  }
  void changeBorderBack() {
    borderColor = color(0);
  }
  void colorRevert(){
    widgetColor = originalColor;
  }
  
  void setDisplay(boolean display) { 
    this.display = display;
  }
  
  boolean getDisplay() {  return this.display;  }
    

 void select() {
    
    selected = true;
  }
  void unselect() {
    
    selected = false;
  }
    boolean getSelected() { 
    return this.selected;
  }
}

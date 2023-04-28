


public class ScrollBar extends ManagerWidget { 
  
  int numItems; 
  int pageSize; 
  
  int index = 0; 
  
  final int pageUpEvent = 5000;
  final int pageDownEvent = 5001;
  final int cursorEvent = 5002;
  float cursorHeight;
  Widget cursor;
  int numberOfPages;
  float scalingFactor;
  
  
  public ScrollBar(int x, int y, int width, int height, color widgetColor, int event, int numItems, int pageSize) { 
    super(x, y, width, height, widgetColor, event);
    this.pageSize = pageSize;
    
    addWidget(new Widget(x, y, width, 10, widgetColor, pageUpEvent)); 
    addWidget(new Widget(x, y + (height-10), width, 10, widgetColor, pageDownEvent)); 
    cursor =new Widget(x, y+10, width, 0, GREY4, cursorEvent);
    setNumItems(numItems);
    setCursorPosition();
    addWidget(cursor);
  }
  
  void setCursorPosition() {
    cursor.y = y+10+(int)(index* scalingFactor);
      //   println("cursorHeight: " + cursorHeight + ", numItems: " + numItems + " pageSize: " + pageSize + 
      //", numPages: " + numberOfPages + 
      //", index: " + index + ", cursor.y: " + cursor.y);
  }
  
  void setNumItems(int numItems) { 
    this.numItems = numItems;
    
    
    if(numItems>pageSize){numberOfPages = numItems/pageSize;} else{numberOfPages = 1;}
    int num = numItems%pageSize;
    if(num >0 && numItems>pageSize) {numberOfPages++;}
    cursorHeight = (height-20)/numberOfPages;
    scalingFactor = (float) (height-20) / (float) numItems;
    cursor.height = (int) cursorHeight;
  }
   
  int mousePressEvent(int mx, int my) { 
     int event = getEvent(mx, my); 
     switch (event) { 
       case pageUpEvent: 
         this.index = Math.max(0, index - pageSize);
         setCursorPosition();
         break;
       case pageDownEvent: 
         this.index = Math.min((numItems>pageSize)?numItems - pageSize:0, index + pageSize);
         setCursorPosition();
         break;
     } 
     return event;
  }
  
  void keyUp(){
    this.index = Math.max(0, index - pageSize);
    setCursorPosition();
  
  }
  void keyDown(){
    
    this.index = Math.min((numItems>pageSize)?numItems - pageSize:0, index + pageSize);
    setCursorPosition();
    
  }
  
   int getIndex () { 
     return this.index; 
   }
   
   void setIndex(int index) { 
     this.index = index;
     setCursorPosition();
   }
  
}

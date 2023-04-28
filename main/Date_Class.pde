class DateClass extends ManagerWidget {
  ManagerWidget manager;
  ArrayList<ScrollableBarGraph> sbgs = new ArrayList<ScrollableBarGraph>();
  ArrayList<String> options;
  ScrollableBarGraph mainSBG;
  DropDown dropDown;
  
  //ArrayList<Widget> widgets = new ArrayList();
  //BarGraphWidget barGraph;
  color screenColor;
  final int dropDownEvent = 400;
  
  DateClass(color screenColor, String label,
    color widgetColor, PFont widgetFont, int event, int textSize, ArrayList<String> options){
    super(-1, -1, -1, -1, color(0), -1);
    this.screenColor = screenColor;
    this.options = options;
    dropDown = new DropDown(100, 10, 150, 30, label, widgetColor, widgetFont, dropDownEvent, textSize, options);
    addWidget(dropDown);
    int pageSize = 25;
    //for (String option: options) { 
    //  sbgs.add(new ScrollableBarGraph(5, 50, queryResults.getLongestString("Name", 10), SCREENX/2, 20, color(150), -1,
    //    queryResults.getStringArray("Name"), queryResults.getFloatList(option), widgetFont, (options.indexOf(option)>1)?true:false, pageSize));
    //}
  }
  void draw()
  {
    background(screenColor);
    if (mainSBG != null) { 
      mainSBG.draw();
    }
    super.draw();
  }
  
    
  void mousePressEvent(int mx, int my) { 
     int event = dropDown.getEvent(mx, my); 
     switch (event) { 
       case dropDownEvent:
        // header event
        if (dropDown.getOpened()) {
          dropDown.close();
        } else { 
          dropDown.open();
        }
        break;     
       case -1: 
       case 0:
         if (mainSBG != null) { 
           mainSBG.mousePressEvent(mx, my);
         }
         break;
       default:
         int index = event - (dropDownEvent + 1);
         mainSBG = sbgs.get(index);
         dropDown.close();
     }
  }
   
   void mouseMovedEvent(int mx, int my) { 
     dropDown.colorWidgetOnMouse(mx, my);
   }

}

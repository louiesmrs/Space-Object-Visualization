
  class Screen extends ManagerWidget {
  
  ArrayList<Widget> widgets = new ArrayList();
  BarGraphWidget barGraph;
  color screenColor;
  
  Screen(color screenColor){
    super(-1, -1, -1, -1, screenColor, -1);
    this.screenColor = screenColor;
  }
  
  void addBarGraph (BarGraphWidget barGraph) { 
    this.barGraph = barGraph;
  }
  
  void draw()
  {
    background(bg);
    super.draw();
  }
  
} 
  //ArrayList<Widget> widgets = new ArrayList();
  //BarGraphWidget barGraph;
  //color screenColor;
  
  //Screen(color screenColor){
  //  this.screenColor = screenColor;
  //}
  
  //void addWidgets(Widget w){
  //  widgets.add(w);
  //}
  
  //void addBarGraph (BarGraphWidget barGraph) { 
  //  this.barGraph = barGraph;
  //}
  
  //void draw()
  //{
  //  background(screenColor);
  //  for (int i = 0; i < widgets.size(); i++)
  //  {
  //    Widget widget = (Widget)widgets.get(i);
  //    widget.draw();
  //  }
  //  if (barGraph != null) {
  //    barGraph.draw();
  //  }
  //}
  
  //int getEvent(int mx, int my){
  //    for(int i=0; i<widgets.size();i++)
  //    {
  //     Widget widget=(Widget)widgets.get(i);
  //     int event= widget.getEvent(mouseX, mouseY);
  //     if(event!=EVENT_NULL)
  //     return event;
  //    }
  //    return EVENT_NULL;
  //}
//}

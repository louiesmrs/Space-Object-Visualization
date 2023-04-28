
public class ManagerWidget extends Widget {
  
   
  ArrayList<Widget> widgets = new ArrayList();
  
  ManagerWidget(int x,int y, int width, int height, color widgetColor, int event) {
    super(x, y, width, height, widgetColor, event);
  }
  
  public void addWidget(Widget widget) { 
    this.widgets.add(widget);
  }
 
  void draw() { 
    super.draw();
    for (Widget widget: widgets) { 
      widget.draw();
    }
  }
  
  int getEvent(int mx, int my){
      for(int i=0; i<widgets.size();i++)
      {
       Widget widget=(Widget)widgets.get(i);
       int event= widget.getEvent(mouseX, mouseY);
       if(event!=EVENT_NULL)
       return event;
      }
      return EVENT_NULL;
  }
  
    Widget getWidgetForEvent(int event) { 
      for(Widget widget : widgets) {
        Widget returnedWidget = widget.getWidgetForEvent(event);
        if (returnedWidget != null) {
          return returnedWidget;
        }
      }
      return null;
  }
   
 
  
  void setDisplay(boolean display) { 
    super.setDisplay(display);
    for(Widget widget : widgets) {
      widget.setDisplay(display);
    }
  }
  
  
  
}

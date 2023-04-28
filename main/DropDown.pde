class DropDown extends ManagerWidget {
  ArrayList<String> options;
  int optionsHeight, optionsWidth;
  int widthMargin = 10;
  int heightMargin = 10;
  int ySpacing = 25;

  boolean opened;
  PFont widgetFont;
  int newY;
  String label;
  Widget boxWidget;
  Widget headerWidget;

  DropDown(int x, int y, int width, int height, String label,
    color widgetColor, PFont widgetFont, int event, int textSize, ArrayList<String> options) {
    super(x, y, width, height, widgetColor, event);
    this.options = options;
    this.widgetFont = widgetFont;
    this.textSize = textSize;
    this.label = label;
    headerWidget = new Widget(x, y, width, height, label, widgetColor, widgetFont, event);
    addWidget(headerWidget);
  }


  void setLabel(String label) {
    headerWidget.setLabel(label);
  }

  void removeOptions() {
    this.widgets.subList(1, widgets.size()).clear();
  }
  void setOptions(ArrayList<String> options) {

    optionsHeight = options.size() * textSize;
    optionsWidth = queryResults.getLongestString("headers", textSize);
    int boxWidgetY  = y+height - 5;
    for (int i = 0; i<options.size(); i++) {
      int newY = y + (i * ySpacing);
      if (options.size() >=22) {
        if (newY >= SCREENY-2*ySpacing) {
          if (newY-SCREENY+2*ySpacing >= SCREENY-2*ySpacing) {
            if (newY-2*(SCREENY-2*ySpacing) >= SCREENY-2*ySpacing) {
              if (newY-3*(SCREENY-2*ySpacing) >= SCREENY-2*ySpacing) {
                   if (newY-4*(SCREENY-2*ySpacing) >= SCREENY-2*ySpacing) {
                    addWidget(new Widget(5 + 5*(optionsWidth + (2 * widthMargin)), boxWidgetY+newY-5*(SCREENY-2*ySpacing),
                    optionsWidth + (2 * widthMargin), ySpacing, options.get(i), widgetColor, widgetFont, this.event + i + 1, (int)(textSize*1.3), 4, 20, TEXTBLACK));
                   } else {
                    addWidget(new Widget(5 + 4*(optionsWidth + (2 * widthMargin)), boxWidgetY+newY-4*(SCREENY-2*ySpacing),
                    optionsWidth + (2 * widthMargin), ySpacing, options.get(i), widgetColor, widgetFont, this.event + i + 1, (int)(textSize*1.3), 4, 20, TEXTBLACK));
                   }
              } else {
                addWidget(new Widget(5 + 3*(optionsWidth + (2 * widthMargin)), boxWidgetY+newY-3*(SCREENY-2*ySpacing),
                  optionsWidth + (2 * widthMargin), ySpacing, options.get(i), widgetColor, widgetFont, this.event + i + 1, (int)(textSize*1.3), 4, 20, TEXTBLACK));
              }
            } else {
              addWidget(new Widget(5 + 2*(optionsWidth + (2 * widthMargin)), boxWidgetY+newY-2*(SCREENY-2*ySpacing),
                optionsWidth + (2 * widthMargin), ySpacing, options.get(i), widgetColor, widgetFont, this.event + i + 1, (int)(textSize*1.3), 4, 20, TEXTBLACK));
            }
          } else {
            addWidget(new Widget(5 + optionsWidth + (2 * widthMargin), boxWidgetY+newY-SCREENY+2*ySpacing,
              optionsWidth + (2 * widthMargin), ySpacing, options.get(i), widgetColor, widgetFont, this.event + i + 1, (int)(textSize*1.3), 4, 20, TEXTBLACK));
          }
        } else {
          addWidget(new Widget(5, boxWidgetY+newY, optionsWidth + (2 * widthMargin), ySpacing, options.get(i), widgetColor, widgetFont, this.event + i + 1, (int)(textSize*1.3), 4, 20, TEXTBLACK));
        }
      } else {
        addWidget(new Widget(x, boxWidgetY+newY, optionsWidth + (2 * widthMargin), ySpacing, options.get(i), widgetColor, widgetFont, this.event + i + 1, (int)(textSize*1.3), 4, 20, TEXTBLACK));
      }
    }
  }

 

  boolean getOpened() {
    return this.opened;
  }

  void colorWidgetOnMouse(int mX, int mY) {
    for (Widget widget : widgets) {
      int event = widget.getEvent(mX, mY);
      if (event == EVENT_NULL) {
        widget.changeColor(widgetColor);
      } else {
        widget.changeColor(GREY4);
      }
    }
  }
  void open() {
    setOptions(options);
    opened = true;
  }
  void close() {
    removeOptions();
    opened = false;
  }
}

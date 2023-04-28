public class ScrollableBarGraph extends ManagerWidget {
  ArrayList<String> labels;
  FloatList vals;
  int pageSize;
  BarGraphWidget barGraph;
  ScrollBar scrollBar; 
  float average;
  
  
  public ScrollableBarGraph(int x,int y, int textWidth, 
    int width, int height, color widgetColor, int event, ArrayList<String> labels, FloatList vals, PFont widgetFont, boolean minusVals, int pageSize){
    super(1, 1, 1, 1, color(0), event);
    this.pageSize = pageSize;
    this.labels = labels;
    this.vals = vals; 
    this.barGraph = new BarGraphWidget(x, y, textWidth, width - 20, height, widgetColor, event, widgetFont, minusVals, vals.max(), vals.min(), vals);
    addWidget(barGraph);
    setBorderless(true);
    this.scrollBar = new ScrollBar(width-15, y, 15, height * pageSize, widgetColor, -1, this.labels.size(), pageSize);
    addWidget(scrollBar);
    average = queryResults.getAverage(vals);
    setBarGraph(0);
  }
  
  void setLists(ArrayList<String> labels, FloatList vals) {
    this.labels =labels;
    this.vals = vals;
    barGraph.setNumberOfVals(vals.size());
    if (vals.size() == 0 ){ 
      barGraph.setMax(0);
      barGraph.setMin(0);
      average = 0;
    } else { 
      barGraph.setMax(vals.max());
      barGraph.setMin(vals.min());      
      average = queryResults.getAverage(vals);
    }

    scrollBar.setIndex(0);
    scrollBar.setNumItems(labels.size());
    setBarGraphToIndex();
  }
  
  void setBarGraph(int index) {
    int maxSize = this.labels.size();
    ArrayList<String> newLabels = new ArrayList(); 
    FloatList newVals = new FloatList(); 
    for (int i = 0 ; i < pageSize ; i++ ) { 
      int v = index + i;
      if (v < maxSize) { 
        newLabels.add(labels.get(v));
        newVals.append(vals.get(v));
      }
    }
   
    barGraph.setBars(newLabels, newVals, average);
  }
  
  void setBarGraphToIndex() {
    setBarGraph(scrollBar.getIndex());
  }
  
 void keyUp(){
    scrollBar.keyUp(); 
    setBarGraphToIndex();
  
  }
  void keyDown(){
    scrollBar.keyDown();
    setBarGraphToIndex();
  }
  
  void mousePressEvent(int mx, int my) { 
    if (scrollBar.mousePressEvent(mx, my) != EVENT_NULL) {
      setBarGraphToIndex();
    }
  }
  
  ScrollBar getScrollbar(){
    return scrollBar;
  }  
  void setMinusVals(FloatList vals) {
    int count = 0;
    for(float f : vals) {
      if(f < 0) {
         count++;
      }
      
    }
    barGraph.setMinusVals((count>0)?true:false);
  }
  ArrayList<String> getLabels(){
    return this.labels;
  }
  FloatList getVals(){
    return this.vals;
  }
}

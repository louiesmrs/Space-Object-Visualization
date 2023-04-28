class BarGraphWidget extends ManagerWidget {
 
 boolean minusVals;
 int textWidth;
 PFont widgetFont;
 float maxVal;
 float minVal;
 float numberOfVals;
 float average;
 FloatList vals;
 int x, y, width, height;
 BarGraphWidget(int x, int y, int textWidth, int width, int height, color aColor, int event, PFont widgetFont, boolean minusVals, float maxVal, float minVal, FloatList vals) {
     super(1, 1, 1, 1, color(0, 0, 0), event);
     this.minusVals = minusVals;
     this.textWidth = textWidth;
     this.widgetFont = widgetFont; 
     this.maxVal = maxVal;
     this.width = width;
     this.height = height;
     this.x = x;
     this.y = y;
     this.vals = vals;
     this.numberOfVals = vals.size();
     //average = queryResults.getAverage(vals);
     this.minVal = minVal;
     setBorderless(true);
 }

 
 
 public void setBars(ArrayList<String> labels, FloatList vals, float average) { 
     this.widgets.clear();
     int numVals = labels.size();
     //float maxVal = vals.max();
     //float minVal = vals.min();
     addWidget(new Widget(x+textWidth, y, SCREENX-textWidth-15 , 2 , "", color(246), widgetFont, -1, DEFAULTTEXTSIZE, -5, -5, BACKGROUNDWHITE, color(246)));
     addWidget(new Widget(x+textWidth, y, 15 , 0 , "" + nf(minVal, 0, 2), color(0), widgetFont, -1, (int)(DEFAULTTEXTSIZE*1.3), -5, -5, BACKGROUNDWHITE));
     addWidget(new Widget(SCREENX-70, y, 15 , 0 , ""  +  nf(maxVal, 0, 2), color(0), widgetFont, -1, (int)(DEFAULTTEXTSIZE*1.3), -5, -5, BACKGROUNDWHITE ));
     addWidget(new Widget(x, SCREENY+5, 15 , 1 , ""  +  numberOfVals +"(Total Objects)", color(246), widgetFont, -1 , (int)(DEFAULTTEXTSIZE*1.3), 10, -10, BACKGROUNDWHITE,  color(246)));
     //println(maxVal); 
     
     
     int startOfXAxis = x+textWidth;
     int maxXPos = x + width;
     float xExtent =  (maxVal != minVal)?maxVal - minVal:maxVal;
     // Wrong Math.abs(maxVal) + Math.abs(minVal);
     
     //  min = 2 , max = 4 - -    2 =  correct
     //  min = -2, max = 4         6,     6 correct
     //  min = -4, max = -2       2 , ,right
     int graphXPixels = width - startOfXAxis;
     float xPixels =  (graphXPixels)/ xExtent;
     int originXPosition= startOfXAxis;
     if (minusVals) { 
       originXPosition += ((int) ((0 - minVal) * xPixels));
     }
     
     
     //println("maxXPos=" + maxXPos + ", graphXPixels=" + graphXPixels+ ", originXPositio=" + originXPosition + ", xPixels=" + xPixels + ", xExtent=" + xExtent + ", startOfXAxis=" + startOfXAxis);
//     if(minusVals) { addWidget(new Widget(x+textWidth+((SCREENX-textWidth)/2), y, 1, SCREENY-y, "", color(246), widgetFont, -1,  DEFAULTTEXTSIZE , 0, 0, BACKGROUNDWHITE));}
     addWidget(new Widget(originXPosition, y, 1, SCREENY-y, "", color(246), widgetFont, -1,  DEFAULTTEXTSIZE , 0, 0, BACKGROUNDWHITE));
     for (int i = 0; i < numVals ; i++) {
       float val = vals.get(i);

        int barXPosition = originXPosition;
        if (val < 0.0 ) {
         barXPosition += (int) ( val * xPixels);
         if (numVals < 10) { 
           //println("val=" + val + ", barXPosition=" + barXPosition);
         }
        } 
       
       //int size = (int) (( val / (maxVal) ) * (float)((minusVals)?(width/2)-10: width));
       int size = (int) ( Math.abs(val) * xPixels);
        
        //(( val / (maxVal) ) * (float)((minusVals)?(width/2)-10: width));
      addWidget(new Widget(x, y+ (height *i), textWidth, height, labels.get(i), BACKGROUNDWHITEOP, widgetFont, -1, DEFAULTTEXTSIZE, 5, 20, color(246)));
       
       
//       addWidget(new Widget(x + textWidth + ((minusVals)?(SCREENX-textWidth)/2: 0), y + (height * i), size, height, TEAL, -1));
       addWidget(new Widget(barXPosition, y + (height * i), size, height, DARK_BLUE, -1));
     }
     if(!minusVals){addWidget(new Widget((int)(x+textWidth + ((minusVals && average < 0)?-((average/maxVal)*width):((average/maxVal)*width))+((minusVals)?(SCREENX-textWidth)/2: 0)), 
     y, 2, SCREENY-y, "" + average + "(Average)", TEAL, widgetFont, -1, (int)(DEFAULTTEXTSIZE*1.3), 10, SCREENY-y-15, BACKGROUNDWHITE, color(246)));}
     //addWidget(new Widget((int)(originXPosition + (average*xPixels)), 
     //y, 2, SCREENY-y, "" + average + "(Average)", TEAL, widgetFont, -1, (int)(DEFAULTTEXTSIZE*1.3), 10, SCREENY-y-15, BACKGROUNDWHITE, color(246)));
 }
 public void setMax(float max) {
   maxVal = max;
   
 }
 public void setMin(float min) {
   minVal = min;
 }
 void setMinusVals(boolean minus) {
   minusVals = minus;
 }
 void setNumberOfVals(float vals) {
   this.numberOfVals = vals;
}
 
 
  
}

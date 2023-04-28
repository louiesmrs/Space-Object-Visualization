







class BarGraphScreen extends ManagerWidget {
  
  ManagerWidget manager;
  ArrayList<ScrollableBarGraph> sbgs = new ArrayList<ScrollableBarGraph>();
  int currentSBGIndex = -1;
  
  ArrayList<String> labels = null;
  FloatList vals = null;
  ArrayList<String> options;
  ScrollableBarGraph mainSBG;
  DropDown dropDown;
  DropDown orbits;
  DropDown states;
  DropDown dateStart;
  DropDown dateEnd;
  Widget debris;
  ArrayList<String> orbitList;
  FloatList maxVals;
  
  //ArrayList<Widget> widgets = new ArrayList();
  //BarGraphWidget barGraph;
  color screenColor;
  final int dropDownEventGraph = 400;
  final int dropDownEventOrbit = 500;
  final int viewAllEvent = 501;
  final int lowEarthOrbitEvent = 502;
  final int mediumEarthOrbitEvent = 503;
  final int debrisEvent = 600;
  final int stateEvent = 700;
  final int searchEvent = 800;
  final int dateStartEvent = 900;
  final int dateEndEvent = 1000;
  
  String debPrefix = null;
  String stateFilter = null;
  String dateStartFilter = null;
  String dateEndFilter = null;
  ArrayList<String> stateList;
  ArrayList<String> dateList;
  StringBuilder sbBar;
  TextWidget nameSearch, focus, currentSearch;
  boolean searchSelected = false;
  
  
  
  int orbitSelected = viewAllEvent;
  
  BarGraphScreen(color screenColor, String label,
    color widgetColor, PFont widgetFont, int event, int textSize, ArrayList<String> options){
    super(-1, -1, -1, -1, color(0), -1);
    this.screenColor = screenColor;
    this.options = options;
    maxVals = new FloatList();
    stateList = queryResults.getCountryList();
    dateList = queryResults.getDateList();
    
   nameSearch = new TextWidget(255, 5, 90, 40, "Search", LIGHT_BLUE, widgetFont, searchEvent, 10);
   addWidget(nameSearch);
   sbBar = new StringBuilder();
    orbitList = new ArrayList();
    orbitList.add("View All");orbitList.add("Low-Earth Orbit");orbitList.add("Medium-Earth Orbit");
    dropDown = new DropDown(65, 5, 80, 40, label, LIGHT_BLUE, widgetFont, dropDownEventGraph, textSize, options);
    states = new DropDown(150, 5, 100, 40, "Choose State", LIGHT_BLUE, widgetFont, stateEvent, (int)(textSize), stateList);
    dateStart = new DropDown(350, 5, 100, 40, "Start date", LIGHT_BLUE, widgetFont, dateStartEvent, (int)(textSize), dateList);
    dateEnd = new DropDown(455, 5, 100, 40, "End Date", LIGHT_BLUE, widgetFont, dateEndEvent, (int)(textSize), dateList);
    
    orbits = new DropDown(625, 5, 150, 40, "Choose Orbit", LIGHT_BLUE, widgetFont, dropDownEventOrbit, textSize, orbitList);
    orbits.setDisplay(false);
    debris = new Widget(560, 5, 60, 40, "Debris", LIGHT_BLUE, widgetFont, debrisEvent);
    addWidget(debris);
    addWidget(dateStart);
    addWidget(dateEnd);
    addWidget(debris);
    addWidget(orbits);
    addWidget(states);
    addWidget(dropDown);
    setBorderless(true);
    int pageSize = 25;
    for (String option: options) { 
      sbgs.add(new ScrollableBarGraph(5, 70, queryResults.getLongestString("Name", 10), SCREENX, 20, LIGHT_BLUE, -1,
        queryResults.getStringArray("Name", option), queryResults.getFloatList(option), 
        widgetFont, (options.indexOf(option)>1)?true:false, pageSize));
      maxVals.append(queryResults.getFloatList(option).max());
    }
  }
  
  
   void keyPressedEvent(int keycode, char key){
     
       switch (keycode) { 
         case DOWN:
           getScrollableBarGraph().keyDown();
           break;
         case UP: 
           getScrollableBarGraph().keyUp();
           break;
         default:
           switch (key) { 
             case BACKSPACE: 
               nameSearch.append(key);
             case 65535:
               break;
             case ENTER:
               setFilters(orbitSelected);
               break;
             default: 
              //println("CHAR \"" + key + "\" int=" + ((int) key));
              nameSearch.append(key);
           }
       }
   } 
  
  ScrollableBarGraph getScrollableBarGraph() { return this.mainSBG ; }
  
 
  void draw()
  {
    background(bg);
    if (mainSBG != null) { 
      mainSBG.draw();
    }
    super.draw();
  }
    
  void mousePressEvent(int mx, int my) { 
      
     int event = dropDown.getEvent(mx, my); 
     if (event == dropDownEventGraph) { 
        // header event
        if (dropDown.getOpened()) {
          dropDown.close();
        } else { 
          dropDown.open();
        }
        return;
     } 
     
     if (event > dropDownEventGraph && event < dropDownEventOrbit) { 
         int index = event - (dropDownEventGraph + 1);
       
         mainSBG = sbgs.get(index);
         currentSBGIndex = index;
         //println(index);
         orbits.setDisplay(index >= 2);
         orbitSelected = viewAllEvent;
         orbits.setLabel(orbitList.get(0));
         setFilters(orbitSelected);
         dropDown.setLabel(options.get(index));
         dropDown.close();
         return;
     }
     
     if (orbits.getDisplay()) { 
       event = orbits.getEvent(mx, my);
       if (event == dropDownEventOrbit) { 
         if (orbits.getOpened()) {
           orbits.close();
         } else { 
          orbits.open();
         }
         return; 
       }
       
       if (event > dropDownEventOrbit) { 
        
         orbitSelected = event;
         setFilters(event);
         int index = event - (dropDownEventOrbit + 1);
         orbits.setLabel(orbitList.get(index));
         orbits.close();
         return;
       }
     } else {
       orbitSelected = viewAllEvent;
       orbits.setLabel(orbitList.get(0));
     }
     if(mainSBG != null) {
       event = debris.getEvent(mx, my);
       if(event == debrisEvent ) {   //&& labels != null && vals != null
          if(debris.getSelected()) {
              debris.changeColor(LIGHT_BLUE);
              debris.unselect();
              debPrefix = null;
          } else {
              debris.select();
              debris.changeColor(GREY4);
              debPrefix = "deb";
          }
          setFilters(orbitSelected);
          return;
       }
      
       event = states.getEvent(mx, my);
       if (event == stateEvent) { 
         if (states.getOpened()) {
           states.close();
           stateFilter = null;
         } else { 
          states.open();
         }
         return; 
       }
       
       if (event > stateEvent) { 
         int index = event - (stateEvent + 1);
         stateFilter = stateList.get(index);
         states.setLabel(stateFilter);
         if(index ==  0){stateFilter = null;}
         //println("index =" + index + ", stateFilter=" + stateFilter);
         setFilters(orbitSelected);
         states.close();
         return;
       }
       event = dateStart.getEvent(mx, my);
       if (event == dateStartEvent) { 
         if (dateStart.getOpened()) {
           dateStart.close();
           dateStartFilter = null;
         } else { 
           dateStart.open();
         }
         return; 
       }
       
       if (event > dateStartEvent) { 
         int index = event - (dateStartEvent + 1);
         dateStartFilter = dateList.get(index);
         dateStart.setLabel(dateStartFilter);
         if(index ==  0){dateStartFilter = null;}
         setFilters(orbitSelected);
         dateStart.close();
         return;
       }
       
       
       event = dateEnd.getEvent(mx, my);
       if (event == dateEndEvent) { 
         if (dateEnd.getOpened()) {
           dateEnd.close();
           dateEndFilter = null;
         } else { 
           dateEnd.open();
         }
         return; 
       }
       
       if (event > dateEndEvent) { 
         int index = event - (dateEndEvent + 1);
         dateEndFilter = dateList.get(index);
         dateEnd.setLabel(dateEndFilter);
         if(index ==  0){dateEndFilter = null;}
         setFilters(orbitSelected);
         dateEnd.close();
         return;
       }
      
       // It wasn't anything to do with drop downs.
       // Process the default mouse event to bar graph
       mainSBG.mousePressEvent(mx, my);
    }
  }
  
  void setFilters(int event) { 
      String option = options.get(currentSBGIndex);   // viewall LowEarth Medium 
      float maxVal = maxVals.get(currentSBGIndex);
      String searchText = nameSearch.getLabel(); 
      if ("Search".equals(searchText)) { 
        searchText = null;
      }
      switch (event) { 
           case viewAllEvent: 
             labels = queryResults.getStringArray("Name", option, "Name", debPrefix, searchText, stateFilter, dateStartFilter, dateEndFilter);  
             vals = queryResults.getFloatList(option, "Name", debPrefix, searchText, stateFilter, dateStartFilter, dateEndFilter);
             
             
             break;
           case lowEarthOrbitEvent: 
             labels = queryResults.getStringArrayWithFilter("Name", option,  0.0, 2000.0, debPrefix, searchText, stateFilter, dateStartFilter, dateEndFilter);
             vals = queryResults.getFloatListWithFilter(option,  0.0, 2000.0, "Name", debPrefix, searchText, stateFilter, dateStartFilter, dateEndFilter);
          
            
             break;
           case mediumEarthOrbitEvent: 
             labels = queryResults.getStringArrayWithFilter("Name", option,  2000.01, maxVal, debPrefix, searchText, stateFilter, dateStartFilter, dateEndFilter);
             vals = queryResults.getFloatListWithFilter(option,  2000.01, maxVal, "Name", debPrefix, searchText, stateFilter, dateStartFilter, dateEndFilter);
          
              
             break;
         }
         mainSBG.setMinusVals(vals);
         mainSBG.setLists(labels, vals);
  }
   
   void mouseMovedEvent(int mx, int my) { 
     dropDown.colorWidgetOnMouse(mx, my);
     orbits.colorWidgetOnMouse(mx, my);
     states.colorWidgetOnMouse(mx, my);
     dateStart.colorWidgetOnMouse(mx, my);
     dateEnd.colorWidgetOnMouse(mx, my);
   }
}


// Demo:
/* Focus on problems how we overcame - Scrollbar too much data/Orbits - out of earth orbits, values too big/DropDowns too big
First go through main screen show search country 
Next go into graph and click diameter. Describe all the all the widgets and numbers on screen. 
Choose UK as state as show functionality of scrollbar here. Next select start year 1994 and end year 2000. Mention how average total objects have changed.
Revert filters and change to APOGEE. Change state to US and explain negative values(origin position) and hidden pop up change orbits (Negative valeus are objects that orbit outside earth.
Test Search function will 'Explorer'. Get rid of search filter and show all states. Press debris button (half the objects remain).
*/
class QueryResults {
  
  Table table;
  boolean summary = false;
  ArrayList<String> output = new ArrayList();
  ArrayList<String> display = new ArrayList();
  String doubleSummary = "";
  int y = 70;
  
  
  QueryResults(Table data) {
    this.table = data;
   
  }
  

  void sortBy(String columnName) {
     table.sort(columnName);
  }
  int getLongestString(String columnName, int textSize) {
    ArrayList<String> results = new ArrayList();
    if(columnName == "headers"){
      results = getHeaders();
    }else {
    results = getStringArray(columnName);
    }
    int optionsWidth = 0;
     for (String option : results) {
      optionsWidth = java.lang.Math.max(optionsWidth, option.length() * textSize);
    }
    return optionsWidth;
    
  }
 
  ArrayList<String> getHeaders() { 
     ArrayList<String> results = new ArrayList();
     for (int i = 0 ; i < table.getColumnCount() ; i++) { 
       results.add(table.getColumnTitle(i));
     }
     return results;
  }
  float getAverage(String columnName){
    FloatList fl = new FloatList();
    fl = getFloatList(columnName);
    float sum = 0;
    for(float f : fl){
      sum+=f;
    }
    return sum / fl.size();
  }
  float getAverage(FloatList fl){
 
    //float x = float.NaN;
    //fl = fl.replace(float.NaN, 0);
    
    float sum = 0;
    for(float f : fl){
       
      sum+=f;
      
      
    }
    return sum / fl.size();
  }
  ArrayList<String> getName(String nameToGet, String columnName) { 
      ArrayList<String> results = new ArrayList();
      ArrayList<String> names = new ArrayList();
      names = getStringArray(columnName);
      for(String name  : names) {
        if(name == nameToGet) {
          results.add(name);
        }
      }
      return results;
  }
  TableRow getRowFromName(String nameToGet) {
    return table.findRow(nameToGet, "Name");
  }
  Float getFloatFromRow(String columnName, TableRow row) {
    return row.getFloat(columnName);
  }
   String getStringFromRow(String columnName, TableRow row) {
    return row.getString(columnName);
  }
  FloatList getAveragesList(String columnName, TableRow row) {
    FloatList fl = new FloatList();
    fl = getFloatList(columnName);
    float max = fl.max();
    float min = fl.min();
    float average = getAverage(columnName);
    float floatFromRow = getFloatFromRow(columnName, row);
    FloatList results = new FloatList();
    results.append(max);results.append(min);results.append(average);results.append(floatFromRow);
    return results;
  }
    
    
  
  ArrayList<String> getStringArray(String columnName) {
    return getStringArray(columnName, null);
  }
  
  ArrayList<String> getStringArray(String columnName, String prefix) { 
     ArrayList<String> results = new ArrayList();
     for (int i = 0 ; i < table.getRowCount() ; i++) { 
       String sVal = table.getString(i, columnName);
       if (prefix == null || !sVal.startsWith(prefix)) {
         results.add(sVal);
       }
     }
     return results;
  }
  
  
   ArrayList<String> getStringArray(String columnName, String valColumn, String nameColumn, String exclude, String match, String state, String sdate, String edate) { 
     ArrayList<String> results = new ArrayList();
     for (int i = 0 ; i < table.getRowCount() ; i++) { 
       if (include(i, nameColumn, exclude, match, state, sdate, edate)) { 
         if (!Float.isNaN(table.getFloat(i, valColumn))) { 
           results.add(table.getString(i, columnName));
         }
       }
       
     }  
     return results;
  }

   
   ArrayList<String> getCountryList() { 
     ArrayList<String> results = new ArrayList();
     results.add("All States");
     for (int i = 0 ; i < table.getRowCount() ; i++) { 
        String val = table.getString(i, "State");
         if (!results.contains(val)) { 
           results.add(val);
         }
       }
       
     
     return results;
  }
   ArrayList<String> getDateList() { 
     ArrayList<String> results = new ArrayList();
     results.add("All Years");
     for (int i = 0 ; i < table.getRowCount() ; i++) { 
        String val = table.getString(i, "LDate");
          String[] dateSplit = val.split(" ");
          val = dateSplit[0];
         if (!results.contains(val) && !val.contains("?")) { 
           results.add(val);
         }
       }
       
     
     return results;
  }
  String getDate(String columnName, int i) {
    String val = table.getString(i, columnName);
    String[] dateSplit = val.split(" ");
    val = dateSplit[0];
    return val;
  }
  
 
  ArrayList<String> getStringArrayWithFilter(String columnName, String columnNameToFilter, float min, float max, String exclude, String match, String state, String sdate, String edate) { 
     ArrayList<String> results = new ArrayList();
     for (int i = 0 ; i < table.getRowCount() ; i++) { 
      if (include(i, columnName, exclude, match, state, sdate, edate)) { 
        
        float val = table.getFloat(i, columnNameToFilter);
        if(!Float.isNaN(val) && val >= min && val<= max) {
          String sVal = table.getString(i, columnName);
            results.add(sVal);
         }
        }
    }
    return results;
  }
 
 

  FloatList getFloatList(String columnName) {
    return getFloatList(columnName, null, null, null, null, null, null);
  }
  FloatList getFloatList(String columnName, String state) {
    return getFloatList(columnName, null, null, null, state, null, null);
  }

  FloatList getFloatList(String columnName, String nameColumn, String exclude, String match, String state, String sdate, String edate) { 
     //printFilters(exclude, match, state, sdate, edate);

     FloatList fl = new FloatList();
     for (int i = 0 ; i < table.getRowCount() ; i++) { 
       if (include(i, nameColumn, exclude, match, state, sdate, edate)) { 
         float val = table.getFloat(i, columnName);
         if (!Float.isNaN(val)) { 
           fl.append(val);
         }
       }
     }
     return fl;
  }
  
  
  
 
  FloatList getFloatListWithFilter(String columnName, float min, float max) {
    return getFloatListWithFilter(columnName, min, max, null, null);
  }
  
  FloatList getFloatListWithFilter(String columnName, float min, float max, String nameColumn, String prefix) {
    FloatList results = new FloatList();
    for (int i = 0 ; i < table.getRowCount() ; i++) { 
      if (prefix == null || !table.getString(i, nameColumn).startsWith(prefix)) {
        float val = table.getFloat(i, columnName);
        if(!Float.isNaN(val) && val >= min && val<= max) {
          results.append(val);
        }
      }
    }
    return results;
  }
  
  
  void printFilters (String exclude, String match, String state, String sdate, String edate) { 
    println("Filters: exclude=" + exclude + "\t match=" + match + "\t state=" + state+ "\t sdate=" + sdate+ "\t edate=" + edate);
  }
  
  
  boolean include(int i, String nameColumn, String exclude, String match, String state, String sdate, String edate) {
    int dateStart = 0;
    int dateIndex = 0;
    int dateEnd = 0;

    if(getDate("LDate", i) != null) { 
      
          try {
          dateIndex = Integer.parseInt(getDate("LDate", i));
          }catch (NumberFormatException e) {
             dateIndex = 0;
      }
    }
    if(sdate != null) { 
       try {
          dateStart = Integer.parseInt(sdate);
          }catch (NumberFormatException e) {
             dateStart = 0;
      }
    }
    if(edate != null) {
       try {
          dateEnd = Integer.parseInt(edate);
          }catch (NumberFormatException e) {
             dateEnd = 0;
      }
    }
     
    
    return (exclude == null || !table.getString(i, nameColumn).contains(exclude)) &&
        (match == null || match.equals("") ||  table.getString(i, nameColumn).contains(match)) &&
        (state == null || state.equals(table.getString(i, "State"))) && (sdate == null || sdate.equals("") ||  dateIndex >= dateStart)
        && (edate == null || edate.equals("") ||  dateIndex <= dateEnd);
  }
  
  
  FloatList getFloatListWithFilter(String columnName, float min, float max, String nameColumn, String exclude, String match, String state, String sdate, String edate) {
    //printFilters(exclude, match, state, sdate, edate);
    FloatList results = new FloatList();
    for (int i = 0 ; i < table.getRowCount() ; i++) { 
      if (include(i, nameColumn, exclude, match, state, sdate, edate)) { 
        float val = table.getFloat(i, columnName);
        if(!Float.isNaN(val) && val >= min && val<= max) {
          results.append(val);
        }
      }
    }
    return results;
  }
      
   int numberOfObjects(String country) { 
      ArrayList<String> names = new ArrayList();
      names = getStringArray("State");
      String out = "";
      //printArray(names);
      int numberOfObjects = 0;
      FloatList totalMass = getFloatList("Mass", country);
      float averageMass = getAverage(totalMass);
      FloatList totalDiameter = getFloatList("Diameter", country);
      float averageDiameter = getAverage(totalDiameter);
      FloatList totalPerigee = getFloatList("Perigee", country);
      float averagePerigee = getAverage(totalPerigee);
      FloatList totalApogee = getFloatList("Apogee", country);
      float averageApogee = getAverage(totalApogee);
      for(String name  : names) {
        //println(name);
        if(name.equalsIgnoreCase(country)) {
          numberOfObjects++;
        }
      }
      //println(numberOfObjects);
     for (TableRow row : table.matchRows(country, "State")) {
       //println(row.getString("Name") + ", Date:" + row.getString("LDate") + ", Mass:" + row.getDouble("Mass") + ", Diameter:" + row.getDouble("Diameter") + ", Apogee:" + row.getDouble("Apogee") + ", Perigee:" + row.getDouble("Perigee")); 
       //out = row.getString("Name") + ", Date:" + row.getString("LDate") + ", Mass:" + row.getDouble("Mass") + ", Diameter:" + row.getDouble("Diameter") + ", Apogee:" + row.getDouble("Apogee") + ", Perigee:" + row.getDouble("Perigee");
       //output.add(out);
     }
      //println(averageMass, averageDiameter, averagePerigee, averageApogee);
      doubleSummary = "Average Mass: " + averageMass + "\nAverage Diameter: " + averageDiameter + "\nAverage Perigee: " + averagePerigee + "\nAverage Apogee: " + averageApogee + "\n";
      summary = true;
      return numberOfObjects;
  }
  
  void draw(){
    if (summary){
      y = 150;
      text("Summary: ", 100, 25);
      text(doubleSummary, 100, 70);
      for (int i = 0; i < output.size(); i++){
        if(y < 600)
          text(i + ":" + output.get(i) + "", 0, y);
        y = y + 25;
      }
    }
  }
  
  void clearArray(){
    output.removeAll(output);
  }
 
}

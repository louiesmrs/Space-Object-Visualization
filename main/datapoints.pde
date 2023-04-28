class Datapoint { 
    int sat;
    String name;
    String date;
    String status;
    String state;
    double mass;
    double diameter;
    double perigee;
    double apogee;
     
    Datapoint(int sat, String name, String date, String status, String state, double mass, double diameter, double perigee, double apogee){
           this.sat = sat; this.name = name; this.date = date; this.status = status; this.state = state; 
           this.mass = mass; this.diameter = diameter; this.perigee = perigee; this.apogee = apogee;
    }
    
    void draw(){
     println(sat + " Name: " + name + ", Launch Date: " + date + ", Status: " + status + ", State: " + state + 
      ", Mass: " + mass + " kg, Diameter: " + diameter + " m, Perigee: " + perigee + " km, Apogee: " + apogee + " km") ;
     text(sat + " Name: " + name + ", Launch Date: " + date + ", Status: " + status + ", State: " + state + 
    ", Mass: " + mass + " kg, Diameter: " + diameter + " m, Perigee: " + perigee + " km, Apogee: " + apogee + " km", 20, 20);
    }
       
}

/*Nehal Batra added Table basicTable, and method void readData() and called it in setup() to read in the data from the tsv file using loadTable() into 
basicTable containing all the information from all columns about each space object on 19/03/2022 at 3:40pm. 
Only certain information specified in the specification document is actually printed to test whether the program is reading the entirety of the data or not.*/
/*Karim Al Abbasi made the attributes that Nehal put in main global so it would be esaier to pass these attributes to the constructors for making objects. Karim also made the 
Datapoint class with a constructor that passes in these/some attributes to objects. Karim made the first object to test which is object1 of class Datapoint that will have these
attributes by calling the constructor of the Datapoint class. Karim did this on 20/03/2022 at 12:35pm. */
// Varun Anand created an arraylist that stores multiple instances of the class "Datapoint" on 20/03/22 at 22:25
/*Nehal Batra added an Array objects[] in the readData method and an ArrayList objectList of type Datapoint in setup(). 
Commented out the ArrayList added by Varun since it was not working. Also added a method called void draw()
in class Datapoint which prints each instance of an object from the class. Made another minor change to the class. 
Also added a draw() method in main to draw the ArrayList. 20.03.2022 23:26. */
/*Karim moved size() before the for loop in setup in main. Also added code to show the text of the instances on the screen in both setup in main and in draw() in 
Datapoint class (declared and assigned the variable myFont and added the method textFont() in setup in main and added method text() in draw in the 
Datapoint class) 20/03/2022 23:55 pm */
/*Nehal Batra added a Screen class with the constructor taking color, an addWidget method with adds widgers from Widget class to an Arraylist, a draw method which 
draws the screen and widgets on it and a getEvent method which calls the getEvent method in Widget class. Added a Widget class with a getEvent method along with some 
empty methods so fellow group member can do them. Created Screen objects in main and drew them using draw method from Screen. Added a skeleton for the mousePressed() 
method in main. Made the variable list for the data fit into three lines because it was taking a lot of space. 22/03/22 at 22:35 */
/*Nandini Gupta added a Widget class with the constructor taking the x and y position, width, height, label name, label color, font, and event number. It also has a 
getEvent method which helps us to know which button is pressed and what function it should perform. Nandini also updated main accordingle so that the program draws the
screen and the widgets. Nandini has made a total of 5 screens - 1 home screen containing the option widgets and 1 screen for each graph containing a widget which allows 
user to return to the home screen. Nandini also updated the getEvent function in the screen class so that it was correct according to the parameters passed and the 
function it performed. 23/02/22 2:50pm*/
/* Louie Somers added a queryResults method that takes in a reduced form of the table and is able to make individual lists for each of the columns. 
It also has a method to convert the columns of doubles to FloatLists in order to get the max value. It also contains a sort function.
Added a barGraphWidget and barWidget classes. The barGraphWidget manages the barWidgets by creating lists for the widgets, that show the name of the object,
and for the barWidgets which display the data, in this case mass. On main I added barGraphWidget that displays the name of the object against the mass. 
This is incomplete as a scroll function needs to be implemented.
To main, I added at the end of readData(); a way to remove all the columns we aren't using and then passed this reducedTable into queryResults. 
24/03/22 1:00*/
/* Louie Somers created a seperate constructor in widget to deal better with text. Added in barGraphWidget a boolean which is passed as true if the data contains negatives. 
Fixed the barGraphWidget so that it can now display negatives. Added methods in queryResults that pass in an extra int that makes the arrayList returned only go up to that number
Added in queryResults a getLongestStringMethod. Added a scale to the barGraphWidget. Added a comments tab with screen sizes. Added a settings method in main for the screen size.
24/03/ 17:00*/
/* Louie Somers added methods for getting lists with filters in QueryResults. Deleted  barWidget class. Added Manager Widget which extends Widget, a class for a widget that controls other widgets.
Added barGraphScreen which is used to display the barGraphs and Drop down menu. Added drop down menu widget class. Added new class for scrollable bar graph which implements a scollbar and method for
changing pages of data shown. Added scrollbar class which moves with top and bottom button widgets as well as up and down keys.
31/03/22 21:30
/* Louie Somers added Filters to the barGraphScreen this week. Added state drop down to fiter by state. Added orbit drop down to filter apogee and perigee. Added debris button to filter out debris objects.
Added search bar to search for specific names. Changed to color and layout of barGraphScreen, which involved adding colors to constants tabs. Added line to bar graph to show average of all objects shown. 
Fixed the scrollbar to resize when object list is filtered. Changed the drop downs so that they now display the name of the current option instead of just the header. 07/04/22 23:00
/*
/* Louie Somers fixed drop down menus to display more items. Added filters to bar graph for dates. Added number of items shown in bottom left corner. 08/03/22 12:30 
*/
/*Karim Al Abbasi made the graphs for the other attributes as well such as the perigee, apogee and the diameter on 24/03/2022 at 15:00. He also changed the color of the bar widgets 
to make it more visible instead of it being grey which would make it hard to se with the grey background. 24/03/2022. at 15:27. Karim also moved the widgets buttons on the main screen to the left so he was able to add
a box with an introductory text for users. 24/03/2022. at 16:30 pm*/
//Nehal Batra fixed the latency issues by getting rid of unused fields. 24/03/22 17:23
/*Nehal Batra added a textWidget class, made a textWidget called insertName in main and added an event switch statement for it along with a keyPressed method in main. 
This will later be used for some queries. 29/03/2022 23:07*/
//Nehal Batra added method numberOfObjects(String country) to queries which takes in the name of the country from the text widget's input (built through StringBuilder) and returns the number of objects. 31/03/22 16:47
//Nandini Gupta updated the main screen. Removed the widgets on the main screen so that the program is more efficient and less redundant. 07/04/22 16:52
//Nehal Batra added a for loop in method numberOfObjects(String country) which matches the rows from the table that have the country's name in them and prints the summary of all objects from that country. 07/04/22 17:49
//Nehal Batra made a summary screen that displays the summary for the country entered in the text box, added clarArray() method to QueryResults to clear the array being printed and made more changes to numberOfObjects(String country). 12/04/22 20:34


//Note for group members : if this seems wrong or does not seem to work properly, let me know and we can discuss what changes we can make - Nehal
// Varun Anand made a comments tab which gets updated by the team members when code gets added - 24/03/22 3:17 P.M
// Questions To Ask The Demonstrators
// - How would we implement a scroll function so all the data can be seen on the screen or if there is another way to display all the data on the screen.
// - A way to load in the data faster
// - What to display other on the screen other than the graphs

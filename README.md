# Online-Movie-Ticket-Management

Most of us watch movies for recreation. Sometime movies make us emotional and sometimes they educate us about different cultures, societies and even about science. Most of the time we enjoy movies at home but often we go to the cinema to get better experience. It would be very nice if we could know all the necessary information before being physically present at the theatre. The information may be like which movies are being shown now and which are coming soon, what the hall-categories and their respective seat-prices are, availability of seats for a specific show-time, etc. We selected our project so that people would get all these information easily and then can reserve seats online. And we have accomplished our goal successfully.
<br/>
<br/>
![gif_image](https://cloud.githubusercontent.com/assets/9255705/17906958/591f26ce-699b-11e6-841b-d8f062136c38.gif)
<br/>

## List of Contents:
[Key Features](#key-features)<br/>
[Initial Contributions](#initial-contributions)<br/>
[How to Run the Project](#how-to-run-the-project)<br/>
[Scope of Improvements](#scope-of-improvements)<br/>
## Key Features

The key features of the project are listed below:
<br/>
<strong>From end-users’ perspective:<strong/>

* Searching options.
* Brief information about a movie and option to watch the trailer online.
* Detailed schedules.
* Categorized movies according to the format (2D or 3D).
* Detailed pricing information for different types of cinema halls based on movie format.
* A model different sections in the cinema-hall is available where reserved seats are marked with different color. Here seats can be selected for reservation.
* 3-step seat reservation system.

<br/>
<strong>From developers’ perspective:<strong/>
* Following technologies and software have been used in developing the project.
 * Oracle (PL/SQL)
 * HTML5
 * CSS3
 * Java / Java EE (Jsp & Servlet)
* <em>3-Layer Design </em><br />
We have separated the PL/SQL codes that deals with the database directly. Thus we have avoided hard-coded SQL codes spread allover the application code written in Java. So the layers are:
 1. The database.
 2. PL/SQL packages to deal with the database.
 3. The application codes written in Java.
* <em>Design Patterns</em> <br />
To utilize the concepts of Object Oriented Designs, we have implemented the following Design Patterns in the Java code. They are:
 1. Factory Pattern
 2. Initialization on Demand Holder (Lazy-Loaded Singleton).
 3. MVC Pattern
* Because of using three-layer design and design patterns, the source code is easily maintainable and modifiable.

## Initial Contributions
This website was developed as an assignment for <em>CSE4126: Distributed Database Systems Lab </em>. A team was formed for this project. The Team members were:
 1. [ParthoShuvo](https://github.com/ParthoShuvo/).
 2. [ArifChowdhury](https://github.com/ArifChowdhury)


 The detailed contributions are listed below:
 * <em>The Database </em><br />
The database-design (ERD) was developed by [ParthoShuvo](https://github.com/ParthoShuvo/). He also wrote the DDL-Queries which were almost unchanged till final submission.
 * <em>The PL/SQL Packages </em><br />
 The PL/SQL packages were developed by [ArifChowdhury](https://github.com/ArifChowdhury). <br/ >
 These packages are also available in a [different GitHub repository](https://github.com/ArifChowdhury/Distributed-Database-Systems-Lab) with Java sample code showing how to use them from Java.
 * <em>Business Logics in Java </em><br />
The Java codes have been written by [ParthoShuvo](https://github.com/ParthoShuvo/).
 * <em>The Front-end </em><br />
 For the Front-end designs, the team has collected different free templates and then further modifications were done by [ParthoShuvo](https://github.com/ParthoShuvo/).

## How to Run the Project

To run the project, follow these steps carefully.
 1. Install an Java EE version supported IDE either [Eclipse](https://www.google.com/search?q=eclipse+javaee&ie=utf-8&oe=utf-8&client=firefox-b-ab) or [IntelliJ IDEA](https://www.jetbrains.com/idea/download/#section=windows). These IDEs come with built in JAVA EE library support and platform. <br />
  Note: We have used Eclipse while developing.
 2. Install an application server like [Apache Tomcat Server](http://tomcat.apache.org/download-80.cgi),  [GlassFish Server](https://glassfish.java.net/download.html) or any other application server that supports Java EE 7. <br />
  Note: We have used Apache tomcat server.
 3. Now create a server instance for the project in your IDE. For better understanding follow this [tutorial](https://www.youtube.com/watch?v=b42CJ0r-1to).
 4. Install [Oracle database express-edition 11g](http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html) and for database management system you can choose either  [Navicat](https://www.navicat.com/download) or [Oracle Sql Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html). <br />
  Note: We have used Oracle Sql Developer.<br />
 If problems arise, follow these YouTube playlists.  
  * For <em>Oracle Database Express-Edition 11g</em>: check this [playlist](https://www.youtube.com/watch?v=0NLsJQCvKXY&list=PLMlNiWEoh5Qpcdll6SUN_ClcgmKycYEtH).
  * To install <em>Oracle Sql developer</em> check this [tutorial](https://www.youtube.com/watch?v=0aIKyA0F4I8) .

 5. Create a connection by setting <br />
  * user_name as: <em> MOVIE <em/>
  * New password as: <em>MOVIE</em>.
 6. Import the data from [exported.sql](https://mega.nz/#!XpMVWI6b!IqRU9mHzdkZ_irM2KTLg_X5J2UHdPMGgAaF11ykMQ5Q) file.
 7. FOR JDBC connection, we have used this library [ojdbc.jar](http://www.oracle.com/technetwork/apps-tech/jdbc-112010-090769.html). It is already there in the project repository. Before building this project, check if this library has been included to java build path correctly.
 8. Run the project on server and choose the server instance.


## Scope of improvements
We could not have completed the admin-panel due to shortage of time. And the confirmation in the 3rd phase of seat reservation is not enough at this moment. So in these two sections, we have much to improve further.

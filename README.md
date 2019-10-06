## Battlescribe Stylesheets for Warhammer 40000

### Instructions for all users

1. Clone the repository
  `git clone https://github.com/DaeronAlagos/battlescribe-stylesheets-wh40k.git`

### Instructions for Battlescribe users

1. Create your Army Roster in Battlescribe

2. Export in Battlescribe
  `File -> Export roster...`
  
3. Browse for the XSL Stylesheet from the newly created battlescribe-stylesheets-wh40k/dist folder

4. Browse for the Destination File and select a folder where you want to save the file. Name the file; eg. myarmy.html (note the .html here is important).

5. Click 'Export' then 'Done'.

6. Open the html file in your web browser and print as required.

### Instructions for Developers

0. The build process requires Nodejs. Please follow the instructions to install Node LTS on the official website

1. Change to the project folder `cd battlescribe-stylesheets-wh40k`

2. Install the required NPM modules `npm install`

3. Create a roster in Battlescribe and save it as a .ros file, to the battlescribe-stylesheets-wh40k/data folder

4. Rename your roster file to have the .xml file extension

5. Build your first distribution file `gulp build --bsfile YOUR_FILE.xml`

6. Run gulp with browser-sync `gulp --bsfile YOUR_FILE.xml`

7. Edit the files in the src folder and see your changes in the web browser that opened when you started gulp
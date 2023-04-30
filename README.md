# AboApp2Excel
There is an awesome App, which I use for tracking recurring payments:

"Abonnements" App for Android from Simon Osterlehner

https://play.google.com/store/apps/details?id=de.simolation.subscriptionmanager&amp;ref=https://github.com/networksecurityvodoo/


I now wantend to export the information to excel to include in my dashboard.
So i wrote two Powershellscripts for that.

Usage:
1. Save an Backup from within the App and load on your PC.
2. Copy the files decode-to-json.ps1 and json-to-csv.ps1 to the same directory as the backup file.
3. Run .\decode-to-json.ps1 from within the directory 
4. This creates abos.json file.
5. Run .\json-to-csv.ps1 from the same directory
6. This creates output.csv and disabled-entries.csv 

Start Excel and via Data -> Load -> File -> Text/CSV, load the output.csv into the table.

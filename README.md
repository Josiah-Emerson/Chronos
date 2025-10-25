# Chronos
Internal tooling for Cro Cap to aid in security investment decision making and review processes

Metrics:
 - Current Price
 - YTD change 
 - Market Cap 
 - EV 
 - P/E 
 - Forward P/E Ratio 
 - PEG Ratio (Price/Earning to Growth)
 - Price-to-Sales (P/S) Ratio 
 - Price-to-Book (P/B) Ratio 
 - Price-to-Cash Flow (P/CF)
 - EV to EBITDA 
 - EV to Sales 

TODO:
- Change DB design so that stage one has reasoning id which links to an entry in analysis
    - Update so that stage three reasoning id is actually a thesis
    - Change the api to reflect returning a reasoning id and a thesis
- Add in the possible codes it can return
- Check with cros to see what data types the metrics should be
    - i.e. how much precision is needed for most metrics?
- Check if news API provides title. If it doesn't, change the articles title to be null if needec
- Update AI partners email and uuid when we decide on a format

Current build process:
For database: 
- Create the database file in the src/db folder by running this command in the folder:
    - "sqlite3 chronos.db < ../../setup.sql"
    - NOTE: the ../../setup.sql should represent the filepath to wherever setup.sql is


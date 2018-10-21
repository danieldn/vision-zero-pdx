# Vision Zero PDX

Winner of Hack for a Cause - 2018 Hackathon by the Technology Association of Oregon

## Problem Statement

Traffic related fatalities are prevalent throughout the Portland Metro area.  Much of the [Vision Zero](https://www.portlandoregon.gov/transportation/40390) campaign is to make the streets of our region safer by not only preventing injuries and fatalities, but to improve the accessibility of mobility for all types of residents and visitors.

The Technology Association of Oregon looks forward to bringing together stakeholders from the public, private, and non-profit sectors to build open source solutions that elevate the work of Vision Zero in the Portland metro area.

Hack for a Cause teams will innovate ways with enthusiastic partners and hackers to make an even larger impact on reducing fatalities and injuries in the Portland Metro area.  

## Our Solution

A web portal for the City of Portland and Portland's safety researchers to access, monitor, and analyze Portland's IQ traffic sensor system.

Unlike the City's current interactive map of accidents, our product would display calculated near-misses and other transportation conflict data previously unavailable.

Furthermore, we enable Portland's city departments to collaborate across organizations by building a custom Slack App that interacts with our web portal. The app, which can be installed on any Slack workspace, lets users access and share traffic sensor data through General Electric's Current API. The app also servers as a subscriber to GE's websocket to receive live data.



## Web Development
Development of this webapp depends on Python, Flask, Bootstrap, and Slack.

To run the web app locally
```
git clone https://github.com/danieldn/vision-zero-pdx.git
cd webapp/
virtualenv env
source env/bin/activate
pip install -r requirements.txt
python app.py
```
Open url in browser to ensure everything works
```
localhost:5000
```
To exit virtualenv
```
deactivate
```

## Web Deployment

Deploy webapp locally using docker
```
docker build -t vision-zero-pdx:1.0
docker run -p 5000:5000 vision-zero-pdx:1.0
```
Check everything works
```
curl localhost:5000
```
We currently serve our app on the Heroku platform. To serve app, install [Heroku](https://devcenter.heroku.com/articles/heroku-cli) and login
```
heroku login
```
Build and push container to the Heroku registry
```
heroku container:push web
heroku container:release web
heroku open --app vision-zero-pdx
```

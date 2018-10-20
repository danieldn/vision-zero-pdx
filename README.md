# Vision Zero PDX

https://vision-zero-pdx.herokuapp.com


## Development
This webapp uses Python, Flask, Bootstrap, and Slack.

To run the web app locally
```
cd webapp/
virtualenv env
source env/bin/activate
pip install -r requirements.txt
python app.py
```
Open browser to ensure everything works
```
localhost:5000
```
To exit virtualenv
```
deactivate
```

## Deployment

Deploy webapp locally using docker
```
docker build -t vision-zero-pdx:1.0
docker run -p 5000:5000 vision-zero-pdx:1.0
```
Check everything works
```
curl localhost:5000
```
To serve app on Heroku, first login
```
heroku login
```
Then push container to Heroku registry.
```
heroku container:push web
heroku container:release web
heroku open --app vision-zero-pdx
```
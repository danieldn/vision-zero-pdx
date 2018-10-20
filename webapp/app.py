import os
# import json
from datetime import datetime
from flask import Flask, request, Response, json
from flask import render_template
app = Flask(__name__)


@app.route("/")
def index():
    return render_template('index.html')

@app.route('/slack', methods=['GET','POST'])
def slack_help():
    if request.method == 'POST':
        # content = request.get_json()
        # return "POST content:" + json.dumps(request.json)
        # js = json.dumps(request.json)
        with open('slack/help.json') as json_data:
            js = json.load(json_data)
            print(js)
            # resp = Response(js, status=200, mimetype='application/json')
            resp = json.jsonify(js)
            # return resp
            return resp

    return "slack help endpoint"

@app.route('/slack/report', methods=['GET','POST'])
def slack_report():
    if request.method == 'POST':
        with open('slack/report.json') as json_data:
            js = json.load(json_data)
            resp = json.jsonify(js)
            return resp
        
    return "slack report endpoint"

@app.route('/report', methods=['GET'])
def report():
    with open('data/traffic.json') as json_data:
        js = json.load(json_data)
        return json.dumps(js)

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port, debug=True)

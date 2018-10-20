from flask import Flask
from flask import render_template
app = Flask(__name__)


@app.route("/")
def index():
    return render_template('index.html')

@app.route("/on")
def lights_on():
    with open("./lights", "w") as f:
        f.write("1")
    return "1"

@app.route("/off")
def lights_off():
    with open("./lights", "w") as f:
        f.write("0")
    return "0"

@app.route("/lights")
def get_lights():
    with open("./lights", "r") as f:
        light_status = f.read()
    return light_status

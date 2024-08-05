from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route('/')
def index():
    background_color = os.getenv('BACKGROUND_COLOR', 'blue')  # Default to blue if env var is not set
    return render_template('index.html', background_color=background_color)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

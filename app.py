from flask import Flask
import logging
import sys

# Configure logging to output to the console
logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

@app.route('/')
def hello_world():
    logger.info("Hello, World! endpoint was called")
    return 'Hello, World!'

if __name__ == '__main__':
    logger.info("Starting Flask app")
    app.run(host='0.0.0.0', port=5000)
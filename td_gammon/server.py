from flask import Flask, request, jsonify


app = Flask(__name__)


@app.route('/api/v1/turn', methods=['POST'])
def process_turn():
    request_data = request.json
    return jsonify(request_data)


@app.route('/liveness', methods=['GET'])
def liveness_probe():
    return "OK"


@app.route('/readiness', methods=['GET'])
def readiness_probe():
    return "OK"


@app.route('/startup', methods=['GET'])
def startup_probe():
    return "OK"


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)

from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to the Wisecow App!"

@app.route('/api/v1/resource', methods=['GET'])
def get_resource():
    data = {
        "message": "This is a sample resource from the Wisecow API."
    }
    return jsonify(data)

@app.route('/api/v1/resource', methods=['POST'])
def create_resource():
    request_data = request.get_json()
    response_data = {
        "message": "Resource created successfully.",
        "data": request_data
    }
    return jsonify(response_data), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

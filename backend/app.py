from flask import Flask, request, jsonify
from flask_cors import CORS
from pymongo import MongoClient
from bson.objectid import ObjectId

app = Flask(__name__)
CORS(app)  # biar bisa diakses dari Flutter

# --- Ganti string ini sesuai MongoDB kamu ---
client = MongoClient("mongodb+srv://freeAkses:lG3YBXkrr8Vx37DD@cluster0.kaemgml.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")
db = client["profile_db"]
profiles = db["profiles"]

# GET semua profil
@app.route('/profiles', methods=['GET'])
def get_profiles():
    result = []
    for p in profiles.find():
        p['_id'] = str(p['_id'])  # convert ObjectId to string
        result.append(p)
    return jsonify(result)

# POST tambah profil baru
@app.route('/profiles', methods=['POST'])
def add_profile():
    data = request.json
    inserted = profiles.insert_one(data)
    data['_id'] = str(inserted.inserted_id)
    return jsonify(data), 201

# PUT update profil
@app.route('/profiles/<id>', methods=['PUT'])
def update_profile(id):
    data = request.json
    profiles.update_one({'_id': ObjectId(id)}, {'$set': data})
    data['_id'] = id
    return jsonify(data)

# DELETE hapus profil
@app.route('/profiles/<id>', methods=['DELETE'])
def delete_profile(id):
    profiles.delete_one({'_id': ObjectId(id)})
    return jsonify({'status': 'deleted', 'id': id})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)



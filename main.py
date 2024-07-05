from flask import Flask, request, jsonify
import db_utils
import requests

app = Flask(__name__)


@app.route('/')
def index():
    return "Welcome to the Travel Itinerary Planner API!"


@app.route('/itineraries', methods=['GET'])
def get_itineraries():
    connection = db_utils.create_connection()
    try:
        itineraries = db_utils.fetch_query(connection, "SELECT * FROM itineraries")
        return jsonify(itineraries), 200
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    finally:
        if connection and connection.is_connected():
            connection.close()


@app.route('/itineraries', methods=['POST'])
def create_itinerary():
    data = request.json
    query = """
    INSERT INTO itineraries (user_id, destination, start_date, end_date, activities)
    VALUES (%s, %s, %s, %s, %s)
    """
    values = (data['user_id'], data['destination'], data['start_date'], data['end_date'], data['activities'])
    connection = db_utils.create_connection()
    try:
        db_utils.execute_query(connection, query, values)
        return jsonify({"message": "Itinerary created successfully!"}), 201
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    finally:
        if connection and connection.is_connected():
            connection.close()


@app.route('/itineraries/<int:itinerary_id>', methods=['GET'])
def get_itinerary(itinerary_id):
    connection = db_utils.create_connection()
    try:
        itinerary = db_utils.fetch_query(connection, "SELECT * FROM itineraries WHERE id = %s", (itinerary_id,))
        if itinerary:
            return jsonify(itinerary[0]), 200
        else:
            return jsonify({"message": "Itinerary not found"}), 404
    except Exception as e:
        return jsonify({"message": str(e)}), 500
    finally:
        if connection and connection.is_connected():
            connection.close()


def run():
    print("Simulating API interactions...")
    try:
        response = requests.get('http://127.0.0.1:5000/itineraries')
        if response.ok:
            print(f"Response: {response.status_code} - {response.json()}")
        else:
            print(f"Request failed with status code {response.status_code}: {response.text}")
    except requests.RequestException as e:
        print(f"Request failed: {e}")

    new_itinerary = {
        "user_id": 1,
        "destination": "Paris",
        "start_date": "2023-08-01",
        "end_date": "2023-08-10",
        "activities": "Eiffel Tower, Louvre Museum"
    }
    try:
        response = requests.post('http://127.0.0.1:5000/itineraries', json=new_itinerary)
        if response.ok:
            print(f"Response: {response.status_code} - {response.json()}")
        else:
            print(f"Request failed with status code {response.status_code}: {response.text}")
    except requests.RequestException as e:
        print(f"Request failed: {e}")

    try:
        response = requests.get('http://127.0.0.1:5000/itineraries/1')
        if response.ok:
            print(f"Response: {response.status_code} - {response.json()}")
        else:
            print(f"Request failed with status code {response.status_code}: {response.text}")
    except requests.RequestException as e:
        print(f"Request failed: {e}")


if __name__ == '__main__':
    print("Starting Flask server...")
    app.run(debug=True)
    print("Flask server started.")
    run()

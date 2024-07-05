from flask import Flask, request, jsonify
import db_utils  # Importing your database utility module
import requests  # Importing requests for API interaction

app = Flask(__name__)  # Creating a Flask application instance


@app.route('/')
def index():
    """
    Route handler for the root endpoint.
    """
    return "Welcome to the Travel Itinerary Planner API!"


@app.route('/itineraries', methods=['GET'])
def get_itineraries():
    """
    Retrieves all itineraries from the database.
    """
    connection = db_utils.create_connection()  # Create a database connection
    try:
        itineraries = db_utils.fetch_query(connection, "SELECT * FROM itineraries")  # Fetch all itineraries
        return jsonify(itineraries), 200  # Return itineraries as JSON response
    except Exception as e:
        return jsonify({"message": str(e)}), 500  # Handle exceptions with a server error response
    finally:
        if connection and connection.is_connected():
            connection.close()  # Close the database connection


@app.route('/itineraries', methods=['POST'])
def create_itinerary():
    """
    Creates a new itinerary in the database based on JSON data in the request body.
    """
    data = request.json  # Get JSON data from the request body
    query = """
    INSERT INTO itineraries (user_id, destination, start_date, end_date, activities)
    VALUES (%s, %s, %s, %s, %s)
    """
    values = (data['user_id'], data['destination'], data['start_date'], data['end_date'], data['activities'])
    connection = db_utils.create_connection()  # Create a database connection
    try:
        db_utils.execute_query(connection, query, values)  # Execute SQL query to insert itinerary
        return jsonify({"message": "Itinerary created successfully!"}), 201  # Return success message
    except Exception as e:
        return jsonify({"message": str(e)}), 500  # Handle exceptions with a server error response
    finally:
        if connection and connection.is_connected():
            connection.close()  # Close the database connection


@app.route('/itineraries/<int:itinerary_id>', methods=['GET'])
def get_itinerary(itinerary_id):
    """
    Retrieves a specific itinerary based on itinerary_id.
    """
    connection = db_utils.create_connection()  # Create a database connection
    try:
        itinerary = db_utils.fetch_query(connection, "SELECT * FROM itineraries WHERE id = %s", (itinerary_id,))
        if itinerary:
            return jsonify(itinerary[0]), 200  # Return itinerary details if found
        else:
            return jsonify({"message": "Itinerary not found"}), 404  # Return not found message if no itinerary found
    except Exception as e:
        return jsonify({"message": str(e)}), 500  # Handle exceptions with a server error response
    finally:
        if connection and connection.is_connected():
            connection.close()  # Close the database connection


def run():
    """
    Simulates interactions with the API endpoints using requests module.
    """
    print("Simulating API interactions...")
    
    # Simulating GET request to retrieve all itineraries
    try:
        response = requests.get('http://127.0.0.1:5000/itineraries')
        if response.ok:
            print(f"Response: {response.status_code} - {response.json()}")
        else:
            print(f"Request failed with status code {response.status_code}: {response.text}")
    except requests.RequestException as e:
        print(f"Request failed: {e}")
    
    # Simulating POST request to create a new itinerary
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
    
    # Simulating GET request to retrieve a specific itinerary
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
    app.run(debug=True)  # Start Flask server in debug mode
    print("Flask server started.")
    run()  # Run the simulation of API interactions

    app.run(debug=True)
    print("Flask server started.")
    run()

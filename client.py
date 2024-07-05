import requests

# Base URL of the FLASK API
BASE_URL = 'http://127.0.0.1:5000/'


# Function to get the list of all itineraries
def get_all_itineraries():
    # Sending a GET request to the /itineraries endpoint
    response = requests.get(BASE_URL + 'itineraries')

    # Checking if the request was successful (status code 200)
    if response.status_code == 200:
        # Extracting the list of itineraries from the JSON response
        itineraries = response.json()

        # Printing the list of itineraries in a formatted way
        print("All Itineraries:")
        for itinerary in itineraries:
            print(f"ID: {itinerary['id']}, Destination: {itinerary['destination']}, "
                  f"Start Date: {itinerary['start_date']}, End Date: {itinerary['end_date']}, "
                  f"Activities: {itinerary['activities']}")
    else:
        # Printing an error message if the request was not successful
        print(f"Failed to fetch itineraries: {response.status_code} - {response.text}")


# Function to create a new itinerary
def create_itinerary(new_itinerary):
    response = requests.post(BASE_URL + 'itineraries', json=new_itinerary)

    # Checking if the request was successful (status code 201)
    if response.status_code == 201:
        print("New itinerary added successfully!")
        print(response.json())  # Print the response JSON for confirmation
    else:
        print(f"Failed to create itinerary: {response.status_code} - {response.text}")


# Function to get a specific itinerary by its ID
def get_itinerary(itinerary_id):
    # Sending a GET request to the /itineraries/<id> endpoint
    response = requests.get(BASE_URL + f'itineraries/{itinerary_id}')

    # Checking if the request was successful (status code 200)
    if response.status_code == 200:
        # Printing the itinerary details
        print(f"Itinerary details for ID {itinerary_id}:")
        print(response.json())
    elif response.status_code == 404:
        # Printing a message if the itinerary was not found
        print(f"Error: Itinerary with ID {itinerary_id} not found.")
    else:
        # Printing an error message if the request was not successful
        print(f"Failed to fetch itinerary: {response.status_code} - {response.text}")


# Main execution
if __name__ == '__main__':
    # Fetch and print all itineraries
    get_all_itineraries()

    # Example 1: Create a new itinerary and print the confirmation
    new_itinerary_1 = {
        "user_id": 1,
        "destination": "New York",
        "start_date": "2023-09-01",
        "end_date": "2023-09-10",
        "activities": "Empire State Building, Central Park"
    }
    create_itinerary(new_itinerary_1)

    # Example 2: Create another new itinerary and print the confirmation
    new_itinerary_2 = {
        "user_id": 1,
        "destination": "Tokyo",
        "start_date": "2023-10-01",
        "end_date": "2023-10-07",
        "activities": "Tokyo Tower, Shibuya Crossing"
    }
    create_itinerary(new_itinerary_2)

    # Fetch and print the details of the itinerary with ID 1 (assuming it exists)
    get_itinerary(1)

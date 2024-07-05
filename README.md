
# Travel Itinerary Planner API

Welcome to the Travel Itinerary Planner API! This Flask-based web service allows users to manage travel itineraries stored in a MySQL database.

## Table of Contents

- [Project Overview](#project-overview)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Setting Up the Environment](#setting-up-the-environment)
  - [Database Configuration](#database-configuration)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
  - [GET /itineraries](#get-itineraries)
  - [POST /itineraries](#post-itineraries)
  - [GET /itineraries/<itinerary_id>](#get-itinerary)
- [Database Setup](#database-setup)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

The Travel Itinerary Planner API provides functionalities to create, retrieve, and manage travel itineraries. It uses Flask for the backend framework and MySQL for database storage.Imagine you are planning a vacation and want to organize all the details of your trip in one place. The Travel Itinerary Planner API can help you do just that. You can create an itinerary for your trip, specifying the destination, travel dates, and the activities you plan to do.

### Example Use Case

#### Creating an Itinerary:
- You decide to plan a trip to Paris.
- You use the `POST /itineraries` endpoint to create a new itinerary with details such as "Paris", travel dates from "2024-08-01" to "2024-08-10", and activities like visiting the Eiffel Tower, Louvre Museum, etc.

#### Viewing Your Itinerary:
- Anytime you want to review your plans, you can use the `GET /itineraries/{itinerary_id}` endpoint to fetch the details of your Paris trip.

#### Updating Your Itinerary:
- You find out about a special event happening in Paris during your stay. You can update your itinerary using the `PUT /itineraries/{itinerary_id}` endpoint to include this event in your list of activities.

#### Deleting an Itinerary:
- If you need to cancel your trip, you can use the `DELETE /itineraries/{itinerary_id}` endpoint to remove your Paris itinerary from the system.

This API helps you keep your travel plans organized and accessible, ensuring a smooth and enjoyable trip.


## Installation

### Prerequisites

Before running this application, ensure you have the following installed:

- Python 3.x
- MySQL

### Setting Up the Environment

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/travel-itinerary-planner.git
   cd travel-itinerary-planner
   ```

2. **Create and activate a virtual environment:**

   ```bash
   python -m venv venv
   source venv/bin/activate   # On Windows use `venv\Scripts\activate`
   ```
   
### Database Configuration

1. **Create a MySQL database:**

   ```sql
   CREATE DATABASE travel_itinerary;
   ```

   Replace `'travel_itinerary'` with your desired database name if different.

2. **Configure database connection:**

   Update the database connection details in `config.py`:

   ```python
   DB_HOST = 'localhost'
   DB_USER = 'root'
   DB_PASSWORD = 'your_password'
   DB_NAME = 'travel_itinerary'
   ```

   Replace `'localhost'` with your database host address if different, `'root'` with your database username, `'your_password'` with your actual database password, and `'travel_itinerary'` with the name of your MySQL database.

## Usage

To run the Travel Itinerary Planner API, follow these steps:

1. **Activate the virtual environment (if not activated):**

   ```bash
   source venv/bin/activate   # On Windows use `venv\Scripts\activate`
   ```

2. **Start the Flask application:**

   ```bash
   python main.py
   ```

   This will start the Flask development server locally.

## API Endpoints

### GET /itineraries

Retrieves a list of all travel itineraries stored in the database.

### POST /itineraries

Creates a new travel itinerary in the database.

### GET /itineraries/<itinerary_id>(#get-itinerary)

Retrieves details of a specific travel itinerary identified by `<itinerary_id>`.

## Database Setup

Ensure your MySQL database is set up according to the configuration in `config.py`. You can create the necessary tables and schemas as per your application's requirements.

## Testing

The API includes unit tests to verify its functionality. To run the tests, use:

```bash
python -m unittest discover
```

## Contributing

Contributions are welcome! Please fork the repository, make your changes, and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

# config.py
# Configuration file for database connection settings
import os
# Database host address
DB_HOST = os.getenv('DB_HOST', 'localhost')
# Database username
DB_USER = os.getenv('DB_USER', 'root')
# Database password
DB_PASSWORD = os.getenv('DB_PASSWORD', 'klepacH1988!')
# Database name
DB_NAME = os.getenv('DB_NAME', 'travel_itinerary')

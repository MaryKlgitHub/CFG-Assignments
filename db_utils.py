# Creating the db_utils.py file
# Utility functions for database operations, including connection management, query execution, and data fetching.
import mysql.connector
from mysql.connector import Error
from config import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME


def create_connection():
    # Create a database connection
    connection = None
    try:
        connection = mysql.connector.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
    except Error as e:
        print(f"The error '{e}' occurred")
    return connection


def execute_query(connection, query, values=None):
    # Execute a single query
    cursor = connection.cursor()
    try:
        if values:
            cursor.execute(query, values)
        else:
            cursor.execute(query)
        connection.commit()
        print("Query executed successfully.")
    except Error as e:
        print(f"Error '{e}' occurred while executing the query.")
        connection.rollback()  # Rollback the transaction in case of error
        raise  # Re-raise the exception for further handling if needed


def fetch_query(connection, query, values=None):
    # Fetch data from the database
    cursor = connection.cursor(dictionary=True)
    try:
        if values:
            cursor.execute(query, values)
        else:
            cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as e:
        print(f"The error '{e}' occurred")
        return None

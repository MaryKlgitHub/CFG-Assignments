# test_api.py

import unittest
import requests

BASE_URL = 'http://127.0.0.1:5000/'


class TestTravelItineraryAPI(unittest.TestCase):

    def test_get_all_itineraries(self):
        response = requests.get(BASE_URL + 'itineraries')
        self.assertEqual(response.status_code, 200)
        self.assertIsInstance(response.json(), list)

    def test_create_itinerary(self):
        new_itinerary = {
            "user_id": 1,
            "destination": "Paris",
            "start_date": "2023-08-01",
            "end_date": "2023-08-10",
            "activities": "Eiffel Tower, Louvre Museum"
        }
        response = requests.post(BASE_URL + 'itineraries', json=new_itinerary)
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.json()['message'], "Itinerary created successfully!")

    def test_get_specific_itinerary(self):
        response = requests.get(BASE_URL + 'itineraries/1')
        self.assertIn(response.status_code, [200, 404])  # Either found or not found
        if response.status_code == 200:
            self.assertIsInstance(response.json(), dict)
            self.assertEqual(response.json()['id'], 1)
        elif response.status_code == 404:
            self.assertEqual(response.json()['message'], "Itinerary not found")


if __name__ == '__main__':
    unittest.main()

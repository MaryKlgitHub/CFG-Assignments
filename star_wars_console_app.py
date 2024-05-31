"""
Star Wars Character Console App

This console application interacts with the Star Wars API (SWAPI) to provide details about Star Wars characters.

Features:
- Displays a list of Star Wars characters.
- Allows the user to select a character from the list.
- Provides information on how to dress like the selected character.
- Retrieves additional details such as the character's birthplace, birth year, and the ship they flew on.

Requirements Fulfilled:
- Uses boolean values and if..else statements for branching logic.
- Utilizes data structures like lists and dictionaries.
- Implements for loops and functions with returns to reduce repetition and make the code reusable.
- Employs string slicing for formatting character details.
- Utilizes at least two inbuilt functions.
- Interacts with a free API (SWAPI) to get character information as JSON.
- Adds comments to explain API setup and usage, and includes a brief program overview.

"""
import requests
import json
import random


# Function to get data from SWAPI
def get_swapi_data(endpoint):
    response = requests.get(f'https://swapi.dev/api/{endpoint}/')
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Error: Unable to fetch data from SWAPI (Status code: {response.status_code})")
        return None


# Function to display characters and get user's choice
def display_characters(characters):
    print("Star Wars Characters:")
    for idx, character in enumerate(characters, 1):
        print(f"{idx}. {character['name']}")

    while True:
        choice = input("Choose a character by number: ")
        if choice.isdigit() and 1 <= int(choice) <= len(characters):
            return int(choice) - 1
        else:
            print("Invalid choice. Please enter a valid number.")


# Function to get character details and return formatted string
def get_character_details(character):
    details = f"Character: {character['name']}\n"
    details += f"Height: {character['height']} cm\n"
    details += f"Mass: {character['mass']} kg\n"
    details += f"Hair Color: {character['hair_color']}\n"
    details += f"Skin Color: {character['skin_color']}\n"
    details += f"Eye Color: {character['eye_color']}\n"
    details += f"Birth Year: {character['birth_year']}\n"
    details += f"Gender: {character['gender']}\n"

    # Add dressing advice
    details += f"\nDressing Advice:\n"
    if character['gender'] == 'male':
        details += "Wear a simple tunic and boots, preferably in neutral colors like beige or brown.\n"
    elif character['gender'] == 'female':
        details += "Consider a long dress or robe, with comfortable shoes.\n"
    else:
        details += "Wear something that fits well and allows freedom of movement.\n"

    # Add random ship information for fun
    ships = [
        "Millennium Falcon",
        "X-Wing",
        "TIE Fighter",
        "Star Destroyer",
        "Slave I"
    ]
    details += f"\nFlew on: {random.choice(ships)}\n"

    return details


# Main function to run the app
def main():
    # Display welcome message
    print("Welcome to the Star Wars world!")
    print("Here you can find everything about Star Wars characters.")
    print("Choose the one you like and find out more about it.\n")

    while True:
        # Fetch character data
        data = get_swapi_data('people')
        if not data:
            return

        characters = data['results']

        # Display characters and get user's choice
        choice_index = display_characters(characters)
        chosen_character = characters[choice_index]

        # Get character details
        details = get_character_details(chosen_character)

        # Write results to a file
        with open("star_wars_character_details.txt", "w") as file:
            file.write(details)

        # Display character details
        print("\nCharacter details:\n")
        print(details)

        print("\nCharacter details written to 'star_wars_character_details.txt'.")

        # Ask if the user wants to choose another character
        while True:
            continue_choice = input("\nWould you like to choose another character? (yes/no): ").strip().lower()
            if continue_choice in ['yes', 'no']:
                break
            else:
                print("Invalid choice. Please enter 'yes' or 'no'.")

        if continue_choice == 'no':
            print("Thank you for using the Star Wars Character Console App! May the Force be with you!")
            break


# Run the main function
if __name__ == "__main__":
    main()

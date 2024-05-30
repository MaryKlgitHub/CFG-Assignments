# CFG-Assignments

Welcome to the CFG-Assignments repository! This repository contains various coding assignments and projects related to the Code First Girls (CFG) course. The first project in this repository is a console application that interacts with the Star Wars API (SWAPI) to provide details about Star Wars characters.

## Project Description

The Star Wars Character Console App allows users to:

1. Display a list of Star Wars characters.
2. Select a character from the list.
3. Receive information on how to dress like the character.
4. Get additional details such as the character's birthplace, birth year, and the ship they flew on.

## Setup Instructions

### Prerequisites

- Python 3.x
- `requests` library

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/CFG-Assignments.git
    cd CFG-Assignments
    ```

2. Install the required Python library:

    ```bash
    pip install requests
    ```

## Usage Instructions

1. Navigate to the directory containing the script:

    ```bash
    cd CFG-Assignments
    ```

2. Run the script:

    ```bash
    python star_wars_console_app.py
    ```

3. Follow the on-screen instructions to interact with the application.

### Example

After running the script, you will be greeted with a welcome message. You can then choose a character from the list, and the app will display detailed information about the character and write this information to a file named `star_wars_character_details.txt`.

## Script Overview

### star_wars_console_app.py

This script interacts with the SWAPI to fetch and display Star Wars character details. Key features include:

- Fetching data from SWAPI.
- Displaying a list of characters.
- Allowing user selection.
- Displaying character details.
- Writing character details to a file.

### Functions

- `get_swapi_data(endpoint)`: Fetches data from the specified SWAPI endpoint.
- `display_characters(characters)`: Displays a list of characters and returns the user's choice.
- `get_character_details(character)`: Returns formatted character details including dressing advice.

## Contribution Guidelines

We welcome contributions to this project! To contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Make your changes.
4. Submit a pull request with a detailed description of your changes.

### Reporting Issues

If you encounter any issues with the project, please create an issue on GitHub.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or suggestions, please reach out to me via GitHub issues or directly at [klepacimarina@gmail.com](mailto:klepacimarina@gmail.com).

---

Thank you for visiting the CFG-Assignments repository! I hope you find the Star Wars Character Console App both fun and educational.


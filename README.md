# Automatic AI-commenting on code app

This is a basic app built with Flask that automatically comments on RPG code that is fed to the the app using an AI model from OpenAI.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

Python 3
OpenAI ChatGPT API
Code editor

### Installing

A step by step series of examples that tell you how to get the development env running:

Clone the repository
git clone https://github.com/torsteinknutson/RPG_app.git

cd into the folder RPG_APP
Create and activate a virtual environment (windows):
python -m venv venv
cd into the venv folder 
Type: Scripts\activate into terminal to activate venv

Install the dependencies (into the venv after it has been activated):
pip install -r requirements.txt

Paste your own OpenAI API key in the .env file where it says OPEN_API_KEY:

Run the application
cd into the application where the app.py file is - cd app
Type: python app.py into the terminal to start app locally on your machine
Click the link to open the app in a browser

### How the app works

The app sends a collection of prompts to OPenAI ChatGPT 3.5 Turbo model.
The first two prompts contains instructions for what the AI should expect as input and
what, and how it should return an answer. The third prompt is added to this, and is what 
is possible to input in the SQLRPGLEAI app runnning in your browser. When you paste in RPG
code and press send, the API will send the information to OpenAI and return back the original
code + comments on that code in Norwegian.

You can ofcourse edit the prompts of this app to do whatever you want.    


from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from config import Config

# Initializing app
app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)

#from app import routes, models, views


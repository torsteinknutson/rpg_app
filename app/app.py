from flask import Flask, render_template, jsonify, request, redirect, url_for
from flask_caching import Cache
#from flask import request
import config
from markupsafe import Markup

from rb_func import rb_func_1


def page_not_found(e):
  return render_template('404.html'), 404

app = Flask(__name__)
app.config.from_object(config.config['development'])
app.register_error_handler(404, page_not_found)

app.config["CACHE_TYPE"] = "SimpleCache" # In case of a multithread server with gunicorn best approach is ['CACHE_TYPE'] = 'FileSystemCache' 
cache = Cache(app)
    



@app.route('/')
def form():
    return render_template('index.html')
 
@app.route('/data/', methods = ['GET', 'POST'])
def data():
    if request.method == 'GET':
        return f"GET not allowed"
    
    if request.method == 'POST':    
        #get user input
        cache.set("cache_input", request.form) # to get value use cache.get("cache_input")
        #print(cache.get("cache_input"))
        user_input = request.form
        with open(r'user_input.txt', 'w', encoding='utf-8') as f:
            f.write(str(user_input))
        
        #get output
        
        ai_output = rb_func_1(user_input)
        ai_output_strong = Markup(ai_output)
        print(ai_output_strong)


        return render_template('data.html',form_data = user_input, form_output = str(ai_output))  #


if __name__ == '__main__':
    app.run(host='0.0.0.0', port='8888', debug=True)

# run: python app.py    
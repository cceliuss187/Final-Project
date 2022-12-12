from flask import Flask,redirect,render_template,url_for,request


app = Flask(__name__)

@app.route('/')
def home():
   
   return render_template('index.html')

@app.route('/about.html')
def about():
   return render_template('about.html')

@app.errorhandler(404)
def page_not_found(error):
    return render_template('page_not_found.html'), 404


if __name__ == '__main__':
   app.run()
   
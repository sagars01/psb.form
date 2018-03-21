from flask import Flask, flash, redirect, render_template, request, session, abort, url_for, jsonify
from flask_cors import CORS, cross_origin
import MySQLdb
import os
 
app = Flask(__name__)

CORS(app, support_credentials=True)
host = "localhost"
user = "sagar"
password = "abcd1234"
database = "pbs_project"

@app.route('/')
def home():
    array = [{"Logged_in" : session.get('logged_in')}]
    return jsonify(array)
        
 
@app.route('/login', methods=['GET','POST'])
def do_admin_login():
    global userid
    if request.method == 'GET':
        return render_template('login.html')
    elif request.method == 'POST': 
    	db = MySQLdb.connect( host, user, password, database)
    	cursor = db.cursor()
	details = request.get_json(force=True)
    	count = cursor.execute("Select id from Login where user = %s and password = %s",( details['username'], details['password']))
    	userid = cursor.fetchall()
    	if count > 0:
        	session['logged_in'] = True
    	else:
        	flash('wrong password!')
    	cursor.close()
    return home()

@app.route('/welcome', methods=['GET', 'POST'])
def product_select():
	array1 = []
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
        	cursor = db.cursor();
       		cursor.execute("Select product_id, product_name from product")
        	products = cursor.fetchall()
		for row in products:
			array1.append({"Product_id": row[0], "Product": row[1]})
        	cursor.close()
	elif request.method == 'POST':
		db = MySQLdb.connect( host, user, password, database)
        	cursor = db.cursor()
        	details = request.get_json(force=True)
        	cursor.execute("Insert into map_user_to_product (user_id, product_id) values ( %s, %s)",( userid[0][0], details['product_id']))	
		db.commit();
		array1.append({"Status": "OK"})
	return jsonify(array1)

@app.route('/preengage', methods=['GET', 'POST'])
def pre_questions():
	
	array1 = []
	array2 = []
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
        	cursor = db.cursor();
        	cursor.execute("Select question_id, question from prequestions")
        	questions = cursor.fetchall()
		for row in questions:
			array1.append({"Question_id": row[0], "Question": row[1]})
		cursor.execute("Select mile_id, milestone from milestone")
                milestones = cursor.fetchall()
		for row in milestones:
                        array2.append({"Milestone_id": row[0], "Milestone": row[1]})
		result = [{"Questionaires" : array1, "Milestones" : array2}]
		cursor.close()
        	return jsonify(result)

@app.route("/logout")
def logout():
    session['logged_in'] = False
    return home()
 
if __name__ == "__main__":
    app.secret_key = os.urandom(12)
    app.run(debug=True,host='0.0.0.0', port=4000)

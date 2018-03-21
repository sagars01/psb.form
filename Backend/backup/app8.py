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
     db = MySQLdb.connect( host, user, password, database)
     cursor = db.cursor()
     cursor.execute("Select is_admin from Login where id = %s",(userid))
     status = cursor.fetchall()
     array = [{"Logged_in" : session.get('logged_in'), "Is_admin" : status[0][0]}]
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
	temp = []
	global product;
	global key_id;
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
		cursor = db.cursor();
		cursor.execute("Select product_id, product_name from product")
		products = cursor.fetchall()
		for row in products:
			cursor.execute("Select version from version where product_id = %s", (row[0],))
			version = cursor.fetchall()
			for row1 in version:
				temp.append(row1[0]) 				
			array1.append({"Product_id": row[0], "Product": row[1], "Versions" : temp})
			temp = []
		cursor.close()
	elif request.method == 'POST':
		db = MySQLdb.connect( host, user, password, database)
		cursor = db.cursor()
		details = request.get_json(force=True)
		count = cursor.execute("Select * from map_user_to_product where user_id = %s and product_id = %s",( userid[0][0], details['product_id']))
		if count == 0:
			cursor.execute("Insert into map_user_to_product (user_id, product_id) values ( %s, %s)",( userid[0][0], details['product_id']))	
		product = details['product_id']
		db.commit()
		cursor.execute("Select key_id from map_user_to_product where user_id = %s and product_id = %s",( userid[0][0], product))
		key_id = cursor.fetchall()
		array1.append({"Status": "OK"})
	return jsonify(array1)

@app.route('/registerproduct', methods=['POST'])
def product_register():
	db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
        details = request.get_json(force=True)
	count = cursor.execute("Select * from product, version where product.product_id = version.product_id and product_name = %s and version = %s",(details['product_name'], details['version']))
	if count == 0:
        	cursor.execute("Insert into product (product_name) values (%s)",(details['product_name'],))
		cursor.execute("Select product_id from product where product_name = %s",(details['product_name'],))
		product = cursor.fetchall()
		cursor.execute("Insert into version (product_id, version)  values (%s, %s)",(product, details['version']))
		db.commit()
		return jsonify({"Status" : "OK"})
	else:
		return jsonify({"Status" : "Exists"})		
        	

@app.route('/preengage', methods=['GET', 'POST'])
def pre_questions():
	
	array1 = []
	array2 = []
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
		cursor = db.cursor();
		count = cursor.execute("Select prequestions.question_id, question, response from prequestions, map_key_to_pre where prequestions.question_id = map_key_to_pre.question_id and key_id = %s", (key_id))
		if count > 0 :
			questions = cursor.fetchall()
			for row in questions:
				array1.append({"Question_id": row[0], "Question": row[1], "Question_response": row[2]})
		else :
			cursor.execute("Select question_id, question from prequestions")
			questions = cursor.fetchall()
			for row in questions:
                                array1.append({"Question_id": row[0], "Question": row[1], "Question_response": "NULL"})
		
		cursor.execute("Select milestone.mile_id, milestone, date from milestone, map_key_to_milestone where milestone.mile_id = map_key_to_milestone.mile_id and key_id = %s", (key_id))
		if count > 0 :
			milestones = cursor.fetchall()
			for row in milestones:
				array2.append({"Milestone_id": row[0], "Milestone": row[1], "Date": row[2]})
		else:
			cursor.execute("Select mile_id, milestone from milestone")
			questions = cursor.fetchall()
			for row in questions:
                                array2.append({"Milestone_id": row[0], "Milestone": row[1], "Date": "NULL"})
		
		result = [{"Questionaires" : array1, "Milestones" : array2}]
		cursor.close()
		return jsonify(result)
	else:
		db = MySQLdb.connect( host, user, password, database)
		cursor = db.cursor()
		details = request.get_json(force=True)
		count = len(details[0]['Questionaires'])
		for index in range (0,count):
			count = cursor.execute("Select * from  map_key_to_pre where question_id = %s and key_id = %s",(details[0]['Questionaires'][index]['Question_id'], key_id[0][0]))
			if count > 0:
				cursor.execute("Update map_key_to_pre set response = %s where question_id = %s and key_id = %s",( details[0]['Questionaires'][index]['Question_response'], details[0]['Questionaires'][index]['Question_id'], key_id[0][0]))
			else:
				cursor.execute("Insert into map_key_to_pre (key_id, response, question_id) values (%s, %s, %s)",( key_id, details[0]['Questionaires'][index]['Question_response'], details[0]['Questionaires'][index]['Question_id']))
				db.commit();

		count = len(details[0]['Milestones'])
		for index in range (0,count):
			count = cursor.execute("Select * from  map_key_to_milestone where mile_id = %s and key_id = %s",(details[0]['Milestones'][index]['Milestone_id'], key_id[0][0]))
                        if count > 0:
				cursor.execute("Update map_key_to_milestone set date = %s where mile_id = %s and key_id = %s",( details[0]['Milestones'][index]['Date'], details[0]['Milestones'][index]['Milestone_id'], key_id[0][0]))
			else:
                                cursor.execute("Insert into map_key_to_milestone (key_id, date, mile_id) values (%s, %s, %s)",( key_id, details[0]['Milestones'][index]['Date'], details[0]['Milestones'][index]['Milestone_id']))
		db.commit()
		cursor.execute("Update map_user_to_product set minutes_of_meeting = %s, Phase_details = %s where user_id = %s and product_id = %s",( details[0]['Mom'], details[0]['Phase_details'],userid[0][0], product))
		db.commit()
		array1.append({"Status": "OK"})
	return jsonify(array1)

@app.route('/psb', methods=['GET', 'POST'])
def psb():

	array1 = []
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
		cursor = db.cursor();
		count = cursor.execute("Select psb.psb_id, req, reason, status, justification from psb, map_key_to_psb where psb.psb_id = map_key_to_psb.psb_id and key_id = %s", (key_id[0][0],))
		if count > 0:
                	questions = cursor.fetchall()
                	for row in questions:
                        	array1.append({"psb_id": row[0], "requirement": row[1], "reason": row[2], "status": row[3], "justification": row[4]})
		else:
			cursor.execute("Select psb_id, req, reason from psb")
			questions = cursor.fetchall()
			for row in questions:
				array1.append({"psb_id": row[0], "requirement": row[1], "reason": row[2], "status": "Yet to be answered", "justification": "NULL"})
			cursor.close()
   
	else:
		db = MySQLdb.connect( host, user, password, database)
		cursor = db.cursor()
		details = request.get_json(force=True)
		count = len(details)
		for index in range (0,count):
			count = cursor.execute("Select * from  map_key_to_psb where psb_id = %s and key_id = %s",( details[index]['psb_id'], key_id[0][0]))
			if count > 0:
				cursor.execute("Update map_key_to_psb set status = %s, justification = %s where psb_id = %s and key_id = %s",( details[index]['status'], details[index]['justification'], details[index]['psb_id'], key_id[0][0]))
			else:
				cursor.execute("Insert into map_key_to_psb (key_id, psb_id, status, justification) values (%s, %s, %s, %s)",( key_id, details[index]['psb_id'], details[index]['status'], details[index]['justification']))
			db.commit();
		array1.append({"Status": "OK"})
	return jsonify(array1)

@app.route("/logout")
def logout():
    session['logged_in'] = False
    return home()
 
if __name__ == "__main__":
    app.secret_key = os.urandom(12)
    app.run(debug=True,host='0.0.0.0', port=4000)

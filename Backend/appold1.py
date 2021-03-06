from flask import Flask, flash, redirect, render_template, request, session, abort, url_for, jsonify, send_file, send_from_directory
from flask_cors import CORS, cross_origin
import MySQLdb
import json
from json2html import *
from xhtml2pdf import pisa
from werkzeug.utils import secure_filename
import os
 
app = Flask(__name__)

CORS(app, support_credentials=True)
host = "localhost"
user = "root"
password = "netapp"
database = "data_db"

@app.route('/')
def home():
     global admin_status, manager_status
     db = MySQLdb.connect( host, user, password, database)
     cursor = db.cursor()
     cursor.execute("Select is_user, is_admin, is_manager , user from Login where id = %s",(userid))
     status = cursor.fetchall()
     admin_status = status[0][1]
     manager_status = status[0][2]
     array = [{ "user" : status[0][3]  ,"Logged_in" : session.get('logged_in'), "Is_user" : status[0][0], "Is_admin" : status[0][1], "Is_manager" : status[0][2]}]
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
			session['logged_in'] = False
		cursor.close()
	return home()

@app.route('/help', methods=['GET'])
def help():

	array1 = []
	array2 = []
	array3 = []
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
		cursor = db.cursor()
		count = cursor.execute("Select * from first_table")
		if count > 0:
			name = cursor.fetchall()
		for row in name:
			array1.append({"id": row[0], "outcome": row[1], "description": row[2], "justification": row[3]})
		count = cursor.execute("Select * from second_table")
		if count > 0:
			name = cursor.fetchall()
		for row in name:
			array2.append({"id": row[0], "language": row[1], "definition": row[2]})
		count = cursor.execute("Select * from third_table")
		if count > 0:
			name = cursor.fetchall()
		for row in name:
			array3.append({"id": row[0], "outcome": row[1], "description": row[2]})
		result = [{"first_table" : array1, "second_table" : array2, "third_table" : array3}]
		cursor.close()
	return jsonify(result)

@app.route('/modifypreengage', methods=['POST'])
def modify_pre():
        db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
        details = request.get_json(force=True)
	if details['action'] == "delete":
		if details['Question_id'] != "":
			cursor.execute("Delete from map_key_to_pre where question_id = %s", (details['Question_id'],))
			cursor.execute("Delete from prequestions where question_id = %s", (details['Question_id'],))
		if details['Milestone_id'] != "":
			cursor.execute("Delete from map_key_to_milestone where mile_id = %s", (details['Milestone_id'],))
			cursor.execute("Delete from milestone where mile_id = %s", (details['Milestone_id'],))

	elif details['action'] == "add":
		if details['Id'] == "":
			if details['Question'] != "":
				cursor.execute("Insert into prequestions (question) values (%s)", (details['Question'],))
				cursor.execute("Select question_id from prequestions where question = %s", (details['Question'],))
				qid = cursor.fetchall()
				cursor.execute("Select distinct(key_id) from map_key_to_pre")
				kid = cursor.fetchall()
				for key in kid:
					cursor.execute("Insert into map_key_to_pre (question_id, key_id) values (%s, %s)", (qid, key[0]))

			if details['Milestone'] != "":
				cursor.execute("Insert into milestone (milestone) values (%s)", (details['Milestone'],))
				cursor.execute("Select mile_id from milestone where milestone = %s", (details['Milestone'],))
				qid = cursor.fetchall()
                                cursor.execute("Select distinct(key_id) from map_key_to_milestone")
                                kid = cursor.fetchall()
                                for key in kid:
                                        cursor.execute("Insert into map_key_to_milestone (mile_id, key_id) values (%s, %s)", (qid, key[0]))
		else:
			if details['Question'] != "":
                                cursor.execute("Update prequestions set question = %s where question_id = %s", (details['Question'], details['Id']))
                        if details['Milestone'] != "":
                                cursor.execute("Update milestone set milestone = %s where mile_id = %s", (details['Milestone'], details['Id']))
	cursor.close()
	db.commit()
	return jsonify({"Status" : "OK"})

@app.route('/modifypsb', methods=['GET', 'POST'])
def modify_psb():
     array1 = []
     if request.method == "POST":
        db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
        details = request.get_json(force=True)
	if details['action'] == "delete":
                if details['Id'] != "":
			cursor.execute("Delete from map_key_to_psb where psb_id = %s", (details['Id'],))
                        cursor.execute("Delete from psb where psb_id = %s", (details['Id'],))

        elif details['action'] == "add" and details['Id'] != "":
		count = cursor.execute("Select * from psb where psb_id = %s", (details['Id'],))
		if details['Requirement'] != "" or details['Reason'] != "":
			if count > 0:
				cursor.execute("Update psb set req = %s, reason = %s where psb_id = %s", (details['Requirement'], details['Reason'], details['Id']))
			else:
                		cursor.execute("Insert into psb (psb_id, req, reason) values (%s, %s, %s)", (details['Id'], details['Requirement'],details['Reason']))
				cursor.execute("Select distinct(key_id) from map_key_to_psb")
                                kid = cursor.fetchall()
                                for key in kid:
                                        cursor.execute("Insert into map_key_to_psb (psb_id, key_id) values (%s, %s)", (details['Id'], key[0]))
	cursor.close()
	db.commit()
	return jsonify({"Status" : "OK"})
	
     else:
	db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
	cursor.execute("Select * from psb")
	temp = cursor.fetchall()
	for row in temp:
		array1.append({"psb_id": row[0], "requirement": row[1], "reason": row[2]});
	cursor.close()
     	return jsonify(array1)

@app.route('/modifyhelp', methods=['POST'])
def modify_help():
        db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
        details = request.get_json(force=True)
	if details['action'] == "delete" and details['Id'] != "":
                if details['Table'] == "first_table":
                        cursor.execute("Delete from first_table where key_id = %s", (details['Id'],))
		elif details['Table'] == "second_table":
                        cursor.execute("Delete from second_table where key_id = %s", (details['Id'],))
		elif details['Table'] == "third_table":
                        cursor.execute("Delete from third_table where key_id = %s", (details['Id'],))

        elif details['action'] == "add":
                if details['Table'] == "first_table" and details['Outcome'] != "":
                        cursor.execute("Insert into first_table (outcome, description, justification) values (%s, %s, %s)", (details['Outcome'], details['Description'],details['Justification']))
		elif details['Table'] == "second_table" and details['Language'] != "":
                        cursor.execute("Insert into first_table (language, defination) values (%s, %s)", (details['Language'], details['Definition']))
		elif details['Table'] == "third_table" and details['Outcome'] != "":
                        cursor.execute("Insert into third_table (outcome, description) values (%s, %s)", (details['Outcome'], details['Description']))
	db.commit()
        cursor.close()
	return jsonify({"Status" : "OK"})

@app.route('/manage', methods=['POST'])
def manage():
        db = MySQLdb.connect( host, user, password, database)
	cursor = db.cursor()
	details = request.get_json(force=True)
	if details['isApproved'] == 'true':
		for ids in details['psb_id']:
			cursor.execute("Update map_key_to_psb set manager_response = 'approved' where psb_id = %s and key_id = %s", (ids, key_id))
	else:
		for ids in details['psb_id']:
                        cursor.execute("Update map_key_to_psb set manager_response = 'rejected' where psb_id = %s and key_id = %s", (ids, key_id)) 
	db.commit()
	cursor.close()
	return jsonify({"Status" : "OK"})	

@app.route('/poc', methods=['GET','POST'])
def poc():
    if request.method == 'POST':
	db = MySQLdb.connect( host, user, password, database)
      	cursor = db.cursor()
        details = request.get_json(force=True)
	
	for names in details['product_engineer']:
		count = cursor.execute("Select * from Login where user = %s", (names,));
		if count == 0:
			cursor.execute ( "Insert into Login (user, is_admin, is_manager, is_user) values (%s, %s, %s, %s)",(names, 0 , 0, 1));
			db.commit()
		cursor.execute("Select id from Login where user = %s", (names,));
		added_user = cursor.fetchall()
		count = cursor.execute("Select * from map_user_to_product where user_id = %s and version_id = %s", (added_user, key_id))
		if count == 0:
			cursor.execute ( "Insert into map_user_to_product (user_id, version_id) values (%s, %s)",(added_user, key_id));

	for names in details['sdl_engineer']:
		count = cursor.execute("Select * from Login where user = %s", (names,));
                if count == 0:
			cursor.execute ( "Insert into Login (user, is_admin, is_manager, is_user) values (%s, %s, %s, %s)",(names, 1 , 0, 0));
			db.commit()
		cursor.execute("Select id from Login where user = %s", (names,));
		added_user = cursor.fetchall()
		count = cursor.execute("Select * from map_user_to_product where user_id = %s and version_id = %s", (added_user, key_id))
                if count == 0:
                	cursor.execute ( "Insert into map_user_to_product (user_id, version_id) values (%s, %s)",(added_user, key_id));

	for names in details['manager']:
		count = cursor.execute("Select * from Login where user = %s", (names,));
                if count == 0:
			cursor.execute ( "Insert into Login (user, is_admin, is_manager, is_user) values (%s, %s, %s, %s)",(names, 0 , 1, 0));
			db.commit()
		cursor.execute("Select id from Login where user = %s", (names,));
		added_user = cursor.fetchall()
		count = cursor.execute("Select * from map_user_to_product where user_id = %s and version_id = %s", (added_user, key_id))
                if count == 0:
                	cursor.execute ( "Insert into map_user_to_product (user_id, version_id) values (%s, %s)",(added_user, key_id));

	db.commit()
	cursor.close()

    else:
	user_list = []
	admin = []
	manager = []
	db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
        cursor.execute("Select user, is_admin, is_manager, is_user from Login where id in (Select user_id from map_user_to_product where version_id = %s)", (key_id))
	poc = cursor.fetchall()
	for row in poc:
		if row[3] == 1:
			user_list.append(row[0])
		elif row[1] == 1:
			admin.append(row[0])
		elif row[2] == 1:
			manager.append(row[0])
	cursor.execute("Select product_name from product where product_id = %s", (product,));
	prod = cursor.fetchall()
	cursor.execute("Select version from version where version_id = %s", (key_id,));
	vers = cursor.fetchall() 
	cursor.close()
	return jsonify({"product_engineer" : user_list, "sdl_engineer" : admin, "manager" : manager, "Product" : prod[0][0], "Version" : vers[0][0]})
	
@app.route('/welcome', methods=['GET', 'POST'])
def product_select():
	array1 = []
	temp = []
	global product;
	global key_id;
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
		cursor = db.cursor();
		cursor.execute("Select product.product_id, product_name, version from product, version, map_user_to_product where version.version_id = map_user_to_product.version_id and product.product_id = version.product_id and map_user_to_product.user_id = %s", (userid))
                products = cursor.fetchall()
                for rows in products:
                        array1.append({"Product_id": rows[0], "Product": rows[1], "Version" : rows[2]})
		cursor.close()

	elif request.method == 'POST':
		db = MySQLdb.connect( host, user, password, database)
		cursor = db.cursor()
		details = request.get_json(force=True)
		count = cursor.execute("Select version_id from version where version = %s and product_id = %s",(details['version'], details['product_id']))
		key_id = cursor.fetchall()
		product = details['product_id']
		array1.append({"Status": "OK"})
		cursor.close()
	return jsonify(array1)

@app.route('/registerproduct', methods=['POST'])
def product_register():
	db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
        details = request.get_json(force=True)
	count = cursor.execute("Select * from product, version where product.product_id = version.product_id and product_name = %s and version = %s",(details['product_name'], details['version']))
	if count == 0:
		count_row = cursor.execute("Select product_id from product where product_name = %s",(details['product_name'],))
        	if count_row == 0:
			cursor.execute("Insert into product (product_name) values (%s)",(details['product_name'],))
			db.commit()
		cursor.execute("Select product_id from product where product_name = %s",(details['product_name'],))
		product = cursor.fetchall()
		cursor.execute("Insert into version (product_id, version)  values (%s, %s)",(product, details['version']))
		db.commit()
		cursor.close()
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

		cursor.execute("Select minutes_of_meeting, Phase_details from version where version_id = %s", (key_id))
		extra = cursor.fetchall()
		
		result = [{"Questionaires" : array1, "Milestones" : array2, "Mom" : extra[0][0], "Phase_details" : extra[0][1]}]
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
		cursor.execute("Update version set minutes_of_meeting = %s, Phase_details = %s where  version_id = %s",( details[0]['Mom'], details[0]['Phase_details'], key_id[0][0]))
		db.commit()
		array1.append({"Status": "OK"})
		cursor.close()
	return jsonify(array1)

@app.route('/downloadpsb', methods=['GET'])
def download_psb():
	
	array1 = []
        db = MySQLdb.connect(host, user, password, database)
        cursor = db.cursor();
        count = cursor.execute("Select psb.psb_id, req, reason, status, justification from psb, map_key_to_psb where psb.psb_id = map_key_to_psb.psb_id and key_id = %s and manager_response = 'approved'", (key_id[0][0],))
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
	array1 = json.dumps(array1)
	data = json.loads(array1)
	data = json2html.convert(json = data)
	resultFile = open("html.pdf", "w+b")
	pisaStatus = pisa.CreatePDF(data, dest=resultFile)
	resultFile.close()             
	return send_file('html.pdf', attachment_filename='psb_form.pdf')

@app.route('/uploader', methods = ['GET', 'POST'])
def upload_file():
   if request.method == 'POST':
      files = request.files['file']
      filename = secure_filename(files.filename)
      files.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
      db = MySQLdb.connect(host, user, password, database)
      cursor = db.cursor();
      count = cursor.execute("Select * from file_table where key_id = %s", (key_id[0][0],))
      if count == 0 :
	cursor.execute("Insert into file_table (key_id, file_name) values (%s, %s)", (key_id[0][0], filename))
      else:
	cursor.execute("Update file_table set file_name = %s where key_id = %s", (filename, key_id[0][0]))
      db.commit()
      cursor.close()
      return jsonify({ "Status" : "file uploaded successfully"})

   elif request.method == 'GET':
      db = MySQLdb.connect(host, user, password, database)
      cursor = db.cursor();
      count = cursor.execute("Select file_name from file_table where key_id = %s", (key_id[0][0],))
      if count > 0:
	filename = cursor.fetchall()
      	return send_from_directory(app.config['UPLOAD_FOLDER'],filename[0][0])
      elif count == 0:
	return jsonify({"Status" : "No file uploaded"}) 

@app.route('/psb', methods=['GET', 'POST'])
def psb():

	array1 = []
	if request.method == 'GET':
		db = MySQLdb.connect(host, user, password, database)
		cursor = db.cursor();
		if admin_status == 1:
			count = cursor.execute("Select psb.psb_id, req, reason, status, justification from psb, map_key_to_psb where psb.psb_id = map_key_to_psb.psb_id and key_id = %s and manager_response = 'approved'", (key_id[0][0],))
			if count == 0:
				return jsonify({"Status" : "PSB not approved"})
			elif count > 0:
				questions = cursor.fetchall()
                                for row in questions:
                                        array1.append({"psb_id": row[0], "requirement": row[1], "reason": row[2], "status": row[3], "justification": row[4]})

                elif manager_status == 1:
                        count = cursor.execute("Select psb.psb_id, req, reason, status, justification from psb, map_key_to_psb where psb.psb_id = map_key_to_psb.psb_id and key_id = %s and manager_response = 'processing'", (key_id[0][0],))
                        if count == 0:
                                return jsonify({"Status" : "Already approved"})
                        elif count > 0:
                                questions = cursor.fetchall()
                                for row in questions:
                                        array1.append({"psb_id": row[0], "requirement": row[1], "reason": row[2], "status": row[3], "justification": row[4]})
			 
		else:
			count = cursor.execute("Select psb.psb_id, req, reason, status, justification ,map_key_to_psb.manager_response from psb, map_key_to_psb where psb.psb_id = map_key_to_psb.psb_id and key_id = %s", (key_id[0][0],))
			if count > 0:
                		questions = cursor.fetchall()
                		for row in questions:
                        		array1.append({"psb_id": row[0], "requirement": row[1], "reason": row[2], "status": row[3], "justification": row[4] , "manager_status": row[5]})
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
		count1 = len(details)
		for index in range (0,count1 - 1):
			count = cursor.execute("Select * from  map_key_to_psb where psb_id = %s and key_id = %s",( details[index]['psb_id'], key_id))
			if count > 0:
				cursor.execute("Update map_key_to_psb set status = %s, justification = %s, manager_response = 'processing' where psb_id = %s and key_id = %s",( details[index]['status'], details[index]['justification'], details[index]['psb_id'], key_id[0][0]))
			else:
				cursor.execute("Insert into map_key_to_psb (key_id, psb_id, status, justification, manager_response) values (%s, %s, %s, %s, 'processing')",( key_id, details[index]['psb_id'], details[index]['status'], details[index]['justification']))
	db.commit();
	array1.append({"Status": "OK"})
	cursor.close()
	return jsonify(array1)

@app.route("/draft", methods=['POST'])
def draft():
	array1 = []
	db = MySQLdb.connect( host, user, password, database)
        cursor = db.cursor()
        details = request.get_json(force=True)
        count1 = len(details)
        for index in range (0,count1 - 1):
                        count = cursor.execute("Select * from  map_key_to_psb where psb_id = %s and key_id = %s",( details[index]['psb_id'], key_id))
                        if count > 0:
                                cursor.execute("Update map_key_to_psb set status = %s, justification = %s, manager_response = 'draft' where psb_id = %s and key_id = %s",( details[index]['status'], details[index]['justification'], details[index]['psb_id'], key_id[0][0]))
                        else:
                                cursor.execute("Insert into map_key_to_psb (key_id, psb_id, status, justification, manager_response) values (%s, %s, %s, %s, 'draft')",( key_id, details[index]['psb_id'], details[index]['status'], details[index]['justification']))
        db.commit();
        array1.append({"Status": "OK"})
        cursor.close()
        return jsonify(array1)

@app.route("/logout")
def logout():
    session['logged_in'] = False
    array = {"Logged_in" : session.get('logged_in')}
    return jsonify(array)
 
if __name__ == "__main__":
    app.secret_key = os.urandom(12)
    app.config['UPLOAD_FOLDER'] = "uploads"
    app.run(debug=True,threaded=True,host='0.0.0.0', port=4000)


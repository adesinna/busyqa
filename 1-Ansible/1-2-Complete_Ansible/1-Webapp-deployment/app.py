from flask import Flask
import MySQLdb
import os

app = Flask(__name__)

# Database configuration
db_host = os.getenv('DB_HOST', 'localhost')
db_port = int(os.getenv('DB_PORT', 3306))
db_name = os.getenv('DB_NAME', 'employee_db')
db_user = os.getenv('DB_USER', 'db_user')
db_password = os.getenv('DB_PASSWORD', 'Passw0rd')

@app.route('/')
def index():
    try:
        conn = MySQLdb.connect(host=db_host, port=db_port, user=db_user, passwd=db_password, db=db_name)
        return 'Database connection successful!'
    except MySQLdb.Error as e:
        return f'Error: {e}'

if __name__ == '__main__':
    app.run(host='0.0.0.0')

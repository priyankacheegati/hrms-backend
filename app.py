from flask import Flask, render_template, request, redirect, url_for, session, jsonify, send_file
import mysql.connector
import datetime
import os
from werkzeug.utils import secure_filename
from io import BytesIO
from xhtml2pdf import pisa

app = Flask(__name__)
app.secret_key = "supersecretkey"

# ------------------- FILE UPLOAD CONFIG -------------------
UPLOAD_FOLDER = 'static/uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# ------------------- MYSQL CONNECTION HELPER -------------------
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="hr_db"
    )

# ------------------- AUTH -------------------
@app.route('/')
def home():
    return render_template('main.html')

@app.route('/signinpage')
def signinpage():
    return render_template('signin.html')

@app.route('/signin', methods=['POST'])
def signin():
    email = request.form['email']
    password = request.form['password']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, name, email, role FROM users WHERE email=%s AND password=%s",
                   (email, password))
    user = cursor.fetchone()
    conn.close()

    if not user:
        return "Invalid email or password"

    session['user'] = {'id': user[0], 'name': user[1], 'email': user[2], 'role': user[3]}

    role_redirect = {
        'manager': 'manager',
        'employee': 'employee',
        'hr': 'hr',
        'admin': 'admin'
    }
    return redirect(url_for(role_redirect.get(user[3].lower(), 'home')))

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('signinpage'))

# ------------------- PAGES -------------------
@app.route('/employee')
def employee():
    if 'user' not in session:
        return redirect(url_for('signinpage'))
    if session['user']['role'].lower() != 'employee':
        return "Unauthorized", 403
    return render_template('employee.html', user=session['user'])

@app.route('/manager')
def manager():
    if 'user' not in session:
        return redirect(url_for('signinpage'))
    return render_template('manager.html', user=session['user'])

@app.route('/hr')
def hr():
    if 'user' not in session:
        return redirect(url_for('signinpage'))
    return render_template('hr.html', user=session['user'])

@app.route('/admin')
def admin():
    if 'user' not in session:
        return redirect(url_for('signinpage'))
    return render_template('admin.html', user=session['user'])

# ------------------- EMPLOYEE ATTENDANCE -------------------
@app.route('/mark_attendance', methods=['POST'])
def mark_attendance():
    if 'user' not in session:
        return "Not logged in", 401

    user_id = session['user']['id']
    today = datetime.date.today()
    if today.weekday() == 6:
        return jsonify({"message": "Today is a holiday (Sunday)."}), 400

    status = request.json.get('status')
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id FROM attendance WHERE user_id=%s AND date=%s", (user_id, today))
    already = cursor.fetchone()
    if already:
        conn.close()
        return jsonify({"message": "Attendance already marked for today."})

    cursor.execute("INSERT INTO attendance (user_id, date, status) VALUES (%s, %s, %s)",
                   (user_id, today, status))
    conn.commit()
    conn.close()
    return jsonify({"message": "Attendance marked successfully."})

@app.route('/attendance_summary')
def attendance_summary():
    if 'user' not in session:
        return "Not logged in", 401

    user_id = session['user']['id']
    today = datetime.date.today()
    first_day = today.replace(day=1)

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT status, COUNT(*) as count
        FROM attendance
        WHERE user_id=%s AND date BETWEEN %s AND %s
        GROUP BY status
    """, (user_id, first_day, today))
    rows = cursor.fetchall()
    conn.close()

    summary = {"Present": 0, "Absent": 0, "Leave": 0}
    for r in rows:
        summary[r['status']] = r['count']

    return jsonify(summary)

# ------------------- USER DATA -------------------
@app.route('/api/users')
def api_users():
    if 'user' not in session:
        return jsonify({"message": "Not logged in"}), 401

    current_user = session['user']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if current_user['role'].lower() in ['admin', 'hr', 'manager']:
        cursor.execute("""
            SELECT id, name, email, role, phone, country, image, status
            FROM users
            WHERE role != 'admin'
        """)
    else:
        cursor.execute("""
            SELECT id, name, email, role, phone, country, image, status
            FROM users
            WHERE id=%s
        """, (current_user['id'],))
    users = cursor.fetchall()
    cursor.close()
    conn.close()

    for u in users:
        if u['image']:
            u['image'] = url_for('static', filename=f'uploads/{u["image"]}')
        else:
            u['image'] = url_for('static', filename='images/default.png')
    return jsonify(users)

# ------------------- EMPLOYEES LIST -------------------
@app.route('/api/employees')
def api_employees():
    if 'user' not in session:
        return jsonify({"message": "Not logged in"}), 401

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name FROM users WHERE role != 'admin'")
    employees = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(employees)

# ------------------- PAYROLL API -------------------
@app.route('/api/payroll', methods=['GET', 'POST'])
def api_payroll():
    if 'user' not in session:
        return jsonify({"message": "Not logged in"}), 401
    if session['user']['role'].lower() not in ['admin', 'hr']:
        return jsonify({"message": "Permission denied"}), 403

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if request.method == 'GET':
        cursor.execute("""
            SELECT p.id, u.name, p.month, p.basic, p.bonus, p.total, p.status
            FROM payroll p
            JOIN users u ON p.user_id = u.id
            ORDER BY p.month DESC
        """)
        payrolls = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(payrolls)

    elif request.method == 'POST':
        data = request.get_json()
        user_id = data.get('user_id')
        month = data.get('month')
        basic = float(data.get('basic', 0))
        bonus = float(data.get('bonus', 0))
        total = basic + bonus

        cursor.execute("""
            INSERT INTO payroll (user_id, month, basic, bonus, total, status)
            VALUES (%s, %s, %s, %s, %s, 'Pending')
        """, (user_id, month, basic, bonus, total))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"message": "Payroll added successfully"})

@app.route('/api/payroll/<int:payroll_id>', methods=['DELETE'])
def delete_payroll(payroll_id):
    if 'user' not in session:
        return jsonify({"message": "Not logged in"}), 401
    if session['user']['role'].lower() not in ['admin', 'hr']:
        return jsonify({"message": "Permission denied"}), 403

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM payroll WHERE id=%s", (payroll_id,))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Payroll deleted successfully"})

@app.route('/api/payroll_status/<int:payroll_id>', methods=['POST'])
def update_payroll_status(payroll_id):
    if 'user' not in session:
        return jsonify({"message": "Not logged in"}), 401
    if session['user']['role'].lower() not in ['admin', 'hr']:
        return jsonify({"message": "Permission denied"}), 403

    status = request.json.get('status')
    if status not in ['Pending', 'Paid']:
        return jsonify({"message": "Invalid status"}), 400

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE payroll SET status=%s WHERE id=%s", (status, payroll_id))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Payroll status updated successfully"})

# ------------------- EMPLOYEE OWN PAYROLL -------------------
@app.route('/api/my_payroll')
def my_payroll():
    if 'user' not in session:
        return jsonify({"message": "Not logged in"}), 401
    if session['user']['role'].lower() != 'employee':
        return jsonify({"message": "Permission denied"}), 403

    user_id = session['user']['id']
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT month, basic, bonus, total, status
        FROM payroll
        WHERE user_id=%s
        ORDER BY month DESC
    """, (user_id,))
    payrolls = cursor.fetchall()
    cursor.close()
    conn.close()

    return jsonify(payrolls)

# ------------------- PAYSLIP DOWNLOAD -------------------
@app.route('/download_payslip/<int:payroll_id>')
def download_payslip(payroll_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT p.*, u.name, u.role as designation, d.name as department, u.join_date
        FROM payroll p
        JOIN users u ON p.user_id = u.id
        LEFT JOIN departments d ON u.department_id = d.id
        WHERE p.id = %s
    """, (payroll_id,))
    record = cursor.fetchone()
    cursor.close()
    conn.close()

    if not record:
        return "Payslip not found", 404

    emp = {
        "id": record['user_id'],
        "name": record['name'],
        "designation": record['designation'],
        "department": record['department'] or "N/A",
        "joining_date": record['join_date']
    }
    salary = {
        "month": record['month'],
        "year": datetime.date.today().year,
        "basic": record['basic'],
        "bonus": record['bonus'],
        "total": record['total'],
        "status": record['status'],
        "deductions": 0,
        "gross": record['total'],
        "total_deductions": 0,
        "net": record['total']
    }

    html = render_template("payslip_template.html", emp=emp, salary=salary)
    pdf = BytesIO()
    pisa.CreatePDF(html, dest=pdf)
    pdf.seek(0)
    return send_file(pdf, as_attachment=True, download_name=f"{emp['name']}_payslip.pdf")

# ------------------- RUN APP -------------------
if __name__ == '__main__':
    app.run(debug=True)

import webbrowser
import threading
from flask import Flask, request, render_template_string
import pymysql

# 创建 Flask 应用
app = Flask(__name__)

# 连接 MySQL
def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='rootpassword',
        database='my_database',
        charset='utf8mb4'
    )

# 首页路由
@app.route('/', methods=['GET', 'POST'])
def index():
    result = ''
    query_result = None

    if request.method == 'POST':
        sql = request.form['sql']
        conn = get_connection()
        try:
            with conn.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute(sql)
                if sql.strip().lower().startswith('select'):
                    query_result = cursor.fetchall()
                else:
                    conn.commit()
                    result = f'执行成功: {cursor.rowcount} 行受影响'
        except Exception as e:
            result = '错误: ' + str(e)
        finally:
            conn.close()

    # HTML 模板
    html = '''
    <html>
    <head>
        <title>SQL 执行页面</title>
        <style>
            body {
                background-color: #121212;
                color: #e0e0e0;
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            textarea {
                width: 100%;
                background-color: #1e1e1e;
                color: #e0e0e0;
                border: 1px solid #333;
                border-radius: 5px;
                padding: 10px;
            }
            input[type="submit"] {
                background-color: #6200ea;
                color: white;
                border: none;
                padding: 10px 20px;
                margin-top: 10px;
                border-radius: 5px;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #3700b3;
            }
            .result {
                margin-top: 20px;
                font-weight: bold;
            }
            .table-container {
                max-height: 400px;
                overflow: auto;
                margin-top: 20px;
                border: 1px solid #333;
                border-radius: 5px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #1e1e1e;
            }
            th, td {
                border: 1px solid #333;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #2c2c2c;
            }
            tr:nth-child(even) {
                background-color: #2a2a2a;
            }
        </style>
    </head>
    <body>
        <h1>🛠️ SQL 执行界面</h1>
        <form method="post">
            <textarea name="sql" rows="5" placeholder="输入你的 SQL 语句..." required>{{ request.form.get('sql', '') }}</textarea><br>
            <input type="submit" value="执行">
        </form>

        <div class="result">
            {% if result %}
                {% if "错误:" in result %}
                    <div style="color: #ff6b6b;">{{ result }}</div>
                {% else %}
                    <div style="color: #00e676;">{{ result }}</div>
                {% endif %}
            {% endif %}
        </div>

        {% if query_result %}
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            {% for col in query_result[0].keys() %}
                                <th>{{ col }}</th>
                            {% endfor %}
                        </tr>
                    </thead>
                    <tbody>
                        {% for row in query_result %}
                            <tr>
                                {% for cell in row.values() %}
                                    <td>{{ cell }}</td>
                                {% endfor %}
                            </tr>
                        {% endfor %}
                    </tbody>
                </table>
            </div>
        {% endif %}
    </body>
    </html>
    '''
    return render_template_string(html, result=result, query_result=query_result)

# 自动打开浏览器
def open_browser():
    webbrowser.open('http://127.0.0.1:5000')

# 主程序入口
if __name__ == '__main__':
    threading.Timer(1.5, open_browser).start()
    app.run(debug=True)

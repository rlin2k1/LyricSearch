import psycopg2
import re
import string
import sys

try:
    conn = psycopg2.connect("dbname='searchengine' user='cs143' host='localhost' password='cs143'")
    print("CONNECTED TO DATABASE")
except:
    print("UNABLE TO CONNECT TO DATABASE")

cur = conn.cursor()

cur.execute("""SELECT * FROM songs""")
rows = cur.fetchall()

for row in rows:
    print(row)
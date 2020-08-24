```python
import sqlite3
import pandas as pd
import mysql.connector
from mysql.connector import Error
```


```python
def create_connection(host_name, user_name, user_password):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password
        )
        print("Connection to MySQL DB successful")
    except Error as e:
        print(f"The error '{e}' occurred")

    return connection
```


```python
host = "relational.fit.cvut.cz"
user = "guest"
pwd = "relational"
connection = create_connection(host_name = host, user_name =user ,user_password = pwd)
```


```python
query = """SELECT
                A.emp_no,
                A.first_name,
                A.last_name,
                B.title,
                B.from_date,
                B.to_date,
                C.salary
         FROM employee.employees A  
         LEFT JOIN employee.titles B on A.emp_no = B.emp_no
         LEFT JOIN employee.salaries C on C.emp_no = B.emp_no
         WHERE A.emp_no = 12557
"""
ejercicio1 = pd.read_sql(query,connection)
ejercicio1
```


```python
con = sqlite3.connect("sql-murder-mystery.db")
c = con.cursor()
```


```python
def create_connection(db_file):
    con = None
    try:
        con = sqlite3.connect(db_file)
    except Error as e:
        print (e)
            
    return con
```


```python
create_connection("sql-murder-mystery.db")
```




    <sqlite3.Connection at 0x1f2d557f5d0>




```python
pd.set_option('display.max_colwidth', None)
qfecha = "SELECT * FROM crime_scene_report WHERE date = 20180115 AND type = 'murder' AND city = 'SQL City';"
informe = pd.read_sql(qfecha,con)
informe
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>date</th>
      <th>type</th>
      <th>description</th>
      <th>city</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>20180115</td>
      <td>murder</td>
      <td>Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".</td>
      <td>SQL City</td>
    </tr>
  </tbody>
</table>
</div>




```python
witness1 = pd.read_sql("SELECT * FROM person WHERE address_street_name = 'Northwestern Dr' ORDER BY address_number DESC LIMIT 1;",con)
witness1
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>license_id</th>
      <th>address_number</th>
      <th>address_street_name</th>
      <th>ssn</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>14887</td>
      <td>Morty Schapiro</td>
      <td>118009</td>
      <td>4919</td>
      <td>Northwestern Dr</td>
      <td>111564949</td>
    </tr>
  </tbody>
</table>
</div>




```python
Annabel = pd.read_sql("SELECT * FROM person WHERE name LIKE 'Annabel %';",con)
Annabel
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>license_id</th>
      <th>address_number</th>
      <th>address_street_name</th>
      <th>ssn</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16371</td>
      <td>Annabel Miller</td>
      <td>490173</td>
      <td>103</td>
      <td>Franklin Ave</td>
      <td>318771143</td>
    </tr>
  </tbody>
</table>
</div>




```python
Interview1 = pd.read_sql("SELECT transcript FROM interview WHERE person_id IN (SELECT id FROM person WHERE address_street_name = 'Northwestern Dr' ORDER BY address_number DESC LIMIT 1) ;",con)
Interview1
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>transcript</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".</td>
    </tr>
  </tbody>
</table>
</div>




```python
Interview2 = pd.read_sql("SELECT * FROM interview WHERE person_id IN (SELECT id FROM person WHERE name LIKE 'Annabel %');",con)
Interview2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>person_id</th>
      <th>transcript</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16371</td>
      <td>I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.</td>
    </tr>
  </tbody>
</table>
</div>




```python
Lead1 = pd.read_sql("SELECT * FROM person WHERE license_id IN (SELECT id FROM drivers_license WHERE plate_number LIKE '%H42W%') AND id IN (SELECT person_id FROM get_fit_now_member WHERE id LIKE '48Z%' AND membership_status = 'gold');",con)
Lead1
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>license_id</th>
      <th>address_number</th>
      <th>address_street_name</th>
      <th>ssn</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>67318</td>
      <td>Jeremy Bowers</td>
      <td>423327</td>
      <td>530</td>
      <td>Washington Pl, Apt 3A</td>
      <td>871539279</td>
    </tr>
  </tbody>
</table>
</div>




```python
Lead2 = pd.read_sql("SELECT * FROM person WHERE id IN(SELECT person_id FROM get_fit_now_member WHERE id IN(SELECT membership_id FROM get_fit_now_check_in WHERE check_in_date = 20180109));",con)
Lead2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>license_id</th>
      <th>address_number</th>
      <th>address_street_name</th>
      <th>ssn</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>10815</td>
      <td>Adriane Pelligra</td>
      <td>952073</td>
      <td>948</td>
      <td>Emba Ave</td>
      <td>243639527</td>
    </tr>
    <tr>
      <th>1</th>
      <td>15247</td>
      <td>Shondra Ledlow</td>
      <td>108978</td>
      <td>2906</td>
      <td>Chuck Dr</td>
      <td>492143109</td>
    </tr>
    <tr>
      <th>2</th>
      <td>16371</td>
      <td>Annabel Miller</td>
      <td>490173</td>
      <td>103</td>
      <td>Franklin Ave</td>
      <td>318771143</td>
    </tr>
    <tr>
      <th>3</th>
      <td>28073</td>
      <td>Zackary Cabotage</td>
      <td>402017</td>
      <td>3823</td>
      <td>S Winthrop Ave</td>
      <td>367741547</td>
    </tr>
    <tr>
      <th>4</th>
      <td>28819</td>
      <td>Joe Germuska</td>
      <td>173289</td>
      <td>111</td>
      <td>Fisk Rd</td>
      <td>138909730</td>
    </tr>
    <tr>
      <th>5</th>
      <td>31523</td>
      <td>Blossom Crescenzo</td>
      <td>737886</td>
      <td>1245</td>
      <td>Ruxshire St</td>
      <td>753962462</td>
    </tr>
    <tr>
      <th>6</th>
      <td>55662</td>
      <td>Sarita Bartosh</td>
      <td>556026</td>
      <td>1031</td>
      <td>Legacy Pointe Blvd</td>
      <td>564780417</td>
    </tr>
    <tr>
      <th>7</th>
      <td>67318</td>
      <td>Jeremy Bowers</td>
      <td>423327</td>
      <td>530</td>
      <td>Washington Pl, Apt 3A</td>
      <td>871539279</td>
    </tr>
    <tr>
      <th>8</th>
      <td>83186</td>
      <td>Burton Grippe</td>
      <td>915564</td>
      <td>484</td>
      <td>Lemcrow Way</td>
      <td>426280783</td>
    </tr>
    <tr>
      <th>9</th>
      <td>92736</td>
      <td>Carmen Dimick</td>
      <td>890722</td>
      <td>2965</td>
      <td>Kilmaine Circle</td>
      <td>622279052</td>
    </tr>
  </tbody>
</table>
</div>




```python
conclusion = pd.read_sql("SELECT * FROM person WHERE id IN(SELECT person_id FROM get_fit_now_member WHERE id IN(SELECT membership_id FROM get_fit_now_check_in WHERE check_in_date = 20180109)) AND id IN (SELECT id FROM person WHERE license_id IN (SELECT id FROM drivers_license WHERE plate_number LIKE '%H42W%') AND id IN (SELECT person_id FROM get_fit_now_member WHERE id LIKE '48Z%' AND membership_status = 'gold'));",con)
conclusion
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>license_id</th>
      <th>address_number</th>
      <th>address_street_name</th>
      <th>ssn</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>67318</td>
      <td>Jeremy Bowers</td>
      <td>423327</td>
      <td>530</td>
      <td>Washington Pl, Apt 3A</td>
      <td>871539279</td>
    </tr>
  </tbody>
</table>
</div>




```python
sql = "INSERT INTO solution VALUES (1, 'Jeremy Bowers')"
c.execute(sql)
con.commit()
var = pd.read_sql("SELECT value FROM solution", con)
var.iloc[0,0]
```




    "Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villian behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer."




```python
interview_final = pd.read_sql("SELECT transcript FROM interview WHERE person_id = 67318;",con)
interview_final
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>transcript</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.\n</td>
    </tr>
  </tbody>
</table>
</div>




```python
Lead_villian = pd.read_sql("SELECT * FROM person WHERE license_id IN(SELECT id FROM drivers_license WHERE gender = 'female' AND height BETWEEN 65 AND 67 AND hair_color = 'red' AND car_make = 'Tesla' AND car_model = 'Model S') AND id IN (SELECT person_id FROM facebook_event_checkin WHERE event_name = 'SQL Symphony Concert' AND date LIKE '201712%');",con)
Lead_villian
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>license_id</th>
      <th>address_number</th>
      <th>address_street_name</th>
      <th>ssn</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>99716</td>
      <td>Miranda Priestly</td>
      <td>202298</td>
      <td>1883</td>
      <td>Golden Ave</td>
      <td>987756388</td>
    </tr>
  </tbody>
</table>
</div>




```python
sql = "INSERT INTO solution VALUES (1, 'Miranda Priestly')"
c.execute(sql)
con.commit()
var = pd.read_sql("SELECT value FROM solution", con)
var.iloc[0,0]
```




    'Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!'




```python

```

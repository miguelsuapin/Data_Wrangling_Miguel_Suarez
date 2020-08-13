```python
import numpy as np
import pandas as pd
heroes = pd.read_csv(r"C:\Users\migue\OneDrive\Escritorio\UFM INGENIERIA\6to Semestre\Data Wrangling\heroes_information.csv")
from pandasql import *
```


```python
pysqldf = lambda q: sqldf(q,globals())
```


```python
q1 = " SELECT name FROM heroes LIMIT 1"
pysqldf(q1)
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
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>A-Bomb</td>
    </tr>
  </tbody>
</table>
</div>




```python
q2 = " SELECT COUNT(distinct(Publisher)) FROM heroes"
pysqldf(q2)
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
      <th>COUNT(distinct(Publisher))</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>24</td>
    </tr>
  </tbody>
</table>
</div>




```python
q3 = " SELECT COUNT(name) FROM heroes WHERE Height > 200"
pysqldf(q3)
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
      <th>COUNT(name)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>59</td>
    </tr>
  </tbody>
</table>
</div>




```python
q4 = " SELECT COUNT(name) FROM heroes WHERE Race = 'Human' AND Height > 200"
pysqldf(q4)
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
      <th>COUNT(name)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>




```python
q5 = " SELECT COUNT(name) FROM heroes WHERE Weight  BETWEEN 100 AND 200"
pysqldf(q5)
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
      <th>COUNT(name)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>98</td>
    </tr>
  </tbody>
</table>
</div>




```python
q6 = " SELECT COUNT(name) FROM heroes WHERE `Eye color` IN ('red','blue')"
pysqldf(q6)
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
      <th>COUNT(name)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>271</td>
    </tr>
  </tbody>
</table>
</div>




```python
q7 = " SELECT COUNT(name) FROM heroes WHERE Race = 'Human' AND `Hair color` = 'Green' OR Race = 'Mutant' AND `Hair color` = 'Green' OR Race = 'Vampire' AND `Hair color` = 'Black'"
pysqldf(q7)
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
      <th>COUNT(name)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
q8 = " SELECT name FROM heroes ORDER BY Race DESC LIMIT 1"
pysqldf(q8)
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
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Solomon Grundy</td>
    </tr>
  </tbody>
</table>
</div>




```python
q9 = " SELECT COUNT(name) FROM heroes GROUP BY Gender"
q92 = pysqldf(q9)
q92 = q92.rename(index = {0 : "NULL", 1 : "Female", 2 : "Male"})
q92
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
      <th>COUNT(name)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>NULL</th>
      <td>29</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>200</td>
    </tr>
    <tr>
      <th>Male</th>
      <td>505</td>
    </tr>
  </tbody>
</table>
</div>




```python
q10 = "SELECT COUNT(Publisher) FROM heroes GROUP BY Publisher HAVING count(name) > 15"
pysqldf(q10)
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
      <th>COUNT(Publisher)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>215</td>
    </tr>
    <tr>
      <th>1</th>
      <td>18</td>
    </tr>
    <tr>
      <th>2</th>
      <td>388</td>
    </tr>
    <tr>
      <th>3</th>
      <td>19</td>
    </tr>
  </tbody>
</table>
</div>




```python

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    <ipython-input-50-645a00330030> in <module>
    ----> 1 nrow
    

    NameError: name 'nrow' is not defined



```python

```

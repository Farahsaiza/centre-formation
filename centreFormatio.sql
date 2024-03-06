Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 217
Server version: 8.0.36 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| bd_vole            |
| centre_formation   |
| djallabasoft       |
| ecuri              |
| hollywood          |
| information_schema |
| learnsql           |
| library            |
| mysql              |
| performance_schema |
| sakila             |
| storedb            |
| sys                |
| test3              |
| tramway            |
| world              |
+--------------------+
16 rows in set (0.00 sec)

mysql> use centre_formation;
Database changed
mysql> show tables;
+----------------------------+
| Tables_in_centre_formation |
+----------------------------+
| catalogue                  |
| etudiant                   |
| formation                  |
| inscription                |
| session                    |
| specialite                 |
+----------------------------+
6 rows in set (0.01 sec)

mysql> select COUNT(*) AS Nombre_Etudiant from etud
iant;
+-----------------+
| Nombre_Etudiant |
+-----------------+
|               7 |
+-----------------+
1 row in set (0.01 sec)

mysql> desc etudiant;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| numCINEtu     | varchar(15) | NO   | PRI | NULL    |       |
| nomEtu        | varchar(40) | YES  |     | NULL    |       |
| prenomEtu     | varchar(40) | YES  |     | NULL    |       |
| dateNaissance | date        | YES  |     | NULL    |       |
| adressEtu     | varchar(40) | YES  |     | NULL    |       |
| villeEtu      | varchar(20) | YES  |     | NULL    |       |
| niveauEtu     | varchar(40) | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
7 rows in set (0.01 sec)

mysql> select nomEtu,prenomEtu, round (datediff (sysdate(),dateNaissance)/365 , 0) AS Age from etudiant;
+---------------+--------------+------+
| nomEtu        | prenomEtu    | Age  |
+---------------+--------------+------+
| Alami         | Ahmed        |   38 |
| Souni         | Sanaa        |   26 |
| Idrissi Alami | Mohammed     |   28 |
| Boudiaf       | Fatima Zohra |   27 |
| Toumi         | Aicha        |   24 |
| Ben Omar      | Abd Allah    |   34 |
| Ouled thami   | Ali          |   44 |
+---------------+--------------+------+
7 rows in set (0.00 sec)

mysql> desc formation ;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| codeForm       | int         | NO   | PRI | NULL    |       |
| titreFormation | varchar(40) | YES  |     | NULL    |       |
| dureeFormation | int         | YES  |     | NULL    |       |
| prixForm       | int         | YES  |     | NULL    |       |
+----------------+-------------+------+-----+---------+-------+
4 rows in set (0.01 sec)

mysql> select titreFormation AS Formation_Chere from formation
    -> where prixForm (select MAX(prixForm) from formation);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select MAX(prixForm) from formation)' at line 2
mysql>  select titreFormation AS Formation_Chere from formation
    -> where prixForm = (select MAX(prixForm) from formation);
+------------------------+
| Formation_Chere        |
+------------------------+
| Base de données Oracle |
+------------------------+
1 row in set (0.00 sec)

mysql> select titreFormation AS Formation_Moin_Chere from formation
    -> where prixForm = (select MIN(prixForm) from formation);
+----------------------+
| Formation_Moin_Chere |
+----------------------+
| Communication        |
+----------------------+
1 row in set (0.00 sec)

mysql> select SUM(prixForm) AS PRIX_TOTAL from formation;
+------------+
| PRIX_TOTAL |
+------------+
|      23050 |
+------------+
1 row in set (0.00 sec)

mysql> desc session;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| codeSess  | int         | NO   | PRI | NULL    |       |
| nomSess   | varchar(20) | YES  |     | NULL    |       |
| DateDebut | date        | YES  |     | NULL    |       |
| DateFin   | date        | YES  |     | NULL    |       |
| codeform  | int         | YES  | MUL | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
5 rows in set (0.01 sec)

mysql> desc inscription;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| codeSess  | int         | NO   | PRI | NULL    |       |
| numCINEtu | varchar(15) | NO   | PRI | NULL    |       |
| TypeCours | varchar(20) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> select codeSess , COUNT(numCINEtu) AS Nombre_Etudiant
    -> from inscription
    -> group by codeSess;
+----------+-----------------+
| codeSess | Nombre_Etudiant |
+----------+-----------------+
|     1101 |               7 |
|     1201 |               6 |
|     1301 |               1 |
|     1302 |               4 |
|     1401 |               6 |
|     1501 |               7 |
+----------+-----------------+
6 rows in set (0.00 sec)

mysql> select distinct numCINEtu from inscription ;
+-----------+
| numCINEtu |
+-----------+
| AB234567  |
| C0987265  |
| D2356903  |
| F9827363  |
| G5346789  |
| J3578902  |
| Y1234987  |
+-----------+
7 rows in set (0.01 sec)
select numCINEtu , COUNT(*) as nombre_inscription from inscription
    -> group by numCINEtu;
+-----------+--------------------+
| numCINEtu | nombre_inscription |
+-----------+--------------------+
| AB234567  |                  4 |
| C0987265  |                  5 |
| D2356903  |                  5 |
| F9827363  |                  3 |
| G5346789  |                  5 |
| J3578902  |                  4 |
| Y1234987  |                  5 |
+-----------+--------------------+
7 rows in set (0.00 sec)

mysql> select codeSess ,  COUNT(TypeCours) AS Nbr_Inscription_Distan
cielles from inscription
    -> where TypeCours = 'Distanciel' group by codeSess;
+----------+-------------------------------+
| codeSess | Nbr_Inscription_Distancielles |
+----------+-------------------------------+
|     1101 |                             7 |
|     1302 |                             1 |
|     1401 |                             6 |
|     1501 |                             2 |
+----------+-------------------------------+
4 rows in set (0.00 sec)

mysql> select codeSess , COUNT(TypeCours) AS Nbr_Inscription_Presenti
el from inscription
    -> where TypeCours = 'Présentiel'
    -> group by codeSess;
+----------+----------------------------+
| codeSess | Nbr_Inscription_Presentiel |
+----------+----------------------------+
|     1201 |                          6 |
|     1301 |                          1 |
|     1302 |                          3 |
|     1501 |                          5 |
+----------+----------------------------+
4 rows in set (0.00 sec)

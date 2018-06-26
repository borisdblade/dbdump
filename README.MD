Simple script for dumping and importing databases from production to local ENV and vice versa

**Setup:**

Populate ENV variables (see env.example >> .env)

_For easier and automated manipulation populate list files!_

(see /lists/db_list_example >> /lists/db_list and /lists/tr_list_example >> tr_list)

**Usage example:**

 `bash dbdump.sh <db_env> <db_names_separated_by_comma> <db_env>`

**-i** : import dump into second env

**--dt** : drop triggers for import database

**--list** : list of databases to dump and import

**Easy Run**

` bash autorun_dump.sh` 




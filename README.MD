Simple script for dumping and importing databases from production to local ENV and vice versa

<b>Setup:</b><br><br>
Populate ENV variables (see env.example >> .env)

For easier and automated manipulation populate list files!<br> 
(see /lists/db_list_example >> /lists/db_list and /lists/tr_list_example >> tr_list)

<b>Usage example:</b><br><br>
<code> $ bash dbdump.sh <db_env> <db_names_separated_by_comma> <db_env></code>

<b> -i</b> : import dump into second env <br><br>

<b> --dt</b> : drop triggers for import database <br><br>

<b> --list</b> : list of databases to dump and import<br><br>

<b>Easy Run</b>
<code> $ bash autorun_dump.sh </code>




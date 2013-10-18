--
--statements for the perl/COMM
--
--select sum(transaction_amnt) from cs339.comm_to_cand natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? and cmte_pty_affiliation = 'REP';

--select sum(transaction_amnt) from cs339.comm_to_cand natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? and cmte_pty_affiliation = 'DEM';

--select sum(transaction_amnt) from cs339.comm_to_comm natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? and cmte_pty_affiliation = 'REP';

--select sum(transaction_amnt) from cs339.comm_to_comm natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? and cmte_pty_affiliation = 'DEM';

--
--testing statements/COMM
--
select sum(transaction_amnt) from cs339.comm_to_cand natural join cs339.committee_master natural join cs339.cmte_id_to_geo where cmte_pty_affiliation = 'DEM';

select sum(transaction_amnt) from cs339.comm_to_cand natural join cs339.committee_master natural join cs339.cmte_id_to_geo where cmte_pty_affiliation = 'REP';

select sum(transaction_amnt) from cs339.comm_to_comm natural join cs339.committee_master natural join cs339.cmte_id_to_geo where cmte_pty_affiliation = 'DEM';

select sum(transaction_amnt) from cs339.comm_to_comm natural join cs339.committee_master natural join cs339.cmte_id_to_geo where cmte_pty_affiliation = 'REP';

select stddev(transaction_amnt) from cs339.comm_to_comm natural join cs339.committee_master natural join cs339.cmte_id_to_geo where cmte_pty_affiliation = 'REP';

--
--statements for the perl/IND
--
--select sum(transaction_amnt) from cs339.ind_to_geo natural join cs339.individual natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? and cmte_pty_affiliation = 'REP';

--select sum(transaction_amnt) from cs339.ind_to_geo natural join cs339.individual natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? and cmte_pty_affiliation = 'DEM';

--
--testing statements/IND
--
--select sum(transaction_amnt) from cs339.individual natural join cs339.committee_master natural join cs339.ind_to_geo where cmte_pty_affiliation = 'REP';

--select sum(transaction_amnt) from cs339.individual natural join cs339.committee_master natural join cs339.ind_to_geo where cmte_pty_affiliation = 'DEM';

select sum(transaction_amnt), count(transaction_amnt) from cs339.comm_to_cand natural join cs339.cmte_id_to_geo natural join cs339.committee_master where (cycle=1112 or cycle=1314) and (cmte_pty_affiliation='DEM' or cmte_pty_affiliation='D');

--SQL standard deviation function found here
--http://www.techonthenet.com/oracle/functions/stddev.php
--SQL average function found here
--http://www.w3schools.com/sql/sql_func_avg.asp

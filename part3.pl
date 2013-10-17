### @rows is just a place holder, probably want to use some other variable names
### all queries need the lat/long coordinates and the cycle string

  
  ## [COMMITTEE TO CANDIDATE] returns total money and number of transactions within the area for cmte_string during $cycle_string
  ## this operates on the committee to candidate table
  
  ###RED
  eval { 
    @rows = ExecSQL($dbuser, $dbpasswd, "select sum(transaction_amnt), count(transaction_amnt) from cs339.comm_to_cand natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and cmte_pty_affiliation='REP' and latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
  };
  
  
  ###BLUE
  eval { 
    @rows = ExecSQL($dbuser, $dbpasswd, "select sum(transaction_amnt), count(transaction_amnt) from cs339.comm_to_cand natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and cmte_pty_affiliation='Dem' and cmte_pty_affiliation='DEM' and cmte_pty_affiliation='dem' and latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
  };

  ## [COMMITTEE TO INDIVIDUAL] returns total money and number of transactions within the area for cmte_string during $cycle_string
  ## this operates on the committee to committee table
  
  ###RED
  eval { 
    @rows = ExecSQL($dbuser, $dbpasswd, "select sum(transaction_amnt), count(transaction_amnt) from cs339.comm_to_comm natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and cmte_pty_affiliation='REP' and cmte_pty_affiliation='R' and cmte_pty_affiliation='rep' and cmte_pty_affiliation='Rep' and latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
  };

  ###BLUE
  eval { 
    @rows = ExecSQL($dbuser, $dbpasswd, "select sum(transaction_amnt), count(transaction_amnt) from cs339.comm_to_comm natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and cmte_pty_affiliation='d' and cmte_pty_affiliation='Dem' and cmte_pty_affiliation='DEM' and cmte_pty_affiliation='dem' and latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
  };  
  
  ## [INDIVIDUAL CONTRIBUTIONS] returns total money and number of transactions within the area for cmte_string during $cycle_string
  ## this operates on the committee to candidate table

  ###RED
  eval {
	@rows = ExecSQL($dbuser, $dbpasswd, "select sum(transaction_amnt), count(transaction_amnt) from cs339.ind_to_geo natural join cs339.individual natural join cs339.committee_master where ($cycle_string) and cmte_pty_affiliation='REP and cmte_pty_affiliation='R' and cmte_pty_affiliation='rep' and cmte_pty_affiliation='GOP' and latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
};


###BLUE
eval {
	@rows = ExecSQL($dbuser, $dbpasswd, "select sum(transaction_amnt), count(transaction_amnt) from cs339.ind_to_geo natural join cs339.individual natural join cs339.committee_master where ($cycle_string) and cmte_pty_affiliation='Dem' and cmte_pty_affiliation='DEM' and cmte_pty_affiliation='D' and latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
};

## [OPINIONS] returns average, standard deviation, and number of opinions within the area for opinions 
eval {
	@rows = ExecSQL($dbuser, $dbpasswd, "select avg(color), stddev(color), count(color) from rwb_opinions where latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
};
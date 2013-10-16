  eval { 
    @rows = ExecSQL($dbuser, $dbpasswd, "select cmte_pty_affiliation, sum(transaction_amnt) from cs339.comm_to_cand natural join cs339.cmte_id_to_geo natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? group by cmte_pty_affiliation",undef,$latsw,$latne,$longsw,$longne);
  };
  
  eval { 
    @rows = ExecSQL($dbuser, $dbpasswd, "select cmte_pty_affiliation, sum(transaction_amnt) from cs339.comm_to_comm natural join cs339.cmte_id_to_geo natural join cs339.committee_master where($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? group by cmte_pty_affiliation",undef,$latsw,$latne,$longsw,$longne);
  };
  
  eval {
	@rows = ExecSQL($dbuser, $dbpasswd, "select cmte_pty_affiliation, sum(transaction_amnt) from cs339.ind_to_geo natural join cs339.individual natural join cs339.committee_master where ($cycle_string) and latitude>? and latitude<? and longitude>? and longitude<? group by cmte_pty_affiliation",undef,$latsw,$latne,$longsw,$longne);
};

eval {
	@rows = ExecSQL($dbuser, $dbpasswd, "select avg(color), stddev(color) from rwb_opinions where latitude>? and latitude<? and longitude>? and longitude<?",undef,$latsw,$latne,$longsw,$longne);
};

#if rep + dem < tolerance
#extend gps coordinates
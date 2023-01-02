filename t temp;
proc http
/*  url="https://raw.githubusercontent.com/zonination/perceptions/master/probly.csv" */
url = "http://winterolympicsmedals.com/medals.csv"
 method="GET"
 out=t;
run;


/* Tell SAS to allow "nonstandard" names */
options validvarname=any;

/* import to a SAS data set */
proc import
  file=t
  out=work.medals1 replace
  dbms=csv;
run;

proc cas;
  table.dropTable / name="medals1" caslib="casuser" quiet=true;
quit;

data casuser.medals1(promote=yes);
set work.medals1;
run;

proc cas;
  table.dropTable / name="medals" caslib="casuser" quiet=true;
quit;

proc casutil;
  load file=probly
    importoptions=(filetype="csv") casOut="medals" outCaslib="casuser" promote;
run;
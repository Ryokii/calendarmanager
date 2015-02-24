#YouTube-link: https://www.youtube.com/watch?v=A_iYYft3SX8
#Slik kjører man spørringene til My-SQL-databasen med Ruby:
#Først oppretter man forbindelsen igjen:

require 'rubygems'
require 'dbi'

#Oppretter forbindelsen til MySQL-serveren
dbh = DBI.connect('DBI:Mysql:calendar_app','root','passordet')
if dbh
	puts "Databaseforbindelsen er opprettet."
else
	puts "Kunne ikke opprette databaseforbindelsen, sjekk at parameterne er riktige/gyldige."
end

#Her skriver man selve spørringene, for eksempel vil man 
#oppdatere e-mail adressen til en bruker som ønsker dette:

sth = dbh.prepare(UPDATE deltagere SET email = 'ny@emailadresse.com'
WHERE fornavn = 'Mario' AND etternavn = 'Super')

#Så kjører man til slutt spørringen slik:

sth.execute
dbh.disconnect

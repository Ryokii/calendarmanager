#Fungerer med MySQL, etter installasjon av Ruby gems
#Åpne kommandogrensesnittet og skriv inn (uten #)
#gem install dbi
#gem install mysql
#gem install dbd-mysql
#Skriv "gem list" (uten ") for å sjekke installerte gems/pakker
#YouTube-link: https://www.youtube.com/watch?v=2egVyRFA2s8
#Etter "DBI:Mysql:" under skriver man navnet på databasen vår
#som er calendar_app, deretter brukernavnet og passordet.
#Her er koden, husk å kalle begge modulene helt øverst:

require 'rubygems'
require 'dbi'

#Oppretter forbindelsen til MySQL-serveren
databaseforbindelse = DBI.connect('DBI:Mysql:calendar_app','root','passordet')
if databaseforbindelse 
	puts "Databaseforbindelse opprettet."
else 
	puts "Kunne ikke opprette databaseforbindelse, sjekk at parameterne er riktige/gyldige."
end

databaseforbindelse.disconnect

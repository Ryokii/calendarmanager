#Dette er et eksempel på backend (Version 1).
#Dette er altså et eksempel, det er ikke ferdig.
#Vi kan for eksempel bruke variabler og arrays for å overføre 
#de ulike brukerdataene (over SSL/TLS hvis dette er mulig), 
#og vi må lage en frontend som er kompatibelt med dette og 
#Som også er brukervennlig. RegEx er nytting i front end.
#Sikkerheten er også viktig, for å unngå for eksempel SQL-injection.
#For å bedre sikkerheten kan vi for eksempel bruke kompatible 
#SQL-filtreringsfunksjoner (Ruby/Rails) før de sendes til databasen.
#Husk å sjekke at config.force_ssl = true i config-filen til Ruby.

#Manuallink1: http://www.tutorialspoint.com/ruby/ruby_sending_email.htm
#Manuallink2: http://ruby-doc.org//stdlib-2.1.1/libdoc/net/smtp/rdoc/Net/SMTP.html
#Manuallink3: http://guides.rubyonrails.org/security.html

#!/usr/bin/ruby

require 'rubygems'
require 'dbi'
require 'mail'
require 'net/smtp'

#Koble til MySQL serveren/databasen
begin
dbh = DBI.connect("DBI:Mysql:calendar_app:serveren", 
	"brukernavnet","passordet")

#Registrer brukeren fra SPA-en i databasen
#Brukerdataene vil komme fra registreringssiden til slutt,
#Men bruker midlertidig vanlige SQL-verdier for å vise eksempelet

sth = dbh.prepare(INSERT INTO deltakere(fornavn,etternavn,email,telnr)
VALUES('Walter','Melon','waltermelon@mail.com',12121212))

#Kjør spørringen mot databasen
sth.execute
end

begin
#Brukeren er registrert og får en bekreftelse på mail om dette

from = "Calendar App <calendar@app.com>"
to = "Walter Melon <waltermelon@mail.com>"
subject = "Du er nå påmeldt eventet Vannmelonspising!"

emailen = <<MESSAGE_END
From: #{from}
To: #{to}
Subject: #{subject}
MIME-Version: 1.0
Content-Type: text/html

<h1>Du er nå påmeldt eventet Vannmelonspising!</h1>
<p><b>Gratulerer Walter Melon!<br /> 
Du er nå påmeldt eventet Vannmelonspising!</b><p>
<p><b>Dato og tid: </b>10. Juli 2020 kloken 16:00.</p>
<p><b>Sted: </b>Hvalstrand Bad ved stupetårnet.</p>
<p><b>Pris: </b>Gratis (0,00 kr.)</p>
<p><b>Vel møt og lykke til!</b></p>
<a href="https://calendarappURLen/ShowUser?id=1234123444&email=waltermelon@mail.com&SESSID=6DB46DV76DFB6B5B5N">
Trykk her for å gå til din brukerside på Calendarapp.</a>
MESSAGE_END

Net::SMTP.start('localhost',25) do |smtp|
  smtp.send_message emailen,'from','to'

rescue Exception => exception_feilen 
	puts "En feil oppstod: "+exception_feilen
	puts "Vennligst prøv igjen, eller kontakt administrator."

#Vis eventuelle feil
rescue DBI::DatabaseError => e 
	puts "En feil oppstod."
	puts "Feilkode:    #{e.err}"
	puts "Feilmelding: #{e.errstr}"
	puts "Vennligst prøv igjen, eller kontakt administrator."

#Koble fra MySQL serveren/databasen
ensure
     dbh.disconnect if dbh
end

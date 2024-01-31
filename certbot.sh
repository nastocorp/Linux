#!/bin/bash

# Sätt den faktiska sökvägen till certbot (beroende på din distribution och installation)
CERTBOT_PATH="/usr/bin/certbot"

# Lägg till detta för att få detaljerade spår för felsökning
set -x

# Försök att förnya certifikaten
$CERTBOT_PATH renew --quiet --force-renewal

# Kontrollera förnyelsens resultat
if [ $? -eq 0 ]; then
  # Certifikatet har förnyats
  echo "Let's Encrypt-certifikat har förnyats. Uppdatering skickad: $(date) - Certifikat förnyat" >> /var/log/certbot-log.log
else
  # Något gick fel vid förnyelsen
  echo "Fel vid förnyelse av Let's Encrypt-certifikat. Uppdatering skickad: $(date)" >> /var/log/certbot-log.log
fi

# Återställ spårningsläget till standard
set +x
    Centraliserad katalogtjänst​
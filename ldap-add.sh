#!/bin/bash

logfile="LDAPIMPORT.log"

DN="dc=pulttibois,dc=net"
admin="cn=admin,dc=pulttibois,dc=net"
pwd="Linux4Ever"
serv="ldap://127.0.0.1"
groupname="People"

if [ "$#" -ne 1 ]; then
    echo "INCORRECT # OF ARGUMENTS" >&2
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "FILE ERROR" >&2
    exit 1
fi

while IFS="," read -r name uname passwd objclass posixGroup; do
    hashpass=$(slappasswd -s $passwd)

    ldif_user=$(cat <<-END
dn: uid=${uname},ou=People,${DN}
objectClass: ${objclass}
uid: ${uname}
cn: ${uname}
sn: ${uname}
givenName: ${name}
userPassword: ${hashpass}
END
)


    
    echo "$ldif_user" | ldapadd -x -D $admin -w $pwd -H $serv | tee -a $logfile
    if [ "$?" -eq 0 ]; then
        echo $uname added successfully
    else
        echo could not add $uname
    fi 
done < "$1"

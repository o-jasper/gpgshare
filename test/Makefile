
export_pubkey: #Signatures found using `gpg --homedir dotgnupg/ --list-sigs`
	cd Mr.A/; gpg --armor --homedir dotgnupg/ --export 1E2CB837 > pubkey
	cd Mr.B/; gpg --armor --homedir dotgnupg/ --export CE7D38D3 > pubkey

import_pubkey:
	cd Mr.A/; gpg --homedir dotgnupg/ --import ../Mr.B/pubkey
	cd Mr.B/; gpg --homedir dotgnupg/ --import ../Mr.A/pubkey

default_keys:
	cd Mr.A/; gpg --default-key 1E2CB837 
	cd Mr.B/; gpg --default-key CE7D38D3

test:
	sh test.sh

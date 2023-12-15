### Usage SSH key
Start the SSH-agent in the background
```bash
eval "$(ssh-agent -s)"
```
Add the SSH Private Key. When you add it, it will ask for your passphrase.
```bash
ssh-add ~/Desktop/playground/AquaBrain-Sem1/Keys/id_ed25519
```
ssh-keygen
ssh-copy-id 10.204.100.161
ln -s `pwd`/olo/anaconda3/envs/dev `pwd`/anaconda3/envs
mkdir olo
echo 'sshfs -o follow_symlinks w@10.204.100.161:/mnt/glacier/home/w/ /home/w/olo' > sshfsolo.sh
bash sshfsolo.sh
ln -s `pwd`/olo/anaconda3/envs/dev `pwd`/anaconda3/envs
conda activate dev
echo 'conda activate dev' >> .zshrc

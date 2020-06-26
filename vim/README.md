
# Vim/Neovim tricks tips plugins macros 

## Tips
vi uses the esc key a lot. On most keyboards this is a far reach. A common practice is to convert your caps lock key to act as your esc key.

#### OS X:
  go to system preferences -> Keyboard -> Modifier Keys -> and set caps lock to escape
   

## Try it out
To see what vim is like type the following command in just about any console to get a quick 15-20 tutorial.

```
vimtutor
```

***
You can also try an online game that teaches vim as you play
```
https://vim-adventures.com/
```


### Test out neovim with a quick temporary install

Run neovim in a local directory with a single binary to try it out   ]]

Just run the following command:
```
curl https://raw.githubusercontent.com/sdunifon/ZSH-ROM-COM/dev/vim/neovim-quick-install.sh | bash
```
***
## Install
Once you deide you want to start using vim more regularly you can download neovim which is the most feature complete version of vim

### Install Mac OS X
```
brew install neovim
```

## .vimrc / init.vim
These are the files that make the magic happen. Vim starts out pretty barebones. All the customization happens in these files to take it to a full fledged IDE

These files can take hours/days/years to perfect but you don't have to create your own. The vim community offers many examples that you can just plug in and instantly transform your vim into an advanced editor.

You can start off with a premade config file and then customize as you go.
***
```Just add a .vimrc file to your home directory (for vim)```

```Or add init.vim to ~/.config/nvim/```

Then start vim. You should see the script automatically downloading and configuring the plugigs. Although some configs might need you to type

```:PlugInstall```

Once you have done this you are ready to go.
### Scotts WIP init.vim file:

[init.vim](https://gist.githubusercontent.com/sdunifon/02af8c9c09abc8e1046114e90decb419/raw/69f3ee663cecb50fb9321424c4de5ae0ff936a3b/init.vim)

### Mach 2 init.vim

https://github.com/ChristianChiarulli/nvim


function home-git

  set git_dir $HOME/.home-git
  set git_config "--git-dir=$git_dir --work-tree=$HOME"
  set green '\033[0;32m'
  set no_color '\033[0m'

  if not test -d $git_dir
    echo 'in here'
    mkdir $git_dir
    eval "git init --bare $git_dir"
    cd $git_dir
    eval "git $git_config config --local status.showUntrackedFiles no"
    cd -
    echo -e "$green home-git initialization complete! $no_color"
               echo -e "  $green------------------------------------------------------------------------------------$no_color" 
    echo -e "$green--$no_color To use your home-git repo use the command 'home-git' just like you would git command $green --$no_color"
               echo -e "  $green------------------------------------------------------------------------------------$no_color" 

    if not count $argv
      eval "git $git_config $argv"
    end

  else
    echo "git $git_config $argv"
    eval "git $git_config $argv"
  end
end

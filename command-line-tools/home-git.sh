function  home-git {
    local git_dir=$HOME/.home-git
    local git_config="--git-dir=$git_dir --work-tree=$HOME"
    local green='\033[0;32m'
    local no_color='\033[0m'

    if [ ! -d $git_dir ]; then
      mkdir $git_dir
      eval "git init --bare $git_dir"
      cd $git_dir
      eval "git $git_config config --local status.showUntrackedFiles no"
      cd -
      echo -e "${green}home-git initialization complete!${no_color}"
                 echo -e "  ${green}------------------------------------------------------------------------------------${no_color}" 
      echo -e "${green}--${no_color}To use your home-git repo use the command 'home-git' just like you would git command${green}--${no_color}"
                 echo -e "  ${green}------------------------------------------------------------------------------------${no_color}" 

      if [ ! $# -eq 0 ]; then
        eval "git $git_config $@"
      fi

    else
      eval "git $git_config $@"
    fi
}

######################################################################
#<
#
# Function: p6df::modules::ruby::deps()
#
#>
######################################################################
p6df::modules::ruby::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
    rbenv/rbenv
    rbenv/ruby-build
  )
}

######################################################################
#<
#
# Function: p6df::modules::ruby::home::symlink()
#
#  Depends:	 p6_dir p6_file
#  Environment:	 P6_DFZ_SRC_DIR P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::ruby::home::symlink() {

  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-ruby/share/.gemrc" ".gemrc"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-ruby/share/.riplrc" ".riplrc"

  p6_dir_mk "$P6_DFZ_SRC_DIR/rbenv/rbenv/plugins"
  p6_file_symlink "$P6_DFZ_SRC_DIR/rbenv/ruby-build" "$P6_DFZ_SRC_DIR/rbenv/rbenv/plugins/ruby-build"
}

######################################################################
#<
#
# Function: p6df::modules::ruby::langs()
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::ruby::langs() {

  (
    cd $P6_DFZ_SRC_DIR/rbenv/rbenv
    git pull
  )
  (
    cd $P6_DFZ_SRC_DIR/rbenv/ruby-build
    git pull
  )

  # nuke the old one
  local previous=$(rbenv install -l 2>&1 | grep -v "[a-z]" | grep "[0-9]" | tail -2 | head -1)
  rbenv uninstall -f $previous

  # get the shiny one
  local latest=$(rbenv install -l 2>&1 | grep -v "[a-z]" | grep "[0-9]" | tail -1)
  rbenv install $latest
  rbenv global $latest
  rbenv rehash

  gem install bundler
  rbenv rehash
}

######################################################################
#<
#
# Function: p6df::modules::ruby::init()
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::ruby::init() {

  p6df::modules::ruby::rbenv::init "$P6_DFZ_SRC_DIR"

  p6df::modules::ruby::prompt::init
}

######################################################################
#<
#
# Function: p6df::modules::ruby::prompt::init()
#
#>
######################################################################
p6df::modules::ruby::prompt::init() {

   p6df::core::prompt::line::add "p6_lang_prompt_info"
   p6df::core::prompt::line::add "p6_lang_envs_prompt_info"
   p6df::core::prompt::lang::line::add rb
}

######################################################################
#<
#
# Function: p6df::modules::ruby::rbenv::init(dir)
#
#  Args:
#	dir -
#
#  Environment:	 DISABLE_ENVS HAS_RBENV RBENV_ROOT
#>
######################################################################
p6df::modules::ruby::rbenv::init() {
  local dir="$1"

  [ -n "$DISABLE_ENVS" ] && return

  RBENV_ROOT=$dir/rbenv/rbenv

  if [ -x $RBENV_ROOT/bin/rbenv ]; then
    export RBENV_ROOT
    export HAS_RBENV=1

    p6_path_if $RBENV_ROOT/bin
    eval "$(p6_run_code rbenv init - zsh)"
  fi
}

######################################################################
#<
#
# Function: p6_rb_env_prompt_info()
#
#  Depends:	 p6_echo
#  Environment:	 RBENV_ROOT
#>
######################################################################
p6_rb_env_prompt_info() {

  p6_echo "rbenv_root=$RBENV_ROOT"
}

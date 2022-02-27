######################################################################
#<
#
# Function: p6df::modules::ruby::deps()
#
#>
######################################################################
p6df::modules::ruby::deps() {
  ModuleDeps=(
    p6m7g8/p6common
    rbenv/rbenv
    rbenv/ruby-build
  )
}

######################################################################
#<
#
# Function: p6df::modules::ruby::home::symlink()
#
#>
######################################################################
p6df::modules::ruby::home::symlink() {

  echo ln -fs $P6_DFZ_SRC_DIR/p6m7g8/p6df-ruby/share/.gemrc .gemrc
  echo ln -fs $P6_DFZ_SRC_DIR/p6m7g8/p6df-ruby/share/.gemrc .riplrc
  ln -fs $P6_DFZ_SRC_DIR/p6m7g8/p6df-ruby/share/.gemrc .gemrc
  ln -fs $P6_DFZ_SRC_DIR/p6m7g8/p6df-ruby/share/.gemrc .riplrc

  echo mkdir -p $P6_DFZ_SRC_DIR/rbenv/rbenv/plugins
  echo ln -fs $P6_DFZ_SRC_DIR/rbenv/ruby-build $P6_DFZ_SRC_DIR/rbenv/rbenv/plugins/ruby-build
  mkdir -p $P6_DFZ_SRC_DIR/rbenv/rbenv/plugins
  ln -fs $P6_DFZ_SRC_DIR/rbenv/ruby-build $P6_DFZ_SRC_DIR/rbenv/rbenv/plugins/ruby-build
}

######################################################################
#<
#
# Function: p6df::modules::ruby::langs()
#
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
#>
######################################################################
p6df::modules::ruby::init() {

  p6df::modules::ruby::rbenv::init "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::ruby::rbenv::init(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6df::modules::ruby::rbenv::init() {
  local dir="$1"

  [ -n "$DISABLE_ENVS" ] && return

  RBENV_ROOT=$dir/rbenv/rbenv

  if [ -x $RBENV_ROOT/bin/rbenv ]; then
    export RBENV_ROOT
    export HAS_RBENV=1

    p6df::util::path_if $RBENV_ROOT/bin
    eval "$(p6_run_code rbenv init - zsh)"
  fi
}

######################################################################
#<
#
# Function: p6df::modules::ruby::rbenv::prompt::line()
#
#>
######################################################################
p6df::modules::ruby::rbenv::prompt::line() {

  p6_echo "rbenv:\t  rbenv_root=$RBENV_ROOT"
}

######################################################################
#<
#
# Function: p6df::modules::ruby::prompt::line()
#
#>
######################################################################
p6df::modules::ruby::prompt::line() {

  p6_ruby_prompt_info
}

######################################################################
#<
#
# Function: p6_ruby_prompt_info()
#
#>
######################################################################
p6_ruby_prompt_info() {

  echo -n "rb:\t  "
  p6_lang_version "rb"
}

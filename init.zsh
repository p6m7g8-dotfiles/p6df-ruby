######################################################################
#<
#
# Function: p6df::modules::ruby::deps()
#
#>
######################################################################
p6df::modules::ruby::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-zsh
    rbenv/rbenv
    rbenv/ruby-build
    jf/rbenv-gemset
    ohmyzsh/ohmyzsh:plugins/thor
    ohmyzsh/ohmyzsh:plugins/bundler
    ohmyzsh/ohmyzsh:plugins/ruby
  )
}

######################################################################
#<
#
# Function: p6df::modules::ruby::home::symlink()
#
#  Environment:	 P6_DFZ_SRC_DIR P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::ruby::home::symlink() {

  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-ruby/share/.gemrc" ".gemrc"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-ruby/share/.riplrc" ".riplrc"

  p6_dir_mk "$P6_DFZ_SRC_DIR/rbenv/rbenv/plugins"
  p6_file_symlink "$P6_DFZ_SRC_DIR/rbenv/ruby-build" "$P6_DFZ_SRC_DIR/rbenv/rbenv/plugins/ruby-build"
  p6_file_symlink "$P6_DFZ_SRC_DIR/jf/rbenv-gemset" "$P6_DFZ_SRC_DIR/rbenv/rbenv/plugins/rbenv-gemset"
}

######################################################################
#<
#
# Function: p6df::modules::ruby::vscodes()
#
#>
######################################################################
p6df::modules::ruby::vscodes() {

  code --install-extension rebornix.ruby
  code --install-extension Shopify.ruby-lsp
  code --install-extension bung87.vscode-gemfile
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

  p6_run_dir "$P6_DFZ_SRC_DIR/rbenv/rbenv" p6_git_p6_pull
  p6_run_dir "$P6_DFZ_SRC_DIR/rbenv/ruby-build" p6_git_p6_pull
  p6_run_dir "$P6_DFZ_SRC_DIR/jf/rbenv-gemset" p6_git_p6_pull

  # nuke the old one
  local previous=$(p6df::modules::ruby::rbenv::latest::installed)
  rbenv uninstall -f $previous

  # get the shiny one
  local latest=$(p6df::modules::ruby::rbenv::latest)
  rbenv install $latest
  rbenv global $latest
  rbenv rehash

  gem install enum
  gem install bundler
  gem install guard-rspec
  gem install cucumber
  gem install gherkin
  gem install simplecov
  gem install pry
  gem install pry-stack_explorer
  gem install pry-bond
  gem install pry-coolline
  gem install pry-byebug
  gem install stackprof
  gem install bundler-audit
  gem install brakeman
  gem install fasterer
  gem install reek
  gem install rubocop
  gem install sorbet-runtime
  gem install sorbet

  rbenv rehash

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::ruby::rbenv::latest()
#
#>
######################################################################
p6df::modules::ruby::rbenv::latest() {

  rbenv install -l 2>&1 | grep "^[0-9]" |  p6_filter_last "1"
}

######################################################################
#<
#
# Function: p6df::modules::ruby::rbenv::latest::installed()
#
#>
######################################################################
p6df::modules::ruby::rbenv::latest::installed() {

  rbenv install -l 2>&1 | p6_filter_select "[a-z]" | p6_filter_select "[0-9]" | p6_filter_last "1"
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

  p6df::core::lang::mgr::init "$P6_DFZ_SRC_DIR/rbenv/rbenv" "rb"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rb::env::prompt::info()
#
#  Environment:	 RBENV_ROOT
#>
######################################################################
p6df::modules::rb::env::prompt::info() {

  local gemset=$(rbenv gemset active 2>&1 | awk '{print $1}' | grep -v rbenv)
  local gem_home=$(gem env home)

  if p6_string_eq "no active gemsets" "$gemset" || p6_string_eq "no" "$gemset"; then
    p6_echo "rbenv_root:\t  $RBENV_ROOT"
    p6_echo "gem_home:\t  $gem_home"
  else
    p6_echo "rbenv_root:\t  $RBENV_ROOT"
    p6_echo "gem_home:\t  $gem_home"
    p6_echo "gemset:\t\t  $gemset"
  fi
}

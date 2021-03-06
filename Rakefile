# -*- coding: utf-8 -*-
require 'rake/clean'

HOME = ENV["HOME"]
OS = `uname`

GIT_ROOT   =  File.join(File.dirname(__FILE__), "git")
ZSH_ROOT   =  File.join(File.dirname(__FILE__), "zsh")
ETC_ROOT   =  File.join(File.dirname(__FILE__), "etc")
TMUX_ROOT  =  File.join(File.dirname(__FILE__), "tmux")
SLATE_ROOT =  File.join(File.dirname(__FILE__), "slate")
FONT_ROOT  =  File.join(File.dirname(__FILE__), "stuff", "fonts")

ZSH_DOT_FILES  =  %w{ zshrc.global zshrc.function zshrc.alias zshrc.osx zshrc.linux }
ETC_DOT_FILES  =  Dir.glob("etc" +  "/*").map{|path| File.basename(path)}

cleans = [
          ".emacs.d",
          ".zsh",
          ".zshrc",
          ".oh-my-zsh",
          ".tmux.conf",
          ".tmux-powerline",
          ".tmux-powerlinerc",
          ".gitconfig",
          ".gitignore.global",
          ".gemrc",
          ".slate",
          ".slate.js"
         ]

CLEAN.concat(cleans.map{|c| File.join(HOME,c)})

task :default => :all
task :all => ["emacs:link", "git:link","tmux:link","zsh:link", "font:link", "slate:link","etc:link"]

namespace :emacs do
  desc "Create symbolic link to HOME"
  task :link do
    org = File.join(HOME, ".emacs.d")
    mv org, File.join(HOME, ".emacs.d.org") if File.exist?(org) && !File.symlink?(org) 
    symlink_ File.join(File.dirname(__FILE__), "emacs.d"), File.join(HOME,".emacs.d")
  end
end

namespace :git do
  desc "Create symbolic link to HOME"
  task :link => File.join(HOME,".gitconfig.local") do    
    same_name_symlinks GIT_ROOT, ["gitconfig", "gitignore.global"]
  end

  desc "Create copy of gitconfig.local"
  file File.join(HOME, ".gitconfig.local") do
    cp File.join(GIT_ROOT,"gitconfig.local"), File.join(HOME,".gitconfig.local")
  end
end

namespace :tmux do  
  desc "Create symblic link to HOME"
  task :link => File.join(HOME,".tmux-powerline") do
    same_name_symlinks TMUX_ROOT, ["tmux.conf", "tmux-powerlinerc"]
    symlink_ File.join(TMUX_ROOT,"tmux-powerline-theme.sh"), File.join(HOME, ".tmux-powerline/themes/mytheme.sh")
  end
  
  desc "Download tmux-powerline"
  file File.join(HOME,".tmux-powerline") do |f|
    sh "git clone https://github.com/erikw/tmux-powerline.git #{f.name}"
  end
end

namespace :zsh do
  desc "Create symbolic link to HOME/.zsh"
  task :link => [File.join(HOME,".oh-my-zsh"), File.join(HOME,".zsh")] do
    ZSH_DOT_FILES.each do |f|
      symlink_ File.join(ZSH_ROOT,f), File.join(HOME, ".zsh", f)
    end
    
    org = File.join(HOME, ".zshrc")
    mv org, File.join(HOME, ".zshrc.org") if File.exist?(org) && !File.symlink?(org)
    symlink_ File.join(ZSH_ROOT, "zshrc"), File.join(HOME, ".zshrc")
    symlink_ File.join(ZSH_ROOT, "oh-my-zsh-theme","tc.zsh-theme"), File.join(HOME,".oh-my-zsh","themes","tc.zsh-theme")
  end
  
  desc "Download oh-my-zsh"
  file File.join(HOME,".oh-my-zsh") do |f|
    sh "git clone https://github.com/robbyrussell/oh-my-zsh.git #{f.name}"
  end

  file File.join(HOME, ".zsh") do |f|
    mkdir f.name
  end
end

namespace :slate do
  desc "Create symbolic link"
  task :link do
    same_name_symlinks SLATE_ROOT, ["slate", "slate.js"] if OS =~ /^Darwin/
  end
end

namespace :font do
  desc "Create symbolic link"
  task :link do
    case OS
    when /^Darwin/
      cp Dir.glob(FONT_ROOT + "/*\.*"), File.join(HOME, "Library","Fonts")
    when /^Linux/
      symlink_ FONT_ROOT, File.join(HOME, ".fonts")
    end
  end
end

namespace :etc do
  task :link do
    same_name_symlinks ETC_ROOT, ETC_DOT_FILES
  end
end

def symlink_ file, dest
  symlink file, dest if not File.exist?(dest)
end

def same_name_symlinks root, files
  files.each do |file|
    symlink_ File.join(root, file), File.join(HOME, "." + file)
  end
end

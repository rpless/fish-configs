function add_to_path --description 'Persist absolute directory to path'
  set --universal fish_user_paths $fish_user_paths $argv
end

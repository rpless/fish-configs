function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l last_status $status

  set -l b0 (set_color BF616A) # red
  set -l b1 (set_color A3BE8c) # green
  set -l b2 (set_color EBCB8B) # yellow
  set -l b3 (set_color 8FA1B3) # blue
  set -l b4 (set_color B48EAD) # purple
  set -l b5 (set_color 96B5B4) # teal
  set -l b6 (set_color C0C5Ce) # slate

  set -l cwd $b4(pwd)

  # Print pwd or full path
  echo -n -s $cwd $b6

  # Show git branch and status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set -l git_status_color $b5

    if [ (_git_is_dirty) ]
      set git_status_color $b0
    end
    echo -n -s $git_status_color " ($git_branch)" $b6
  end

  set -l prompt_color $b0
  if test $last_status = 0
    set prompt_color $b6
  end

  # Terminate with a nice prompt char
  echo -e -n -s $prompt_color '> ' $b6
end

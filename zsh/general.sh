mycd() {
  \cd "$@"
  [ -n "$TMUX" ] && tmux set-environment -g PWD $PWD
}

killp() {

  if [ $# -eq 0 ]; then
    echo "The command killp() needs an argument, but none was provided!"
    return
  else
    pes=$1
  fi

  for child in $(ps -o pid,ppid -ax | \
    awk "{ if ( \$2 == $pes ) { print \$1 }}")
    do
      # echo "Killing child process $child because ppid = $pes"
      killp $child
    done

# echo "killing $1"
kill -9 "$1" > /dev/null 2> /dev/null
}

# running new tmux (or attaching) with session name derived from parent zsh pid
runTmux() {

  SESSION_NAME="T$PPID"

  # try to find session with the correct session id (based on the zsh PID)
  EXISTING_SESSION=`$TMUX_BIN ls 2> /dev/null | grep "$SESSION_NAME" | wc -l`

  if [ "$EXISTING_SESSION" -gt "0" ]; then

    # if such session exists, attach to it
    $TMUX_BIN -2 attach-session -t "$SESSION_NAME"

  else

    # if such session does not exist, create it
    $TMUX_BIN new-session -s "$SESSION_NAME"

  fi

  # hook after exitting the session
  # when the session exists, find a file in /tmp with the name of the session
  # and extract a path from it. Then cd to it.
  FILENAME="/tmp/tmux_restore_path.txt"
  if [ -f $FILENAME ]; then

    MY_PATH=$(tail -n 1 $FILENAME)

    rm /tmp/tmux_restore_path.txt

    cd $MY_PATH

  fi
}

forceKillTmuxSession() {

  num=`$TMUX_BIN ls 2> /dev/null | grep "$1" | wc -l`
  if [ "$num" -gt "0" ]; then

    pids=`tmux list-panes -s -t "$1" -F "#{pane_pid} #{pane_current_command}" | grep -v tmux | awk '{print $1}'`

    for pid in "$pids"; do
      killp "$pid"
    done

    $TMUX_BIN kill-session -t "$1"

  fi
}

quitTmuxSession() {

  if [ ! -z "$TMUX" ]; then

    echo "killing session"
    pids=`tmux list-panes -s -F "#{pane_pid} #{pane_current_command}" | grep -v tmux | awk {'print $1'}`

    for pid in $pids; do
      killp "$pid" &
    done

    SESSION_NAME=`tmux display-message -p '#S'`
    tmux kill-session -t "$SESSION_NAME"

  else

    exit

  fi
}

zshexit() {

  pwd >> /tmp/tmux_restore_path.txt

  forceKillTmuxSession "T$PPID"
}

# VIM alias for running vim in tmux and in servermode
runVim() {

  VIM_CMD=$(echo "$EDITOR ${@}")

  # if the tmux session does not exist, create new and run vim in it
  if [ -z $TMUX ]; then

    SESSION_NAME="T$PPID"

    # if there is a tmux session with the same name as the current bashpid
    num=`$TMUX_BIN ls 2> /dev/null | grep "$SESSION_NAME" | wc -l`
    if [ "$num" -gt "0" ]; then

      ID=`$TMUX_BIN new-window -t "$SESSION_NAME" -a -P`
      sleep 1.0
      $TMUX_BIN send-keys -t $ID "$VIM_CMD" C-m
      $TMUX_BIN -2 attach-session -t "$SESSION_NAME"

    else

      $TMUX_BIN new-session -s "$SESSION_NAME" -d "$VIM_CMD" \; attach

    fi

  else

    zsh -c "$VIM_CMD"

  fi
}

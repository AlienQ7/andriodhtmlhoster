kill_server() {
  if pkill -9 php; then
    echo -e "\033[32m\t\t⟨ Server Killed ⟩\033[0m"
  else
    echo -e "\033[33m\t\t⟨ No PHP server found to kill ⟩\033[0m"
  fi
}

while true; do
  echo ""
  echo -e "\033[31m\t⟨\033[32m Always Kill The Server When Your Done!!\033[31m ⟩\033[0m"
  echo -e "\033[1;31m"
  echo -e "\t\t       █ █ ▀█▀ █▄█ █        "
  echo -e "\t\t       █▀█  █  █ █ █        "
  echo -e "\t\t       ▀ ▀  ▀  ▀ ▀ ▀▀▀      "
  echo -e "\t\t   █ █ █▀█ █▀▀ ▀█▀ █▀▀ █▀▄  "
  echo -e "\t\t   █▀█ █ █ ▀▀█  █  █▀▀ █▀▄  "
  echo -e "\t\t   ▀ ▀ ▀▀▀ ▀▀▀  ▀  ▀▀▀ ▀ ▀  "
  echo -e "\t\t⟨ Ctrl+c to Exit the Program ⟩\033[0m"
  echo ""

  read -p $'\e[1;32mEnter HTML File Name:\e[34m ' filename

  if [[ -z "$filename" ]]; then
    echo -e "\033[31mError: File name cannot be empty.\033[0m"
    continue
  fi

  if [[ ! "$filename" =~ \.html$ ]]; then
    echo -e "\033[31mError: Please provide a valid .html file name.\033[0m"
    continue
  fi

  if [[ ! -f "$filename" ]]; then
    echo -e "\033[31mError: File '$filename' not found.\033[0m"
    continue
  fi

  echo ""
  read -p $'\e[1;32mHost the server now (y/n):\e[34m ' host

  if [[ "$host" == "y" ]]; then
    if ! command -v php &> /dev/null; then
      echo -e "\033[31mError: PHP is not installed.\033[0m"
      continue
    fi
    php -S localhost:8080 &
    if ! am start -a android.intent.action.VIEW -d http://127.0.0.1:8080/"$filename" &> /dev/null; then
      echo -e "\033[31mWarning: Could not open in Android. Make sure ADB is set up.\033[0m"
    fi

  else
    echo -e "\033[31mServer not started. Exiting the loop.\033[0m"
    break
  fi

  echo ""
  read -p $'\e[33m   ⟨Type "\e[1;35mk\e[33m" Hit ENTER to kill Server ⟩\e[1;31m     ' kill

  if [[ "$kill" == "k" ]]; then
    kill_server
  fi
done

echo -e "\033[32mProgram Exited\033[0m"

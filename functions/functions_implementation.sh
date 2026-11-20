login_user (){
    logged_in=false 
attempts=0 
while [[ $logged_in == false && $attempts -lt 3 ]]
  do 
      read -p "Enter the Username :  " Username
      read -sp "Enter the Password :  " Password 
      echo
     if [[ $Username == "Alaa" && $Password == "12345" ]] ; then 
           logged_in=true 
     else 
     ((attempts++))
     echo " remaining attempts is $((3-attempts))"
     fi 
  done 
   if [[ $logged_in == true ]] ; then 
    echo " Welcome Back "
    return 0
 else 
 echo "Access Denied  "
  return 1 
    fi
}
create_file() {
    read -p "Enter file name: " filename

    if [[ -e "$filename" ]]; then
        echo "File already exists"
    else
        touch "$filename"
        echo "File created successfully"
    fi
}
create_folder() {
    read -p "Enter folder name: " foldername

    if [[ -e "$foldername" ]]; then
        echo "Folder already exists"
    else
        mkdir "$foldername"
        echo "Folder created successfully"
    fi
}
list_files() {
    echo "========== DIRECTORY CONTENTS =========="
    ls -lah
}
search_file() {
     read -p "Enter file name to search : " filename
      result=$(find .  -type f -iname "$filename")
      if [[ -n "$result" ]]; then
       echo " File Found :  " 
       echo "$result"
       else 
       echo " File Not Found "
       fi
}
copy_file() {
    read -p "Enter source file path: " source
    read -p "Enter destination path: " destination

    if [[ ! -f "$source" ]]; then
        echo "Source file not found"
    elif [[ -e "$destination" ]]; then
        read -p "Destination exists. Overwrite? (y/n): " confirm

        if [[ "$confirm" == "y" ]]; then
          cp "$source" "$destination"
          echo "File copied successfully"
        else
            echo "Copy cancelled"
        fi
    else
        cp "$source" "$destination"
        echo "File copied successfully"
    fi
}
move_file() {
    read -p "Enter source file path: " source
    read -p "Enter destination path: " destination

    if [[ ! -f "$source" ]]; then
        echo "Source file not found"

    elif [[ -e "$destination" ]]; then
        echo "Destination already exists"

    else
        mv "$source" "$destination"
        echo "File moved/renamed successfully"
    fi
}
delete_file() {
    read -p "Enter file path to delete: " filename

    if [[ ! -f "$filename" ]]; then
        echo "File not found"
    else
        read -p "Are you sure you want to delete this file? (y/n): " confirm

        if [[ "$confirm" == "y" ]]; then
            rm "$filename"
            echo "File deleted successfully"
        else
            echo "Deletion cancelled"
        fi
    fi
}
backup_folder() {
    read -p "Enter folder path to backup: " source_dir
    if [[ ! -d "$source_dir" ]]; then
        echo "Folder not found"
        return 1
    fi

    source_path="$(cd "$source_dir" && pwd)"
    backup_path="$SCRIPT_DIR/Backups"

    mkdir -p "$backup_path"

    backup_path="$(cd "$backup_path" && pwd)"

    if [[ "$source_path" == "$backup_path" ]]; then
        echo "Cannot backup the Backups folder"
        return 1
    fi

    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    folder_name=$(basename "$source_path")
    backup_name="${folder_name}_backup_${timestamp}"

    if cp -r "$source_path" "$backup_path/$backup_name"; then
        echo "Backup created successfully"
        echo "Backup location: $backup_path/$backup_name"
    else
        echo "Backup failed"
        return 1
    fi
}
file_statistics() {
    read -p "Enter file path to show statistics : " filename
     if [[ ! -f "$filename" ]]; then
        echo "File not found"
    else
lines=$(wc -l < "$filename")
words=$(wc -w < "$filename")
char_number=$(wc -m < "$filename")
size=$(du -h "$filename" | cut -f1)
echo " ========== FILE STATISTICS =========="
echo "Lines: ${lines} "
echo "Words: ${words} "
echo "Characters: ${char_number} "
echo "Size: ${size} "
    fi
}

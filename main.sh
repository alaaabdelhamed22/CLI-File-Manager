SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/functions/functions_implementation.sh"
if login_user ; then 
   while true
do
    echo "========== FILE MANAGER =========="
    echo "1. Create File"
    echo "2. Create Folder"
    echo "3. List Files"
    echo "4. Search File"
    echo "5. Copy File"
    echo "6. Move / Rename File"
    echo "7. Delete File"
    echo "8. Backup Folder"
    echo "9. File Statistics"
    echo "0. Exit"

    read -p "Choose an option: " choice

    case $choice in
        1) create_file ;;
        2) create_folder ;;
        3) list_files ;;
        4) search_file;;
        5) copy_file ;;
        6) move_file ;;
        7) delete_file ;;
        8) backup_folder ;;
        9) file_statistics;;
        0) echo "Goodbye"; break ;;
        *) echo "Invalid Option" ;;
    esac
done
   else 
   echo " Goodbye "
fi
#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

# Arrays for tags and files
declare -a tagsArray
declare -a filesArray

# Function to add or append files to arrays
add_or_append() {
    local newtag="$1"
    local newfile="$2"
    for i in "${!tagsArray[@]}"; do
        if [[ "${tagsArray[i]}" == "$newtag" ]]; then
            filesArray[i]+="$newfile "
            echo filesArray[i]
            return
        fi
    done
    tagsArray+=("$newtag")
    filesArray+=("$newfile ")
}

# Collect posts and their tags
find _posts -name '*.md' | while IFS= read -r file; do
    if [ -f "$file" ]; then
        book_status=$(sed -n '/^book: false/p' "$file")
        if [ -z "$book_status" ]; then  # Only proceed if 'book: false' is not found
            tag=$(sed -n -e 's/^tags: \[\(.*\)\]/\1/p' "$file")
            tag=${tag^^}  # Convert tag to uppercase
            add_or_append "$tag" "$file"
        fi
    fi
done

# Process each tag and associated files
for i in "${!tagsArray[@]}"; do
    tag="${tagsArray[i]}"
    echo "Processing tag: $tag"
    echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n\\begin{center}\n# $tag\n\\end{center}\n" >> "$output"
    files="${filesArray[i]}"
    for file in $files; do
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n# $title\n\n" >> "$output"
        sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"  # Strip YAML front matter
        echo -e "\n\n\\\\newpage\n\n" >> "$output"
    done
done
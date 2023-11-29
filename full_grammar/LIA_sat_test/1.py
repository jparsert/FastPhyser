import os
import re

def replace_text_in_file(file_path, old_text, new_text):
    with open(file_path, 'r') as file:
        file_content = file.read()

    updated_content = re.sub(re.escape(old_text), new_text, file_content)

    with open(file_path, 'w') as file:
        file.write(updated_content)

def replace_in_files(directory_path, file_extension, old_text, new_text):
    for root, dirs, files in os.walk(directory_path):
        for file_name in files:
            if file_name.endswith(file_extension):
                file_path = os.path.join(root, file_name)
                replace_text_in_file(file_path, old_text, new_text)
                print(f'Replaced in {file_path}')

# Replace (div Start Start) to (div Start Const) in every .sl file
replace_in_files('.', '.sl', '(div Start Start)', '(div Start Const)')


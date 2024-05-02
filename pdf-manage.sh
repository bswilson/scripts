#!/bin/bash

# pdf-manage.sh script to split up, decrypte, and recombine files.
# Created by bswilson@gmail.com
# Updated last on 2 May 2024

# Required programs and libraries are:
# pdfseparate - Provided by package "poppler-utils".
# pdunite - Provided by package "poppler-utils".
# qpdf - Provided by package "qpdf" and some related dependancies.

# Function to prompt user for input
prompt_input() {
    read -p "$1: " input
    echo "$input"
}

# Prompt user for input file name
input_file=$(prompt_input "Enter the name of the original PDF file")

# Prompt user for page range to split
page_start=$(prompt_input "Enter the START of page range to split (e.g., 1)")
page_stop=$(prompt_input "Enter the LAST page of range to split (e.g., 5)")

# Prompt user for output file name for the final combined PDF
output_combined=$(prompt_input "Enter the name of the final combined PDF file")

# Split the PDF into individual pages
pdfseparate -f $page_start -l $page_stop "$input_file" page_%04d.pdf

# Decrypt the separate PDF files
for file in page_*.pdf; do
    qpdf --decrypt "$file" "${file%.pdf}_decrypted.pdf"
done

# Combine the decrypted PDF files into one
pdfunite page_*_decrypted.pdf "$output_combined"

# Clean up intermediate files
rm page_*.pdf

echo " "
echo "PDF splitting, decryption, and recombination complete."

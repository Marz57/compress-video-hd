#!/bin/bash

# Minta input nama file
read -p "Masukkan nama file video (misal: video.mp4): " input_file

# Cek apakah file ada
if [[ ! -f "$input_file" ]]; then
  echo "File '$input_file' tidak ditemukan!"
  exit 1
fi

# Ambil nama tanpa ekstensi
filename="${input_file%.*}"
extension="${input_file##*.}"
output_file="${filename}_smooth.${extension}"

# Jalankan ffmpeg (ubah bagian "scale=-2:1080" hanya 1080 nya aja ubah ke resolusi berapa yang kalian mau)
ffmpeg -i "$input_file" -vf "scale=-2:1080,fps=24" -c:v libx264 -preset veryfast -b:v 800k -an "$output_file"

# Cek apakah ffmpeg berhasil
if [[ $? -eq 0 ]]; then
  echo "Konversi berhasil. Menghapus file lama: $input_file"
  rm "$input_file"
else
  echo "Konversi gagal. File asli tidak dihapus."
fi

import urllib.request
import os
import re
import sys

def download_video(video_id, destination_directory):
    video_info_url = f"http://www.youtube.com/get_video_info?video_id={video_id}"
    response = urllib.request.urlopen(video_info_url)
    video_info = response.read().decode("utf-8")
    video_info_dict = parse_video_info(video_info)
    download_url = get_download_url(video_info_dict)
    if download_url:
        download_video_from_url(download_url, destination_directory)

def parse_video_info(video_info):
    video_info_dict = {}
    video_info_list = video_info.split("&")
    for item in video_info_list:
        key, value = item.split("=")
        video_info_dict[key] = value
    return video_info_dict

def get_download_url(video_info_dict):
    fmt_url_map = video_info_dict.get("fmt_url_map", "")
    formats = fmt_url_map.split(",")
    for fmt in formats:
        fmt_pieces = fmt.split("|")
        if len(fmt_pieces) == 2:
            piece_format = int(fmt_pieces[0])
            if piece_format == 18:
                return fmt_pieces[1]
    return None

def download_video_from_url(download_url, destination_directory):
    response = urllib.request.urlopen(download_url)
    file_name = os.path.basename(download_url)
    file_path = os.path.join(destination_directory, file_name)
    with open(file_path, "wb") as file:
        file.write(response.read())

def main():
    if len(sys.argv) < 3:
        print("Error: Missing video id and/or destination directory.")
        print("Usage: python JavaYoutubeDownloader.py VIDEO_ID DESTINATION_DIRECTORY")
        sys.exit(-1)
    
    video_id = sys.argv[1]
    destination_directory = sys.argv[2]
    download_video(video_id, destination_directory)

if __name__ == "__main__":
    main()



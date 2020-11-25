# transcode-fansubs

GitHub: https://github.com/jerieljan/transcode-fansubs

Docker: https://hub.docker.com/r/jerieljan/transcode-fansubs

## Description

This Docker image uses `ffmpeg` to convert all files in the provided directory to h265 `-crf 24` quality.

Recommended for those who want to shrink down the file sizes of their video files encoded in h264, while having a good balance of quality (at least from what I can tell, the quality loss is barely noticeable)

## Warnings

- Once run, this will loop through all files in the `/data` directory, run `ffmpeg` and if successful, will *remove* your original file. It'll only do this if the transcode was successful, but keep this in mind.

- It's not advisable to rerun the script from a failed state, since you'll end up transcoding successful files again. Maybe I'll work on that—it should be easy to fix in the script.

- I intentionally used CPU only for transcoding because there's a dip in quality when using GPU encoders like `NVENC`. With that said, if you're not used to transcoding before, this process takes a long time, and usually takes as long as playing the video file itself (or longer, if your CPU isn't powerful enough)

## Usage

```bash
# Run this image to the current directory.
# Mind the warning! It'll remove your original files after a successful transcode.

docker run -v $(pwd):/data \
             -it --rm \
             jerieljan/transcode-fansubs:1.0
```

## Building

```bash
# Simply clone the repo and run `docker build`.

git clone git@github.com:jerieljan/transcode-fansubs.git
cd transcode-fansubs
docker build -d transcode-fansubs .
```
